import 'package:dartz/dartz.dart';
import 'package:fashion_app/core/errors/failures.dart';

/// Base UseCase abstract class for the Fashion E-Commerce app
/// Follows Clean Architecture principles
/// All use cases in the domain layer extend this class
///
/// Type Parameters:
/// - [Type]: The return type on success
/// - [Params]: The parameters required to execute the use case
///
/// Returns: Either<Failure, Type>
/// - Left: Failure (error case)
/// - Right: Type (success case)
///
/// Example:
/// ```dart
/// class SignInUseCase extends UseCase<User, SignInParams> {
///   final AuthRepository repository;
///
///   SignInUseCase(this.repository);
///
///   @override
///   Future<Either<Failure, User>> call(SignInParams params) async {
///     return await repository.signIn(params.email, params.password);
///   }
/// }
/// ```
abstract class UseCase<Type, Params> {
  /// Execute the use case
  /// Returns Either<Failure, Type>
  /// - Left side: Failure if operation fails
  /// - Right side: Type if operation succeeds
  Future<Either<Failure, Type>> call(Params params);
}

/// NoParams class for use cases that don't require parameters
/// Used when a use case needs no input parameters
///
/// Example:
/// ```dart
/// class GetCurrentUserUseCase extends UseCase<User, NoParams> {
///   final AuthRepository repository;
///
///   GetCurrentUserUseCase(this.repository);
///
///   @override
///   Future<Either<Failure, User>> call(NoParams params) async {
///     return await repository.getCurrentUser();
///   }
/// }
///
/// // Usage:
/// final result = await getCurrentUserUseCase(NoParams());
/// ```
class NoParams {
  const NoParams();
}

/// StreamUseCase abstract class for use cases that return streams
/// Used for real-time data updates (e.g., cart updates, order tracking)
///
/// Type Parameters:
/// - [Type]: The return type on success
/// - [Params]: The parameters required to execute the use case
///
/// Returns: Either<Failure, Stream<Type>>
/// - Left: Failure (error case)
/// - Right: Stream<Type> (success case with continuous updates)
///
/// Example:
/// ```dart
/// class WatchCartUseCase extends StreamUseCase<Cart, NoParams> {
///   final CartRepository repository;
///
///   WatchCartUseCase(this.repository);
///
///   @override
///   Future<Either<Failure, Stream<Cart>>> call(NoParams params) async {
///     return await repository.watchCart();
///   }
/// }
/// ```
abstract class StreamUseCase<Type, Params> {
  /// Execute the use case
  /// Returns Either<Failure, Stream<Type>>
  /// - Left side: Failure if operation fails
  /// - Right side: Stream<Type> if operation succeeds
  Future<Either<Failure, Stream<Type>>> call(Params params);
}

/// SyncUseCase abstract class for synchronous use cases
/// Used for operations that don't require async operations
/// (e.g., validation, calculations, local state checks)
///
/// Type Parameters:
/// - [Type]: The return type on success
/// - [Params]: The parameters required to execute the use case
///
/// Returns: Either<Failure, Type>
/// - Left: Failure (error case)
/// - Right: Type (success case)
///
/// Example:
/// ```dart
/// class ValidateEmailUseCase extends SyncUseCase<bool, String> {
///   @override
///   Either<Failure, bool> call(String email) {
///     if (email.isEmpty) {
///       return Left(ValidationFailure(
///         message: 'Email is required',
///         fieldErrors: {'email': 'Email cannot be empty'},
///       ));
///     }
///
///     final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
///     if (!emailRegex.hasMatch(email)) {
///       return Left(ValidationFailure(
///         message: 'Invalid email format',
///         fieldErrors: {'email': 'Please enter a valid email'},
///       ));
///     }
///
///     return const Right(true);
///   }
/// }
/// ```
abstract class SyncUseCase<Type, Params> {
  /// Execute the use case synchronously
  /// Returns Either<Failure, Type>
  /// - Left side: Failure if operation fails
  /// - Right side: Type if operation succeeds
  Either<Failure, Type> call(Params params);
}

/// VoidUseCase abstract class for use cases that don't return a value
/// Used for operations that only perform side effects
/// (e.g., logout, clear cache, delete operations)
///
/// Type Parameters:
/// - [Params]: The parameters required to execute the use case
///
/// Returns: Either<Failure, void>
/// - Left: Failure (error case)
/// - Right: void (success case)
///
/// Example:
/// ```dart
/// class SignOutUseCase extends VoidUseCase<NoParams> {
///   final AuthRepository repository;
///
///   SignOutUseCase(this.repository);
///
///   @override
///   Future<Either<Failure, void>> call(NoParams params) async {
///     return await repository.signOut();
///   }
/// }
/// ```
abstract class VoidUseCase<Params> {
  /// Execute the use case
  /// Returns Either<Failure, void>
  /// - Left side: Failure if operation fails
  /// - Right side: void if operation succeeds
  Future<Either<Failure, void>> call(Params params);
}

/// BoolUseCase abstract class for use cases that return boolean results
/// Used for check/validation operations
/// (e.g., isSignedIn, isFavorite, isInCart)
///
/// Type Parameters:
/// - [Params]: The parameters required to execute the use case
///
/// Returns: Either<Failure, bool>
/// - Left: Failure (error case)
/// - Right: bool (success case)
///
/// Example:
/// ```dart
/// class IsSignedInUseCase extends BoolUseCase<NoParams> {
///   final AuthRepository repository;
///
///   IsSignedInUseCase(this.repository);
///
///   @override
///   Future<Either<Failure, bool>> call(NoParams params) async {
///     return await repository.isSignedIn();
///   }
/// }
///
/// // Usage:
/// final result = await isSignedInUseCase(NoParams());
/// result.fold(
///   (failure) => print('Error: ${failure.message}'),
///   (isSignedIn) => print('Signed in: $isSignedIn'),
/// );
/// ```
abstract class BoolUseCase<Params> {
  /// Execute the use case
  /// Returns Either<Failure, bool>
  /// - Left side: Failure if operation fails
  /// - Right side: bool if operation succeeds
  Future<Either<Failure, bool>> call(Params params);
}

/// ListUseCase abstract class for use cases that return lists
/// Used for fetching multiple items
/// (e.g., getProducts, getOrders, getFavorites)
///
/// Type Parameters:
/// - [Type]: The type of items in the list
/// - [Params]: The parameters required to execute the use case
///
/// Returns: Either<Failure, List<Type>>
/// - Left: Failure (error case)
/// - Right: List<Type> (success case)
///
/// Example:
/// ```dart
/// class GetProductsUseCase extends ListUseCase<Product, GetProductsParams> {
///   final ProductRepository repository;
///
///   GetProductsUseCase(this.repository);
///
///   @override
///   Future<Either<Failure, List<Product>>> call(GetProductsParams params) async {
///     return await repository.getProducts(
///       name: params.name,
///       categoryId: params.categoryId,
///     );
///   }
/// }
///
/// // Usage:
/// final result = await getProductsUseCase(GetProductsParams(categoryId: 1));
/// result.fold(
///   (failure) => print('Error: ${failure.message}'),
///   (products) => print('Loaded ${products.length} products'),
/// );
/// ```
abstract class ListUseCase<Type, Params> {
  /// Execute the use case
  /// Returns Either<Failure, List<Type>>
  /// - Left side: Failure if operation fails
  /// - Right side: List<Type> if operation succeeds
  Future<Either<Failure, List<Type>>> call(Params params);
}
