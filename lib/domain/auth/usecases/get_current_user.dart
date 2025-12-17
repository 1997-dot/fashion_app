import 'package:dartz/dartz.dart';

import 'package:fashion_app/core/errors/failures.dart';
import 'package:fashion_app/core/usecases/usecase.dart';
import 'package:fashion_app/domain/auth/entities/user.dart';
import 'package:fashion_app/domain/auth/repositories/auth_repository.dart';

/// Get Current User Use Case
/// Retrieves the currently authenticated user
class GetCurrentUserUseCase extends UseCase<User, NoParams> {
  final AuthRepository repository;

  GetCurrentUserUseCase({required this.repository});

  @override
  Future<Either<Failure, User>> call(NoParams params) async {
    return await repository.getCurrentUser();
  }
}
