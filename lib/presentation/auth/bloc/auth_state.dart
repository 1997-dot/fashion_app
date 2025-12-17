import 'package:equatable/equatable.dart';
import 'package:fashion_app/domain/auth/entities/user.dart';

/// Base class for all auth states
abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

/// Initial State
/// Starting state before any auth action
class AuthInitial extends AuthState {
  const AuthInitial();
}

/// Loading State
/// Shown during sign in, sign up, or other auth operations
class AuthLoading extends AuthState {
  const AuthLoading();
}

/// Authenticated State
/// User is successfully signed in
class Authenticated extends AuthState {
  final User user;

  const Authenticated({required this.user});

  @override
  List<Object?> get props => [user];
}

/// Unauthenticated State
/// User is not signed in
class Unauthenticated extends AuthState {
  const Unauthenticated();
}

/// Auth Error State
/// An error occurred during auth operation
class AuthError extends AuthState {
  final String message;
  final Map<String, String>? fieldErrors;

  const AuthError({
    required this.message,
    this.fieldErrors,
  });

  /// Get error for specific field
  String? getFieldError(String fieldName) {
    return fieldErrors?[fieldName];
  }

  /// Check if has field errors
  bool get hasFieldErrors => fieldErrors != null && fieldErrors!.isNotEmpty;

  @override
  List<Object?> get props => [message, fieldErrors];
}

/// Sign Out Success State
/// User successfully signed out
class SignOutSuccess extends AuthState {
  const SignOutSuccess();
}
