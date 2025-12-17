import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'package:fashion_app/core/errors/failures.dart';
import 'package:fashion_app/core/usecases/usecase.dart';
import 'package:fashion_app/domain/auth/entities/user.dart';
import 'package:fashion_app/domain/auth/repositories/auth_repository.dart';

/// Sign In Use Case
/// Handles the business logic for user sign in
class SignInUseCase extends UseCase<User, SignInParams> {
  final AuthRepository repository;

  SignInUseCase({required this.repository});

  @override
  Future<Either<Failure, User>> call(SignInParams params) async {
    return await repository.signIn(
      email: params.email,
      password: params.password,
    );
  }
}

/// Parameters for SignInUseCase
class SignInParams extends Equatable {
  final String email;
  final String password;

  const SignInParams({
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [email, password];
}
