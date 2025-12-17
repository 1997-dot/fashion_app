import 'package:dartz/dartz.dart';
import 'package:fashion_app/core/errors/failures.dart';
import 'package:fashion_app/domain/auth/entities/user.dart';

/// Authentication Repository Interface
/// Defines the contract for authentication operations
/// Implementation will be in the data layer
abstract class AuthRepository {
  /// Sign in with email and password
  /// Returns Either<Failure, User>
  /// - Left: Failure if sign in fails
  /// - Right: User if sign in succeeds
  Future<Either<Failure, User>> signIn({
    required String email,
    required String password,
  });

  /// Sign up with name, email, and password
  /// Returns Either<Failure, User>
  /// - Left: Failure if sign up fails
  /// - Right: User if sign up succeeds
  Future<Either<Failure, User>> signUp({
    required String name,
    required String email,
    required String password,
  });

  /// Sign out the current user
  /// Returns Either<Failure, void>
  /// - Left: Failure if sign out fails
  /// - Right: void if sign out succeeds
  Future<Either<Failure, void>> signOut();

  /// Get the currently authenticated user
  /// Returns Either<Failure, User>
  /// - Left: Failure if no user is authenticated or fetch fails
  /// - Right: User if user is authenticated
  Future<Either<Failure, User>> getCurrentUser();

  /// Check if user is signed in
  /// Returns Either<Failure, bool>
  /// - Left: Failure if check fails
  /// - Right: bool (true if signed in, false otherwise)
  Future<Either<Failure, bool>> isSignedIn();
}
