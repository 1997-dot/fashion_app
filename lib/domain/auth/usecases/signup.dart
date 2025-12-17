import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'package:fashion_app/core/errors/failures.dart';
import 'package:fashion_app/core/usecases/usecase.dart';
import 'package:fashion_app/domain/auth/entities/user.dart';
import 'package:fashion_app/domain/auth/repositories/auth_repository.dart';

/// Sign Up Use Case
/// Handles the business logic for user registration
class SignUpUseCase extends UseCase<User, SignUpParams> {
  final AuthRepository repository;

  SignUpUseCase({required this.repository});

  @override
  Future<Either<Failure, User>> call(SignUpParams params) async {
    return await repository.signUp(
      name: params.name,
      email: params.email,
      password: params.password,
    );
  }
}

/// Parameters for SignUpUseCase
class SignUpParams extends Equatable {
  final String name;
  final String email;
  final String password;

  const SignUpParams({
    required this.name,
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [name, email, password];
}
