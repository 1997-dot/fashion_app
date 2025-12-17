import 'package:equatable/equatable.dart';

/// Base class for all auth events
abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

/// Sign In Event
/// Triggered when user attempts to sign in
class SignInEvent extends AuthEvent {
  final String email;
  final String password;

  const SignInEvent({
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [email, password];
}

/// Sign Up Event
/// Triggered when user attempts to sign up
class SignUpEvent extends AuthEvent {
  final String name;
  final String email;
  final String password;

  const SignUpEvent({
    required this.name,
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [name, email, password];
}

/// Sign Out Event
/// Triggered when user wants to sign out
class SignOutEvent extends AuthEvent {
  const SignOutEvent();
}

/// Get Current User Event
/// Triggered to fetch current user data
class GetCurrentUserEvent extends AuthEvent {
  const GetCurrentUserEvent();
}

/// Check Auth Status Event
/// Triggered to check if user is signed in
class CheckAuthStatusEvent extends AuthEvent {
  const CheckAuthStatusEvent();
}
