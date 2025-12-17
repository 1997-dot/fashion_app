import 'package:dartz/dartz.dart';

import 'package:fashion_app/core/errors/failures.dart';
import 'package:fashion_app/core/usecases/usecase.dart';
import 'package:fashion_app/domain/auth/repositories/auth_repository.dart';

/// Sign Out Use Case
/// Handles the business logic for user sign out
class SignOutUseCase extends VoidUseCase<NoParams> {
  final AuthRepository repository;

  SignOutUseCase({required this.repository});

  @override
  Future<Either<Failure, void>> call(NoParams params) async {
    return await repository.signOut();
  }
}
