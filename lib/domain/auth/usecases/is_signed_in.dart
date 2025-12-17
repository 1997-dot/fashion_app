import 'package:dartz/dartz.dart';

import 'package:fashion_app/core/errors/failures.dart';
import 'package:fashion_app/core/usecases/usecase.dart';
import 'package:fashion_app/domain/auth/repositories/auth_repository.dart';

/// Is Signed In Use Case
/// Checks if a user is currently authenticated
class IsSignedInUseCase extends BoolUseCase<NoParams> {
  final AuthRepository repository;

  IsSignedInUseCase({required this.repository});

  @override
  Future<Either<Failure, bool>> call(NoParams params) async {
    return await repository.isSignedIn();
  }
}
