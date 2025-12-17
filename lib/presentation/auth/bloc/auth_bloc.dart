import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fashion_app/core/errors/failures.dart';
import 'package:fashion_app/core/usecases/usecase.dart';
import 'package:fashion_app/domain/auth/usecases/get_current_user.dart';
import 'package:fashion_app/domain/auth/usecases/is_signed_in.dart';
import 'package:fashion_app/domain/auth/usecases/signin.dart';
import 'package:fashion_app/domain/auth/usecases/signout.dart';
import 'package:fashion_app/domain/auth/usecases/signup.dart';
import 'package:fashion_app/presentation/auth/bloc/auth_event.dart';
import 'package:fashion_app/presentation/auth/bloc/auth_state.dart';

/// Authentication BLoC
/// Manages authentication state and business logic
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignInUseCase signInUseCase;
  final SignUpUseCase signUpUseCase;
  final SignOutUseCase signOutUseCase;
  final GetCurrentUserUseCase getCurrentUserUseCase;
  final IsSignedInUseCase isSignedInUseCase;

  AuthBloc({
    required this.signInUseCase,
    required this.signUpUseCase,
    required this.signOutUseCase,
    required this.getCurrentUserUseCase,
    required this.isSignedInUseCase,
  }) : super(const AuthInitial()) {
    // Register event handlers
    on<SignInEvent>(_onSignIn);
    on<SignUpEvent>(_onSignUp);
    on<SignOutEvent>(_onSignOut);
    on<GetCurrentUserEvent>(_onGetCurrentUser);
    on<CheckAuthStatusEvent>(_onCheckAuthStatus);
  }

  /// Handle Sign In Event
  Future<void> _onSignIn(
    SignInEvent event,
    Emitter<AuthState> emit,
  ) async {
    // Emit loading state
    emit(const AuthLoading());

    // Call sign in use case
    final result = await signInUseCase(
      SignInParams(
        email: event.email,
        password: event.password,
      ),
    );

    // Handle result
    result.fold(
      (failure) {
        // Extract field errors if it's a server failure with validation errors
        Map<String, String>? fieldErrors;
        if (failure is ServerFailure && failure.validationErrors != null) {
          fieldErrors = {};
          failure.validationErrors!.forEach((field, errors) {
            if (errors.isNotEmpty) {
              fieldErrors![field] = errors.first;
            }
          });
        }

        // Emit error state
        emit(AuthError(
          message: failure.message,
          fieldErrors: fieldErrors,
        ));
      },
      (user) {
        // Emit authenticated state
        emit(Authenticated(user: user));
      },
    );
  }

  /// Handle Sign Up Event
  Future<void> _onSignUp(
    SignUpEvent event,
    Emitter<AuthState> emit,
  ) async {
    // Emit loading state
    emit(const AuthLoading());

    // Call sign up use case
    final result = await signUpUseCase(
      SignUpParams(
        name: event.name,
        email: event.email,
        password: event.password,
      ),
    );

    // Handle result
    result.fold(
      (failure) {
        // Extract field errors if it's a server failure with validation errors
        Map<String, String>? fieldErrors;
        if (failure is ServerFailure && failure.validationErrors != null) {
          fieldErrors = {};
          failure.validationErrors!.forEach((field, errors) {
            if (errors.isNotEmpty) {
              fieldErrors![field] = errors.first;
            }
          });
        }

        // Emit error state
        emit(AuthError(
          message: failure.message,
          fieldErrors: fieldErrors,
        ));
      },
      (user) {
        // Emit authenticated state
        emit(Authenticated(user: user));
      },
    );
  }

  /// Handle Sign Out Event
  Future<void> _onSignOut(
    SignOutEvent event,
    Emitter<AuthState> emit,
  ) async {
    // Emit loading state
    emit(const AuthLoading());

    // Call sign out use case
    final result = await signOutUseCase(const NoParams());

    // Handle result
    result.fold(
      (failure) {
        // Emit error state
        emit(AuthError(message: failure.message));
      },
      (_) {
        // Emit unauthenticated state
        emit(const Unauthenticated());
      },
    );
  }

  /// Handle Get Current User Event
  Future<void> _onGetCurrentUser(
    GetCurrentUserEvent event,
    Emitter<AuthState> emit,
  ) async {
    // Emit loading state
    emit(const AuthLoading());

    // Call get current user use case
    final result = await getCurrentUserUseCase(const NoParams());

    // Handle result
    result.fold(
      (failure) {
        // Emit error state or unauthenticated if auth failure
        if (failure is AuthFailure) {
          emit(const Unauthenticated());
        } else {
          emit(AuthError(message: failure.message));
        }
      },
      (user) {
        // Emit authenticated state
        emit(Authenticated(user: user));
      },
    );
  }

  /// Handle Check Auth Status Event
  Future<void> _onCheckAuthStatus(
    CheckAuthStatusEvent event,
    Emitter<AuthState> emit,
  ) async {
    // Call is signed in use case
    final result = await isSignedInUseCase(const NoParams());

    // Handle result
    result.fold(
      (failure) {
        // Emit unauthenticated on failure
        emit(const Unauthenticated());
      },
      (isSignedIn) {
        if (isSignedIn) {
          // If signed in, get current user
          add(const GetCurrentUserEvent());
        } else {
          // Emit unauthenticated
          emit(const Unauthenticated());
        }
      },
    );
  }
}
