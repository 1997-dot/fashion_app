import 'package:dartz/dartz.dart';

import 'package:fashion_app/core/errors/exceptions.dart';
import 'package:fashion_app/core/errors/failures.dart';
import 'package:fashion_app/data/auth/sources/auth_local_data_source.dart';
import 'package:fashion_app/data/auth/sources/auth_remote_data_source.dart';
import 'package:fashion_app/domain/auth/entities/user.dart';
import 'package:fashion_app/domain/auth/repositories/auth_repository.dart';

/// Implementation of AuthRepository
/// Coordinates between remote and local data sources
/// Converts exceptions to failures
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;

  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, User>> signIn({
    required String email,
    required String password,
  }) async {
    try {
      // Call remote data source to sign in
      final authResponse = await remoteDataSource.signIn(
        email: email,
        password: password,
      );

      // Save token and user data locally
      await localDataSource.saveToken(authResponse.token);
      await localDataSource.saveUser(authResponse.user);

      // Return user
      return Right(authResponse.user);
    } on ServerException catch (e) {
      return Left(ServerFailure(
        message: e.message,
        statusCode: e.statusCode,
        validationErrors: e.errors,
      ));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } on UnauthorizedException catch (e) {
      return Left(AuthFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(message: 'An unexpected error occurred: $e'));
    }
  }

  @override
  Future<Either<Failure, User>> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      // Call remote data source to sign up
      final authResponse = await remoteDataSource.signUp(
        name: name,
        email: email,
        password: password,
      );

      // Save token and user data locally
      await localDataSource.saveToken(authResponse.token);
      await localDataSource.saveUser(authResponse.user);

      // Return user
      return Right(authResponse.user);
    } on ServerException catch (e) {
      return Left(ServerFailure(
        message: e.message,
        statusCode: e.statusCode,
        validationErrors: e.errors,
      ));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } on UnauthorizedException catch (e) {
      return Left(AuthFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(message: 'An unexpected error occurred: $e'));
    }
  }

  @override
  Future<Either<Failure, void>> signOut() async {
    try {
      // Clear local authentication data
      await localDataSource.clearAuthData();

      return const Right(null);
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    } catch (e) {
      return Left(CacheFailure('Failed to sign out: $e'));
    }
  }

  @override
  Future<Either<Failure, User>> getCurrentUser() async {
    try {
      // Try to get user from local storage first
      final localUser = await localDataSource.getUser();

      if (localUser != null) {
        return Right(localUser);
      }

      // If not in local storage, try to fetch from API
      final remoteUser = await remoteDataSource.getCurrentUser();

      // Save to local storage for future use
      await localDataSource.saveUser(remoteUser);

      return Right(remoteUser);
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(
        message: e.message,
        statusCode: e.statusCode,
      ));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } on UnauthorizedException catch (e) {
      // Clear auth data if unauthorized
      await localDataSource.clearAuthData();
      return Left(AuthFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(message: 'Failed to get current user: $e'));
    }
  }

  @override
  Future<Either<Failure, bool>> isSignedIn() async {
    try {
      final signedIn = await localDataSource.isSignedIn();
      return Right(signedIn);
    } catch (e) {
      return Left(CacheFailure('Failed to check sign in status: $e'));
    }
  }
}
