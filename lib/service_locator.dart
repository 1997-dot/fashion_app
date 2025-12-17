import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:fashion_app/core/network/dio_client.dart';
import 'package:fashion_app/data/auth/repositories/auth_repository_impl.dart';
import 'package:fashion_app/data/auth/sources/auth_local_data_source.dart';
import 'package:fashion_app/data/auth/sources/auth_remote_data_source.dart';
import 'package:fashion_app/domain/auth/repositories/auth_repository.dart';
import 'package:fashion_app/domain/auth/usecases/get_current_user.dart';
import 'package:fashion_app/domain/auth/usecases/is_signed_in.dart';
import 'package:fashion_app/domain/auth/usecases/signin.dart';
import 'package:fashion_app/domain/auth/usecases/signout.dart';
import 'package:fashion_app/domain/auth/usecases/signup.dart';
import 'package:fashion_app/presentation/auth/bloc/auth_bloc.dart';

/// Global service locator instance
/// Used for dependency injection throughout the app
/// Follows the Service Locator pattern for Clean Architecture
///
/// Usage:
/// ```dart
/// // Register dependencies (done once in main.dart)
/// await setupServiceLocator();
///
/// // Access dependencies anywhere in the app
/// final dioClient = sl<DioClient>();
/// final authRepository = sl<AuthRepository>();
/// ```
final sl = GetIt.instance;

/// Setup and register all dependencies
/// Called once at app startup in main.dart before runApp()
///
/// Registration order:
/// 1. Core dependencies (SharedPreferences, DioClient)
/// 2. Data sources (remote and local)
/// 3. Repositories
/// 4. Use cases
/// 5. BLoCs (as factories for fresh instances)
///
/// Example:
/// ```dart
/// void main() async {
///   WidgetsFlutterBinding.ensureInitialized();
///   await setupServiceLocator();
///   runApp(const MyApp());
/// }
/// ```
Future<void> setupServiceLocator() async {
  // ==================== CORE DEPENDENCIES ====================

  // Register SharedPreferences as singleton
  // Used for local storage (auth token, user data, cache)
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);

  // Register DioClient as singleton
  // HTTP client for all API calls
  sl.registerLazySingleton<DioClient>(() => DioClient());

  // ==================== AUTHENTICATION FEATURE ====================

  // Data sources
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(dioClient: sl()),
  );

  sl.registerLazySingleton<AuthLocalDataSource>(
    () => AuthLocalDataSourceImpl(sharedPreferences: sl()),
  );

  // Repository
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton<SignInUseCase>(
    () => SignInUseCase(repository: sl()),
  );

  sl.registerLazySingleton<SignUpUseCase>(
    () => SignUpUseCase(repository: sl()),
  );

  sl.registerLazySingleton<SignOutUseCase>(
    () => SignOutUseCase(repository: sl()),
  );

  sl.registerLazySingleton<GetCurrentUserUseCase>(
    () => GetCurrentUserUseCase(repository: sl()),
  );

  sl.registerLazySingleton<IsSignedInUseCase>(
    () => IsSignedInUseCase(repository: sl()),
  );

  // BLoCs (factory - new instance each time)
  sl.registerFactory<AuthBloc>(
    () => AuthBloc(
      signInUseCase: sl(),
      signUpUseCase: sl(),
      signOutUseCase: sl(),
      getCurrentUserUseCase: sl(),
      isSignedInUseCase: sl(),
    ),
  );

  // ==================== PRODUCT FEATURE ====================
  // Will be registered when implementing Phase 4

  // // Data sources
  // sl.registerLazySingleton<ProductRemoteDataSource>(
  //   () => ProductRemoteDataSourceImpl(dioClient: sl()),
  // );
  //
  // // Repository
  // sl.registerLazySingleton<ProductRepository>(
  //   () => ProductRepositoryImpl(remoteDataSource: sl()),
  // );
  //
  // // Use cases
  // sl.registerLazySingleton<GetProductsUseCase>(
  //   () => GetProductsUseCase(repository: sl()),
  // );
  //
  // sl.registerLazySingleton<GetCategoriesUseCase>(
  //   () => GetCategoriesUseCase(repository: sl()),
  // );
  //
  // sl.registerLazySingleton<GetProductDetailUseCase>(
  //   () => GetProductDetailUseCase(repository: sl()),
  // );
  //
  // // BLoCs
  // sl.registerFactory<ProductsBloc>(
  //   () => ProductsBloc(
  //     getProducts: sl(),
  //     getCategories: sl(),
  //   ),
  // );
  //
  // sl.registerFactory<ProductDetailBloc>(
  //   () => ProductDetailBloc(getProductDetail: sl()),
  // );

  // ==================== FAVORITES FEATURE ====================
  // Will be registered when implementing Phase 6

  // // Data sources
  // sl.registerLazySingleton<FavoriteRemoteDataSource>(
  //   () => FavoriteRemoteDataSourceImpl(dioClient: sl()),
  // );
  //
  // // Repository
  // sl.registerLazySingleton<FavoriteRepository>(
  //   () => FavoriteRepositoryImpl(remoteDataSource: sl()),
  // );
  //
  // // Use cases
  // sl.registerLazySingleton<GetFavoritesUseCase>(
  //   () => GetFavoritesUseCase(repository: sl()),
  // );
  //
  // sl.registerLazySingleton<ToggleFavoriteUseCase>(
  //   () => ToggleFavoriteUseCase(repository: sl()),
  // );
  //
  // // BLoCs
  // sl.registerFactory<FavoritesBloc>(
  //   () => FavoritesBloc(
  //     getFavorites: sl(),
  //     toggleFavorite: sl(),
  //   ),
  // );

  // ==================== CART FEATURE ====================
  // Will be registered when implementing Phase 7

  // // Data sources
  // sl.registerLazySingleton<CartRemoteDataSource>(
  //   () => CartRemoteDataSourceImpl(dioClient: sl()),
  // );
  //
  // // Repository
  // sl.registerLazySingleton<CartRepository>(
  //   () => CartRepositoryImpl(remoteDataSource: sl()),
  // );
  //
  // // Use cases
  // sl.registerLazySingleton<GetCartUseCase>(
  //   () => GetCartUseCase(repository: sl()),
  // );
  //
  // sl.registerLazySingleton<AddToCartUseCase>(
  //   () => AddToCartUseCase(repository: sl()),
  // );
  //
  // sl.registerLazySingleton<RemoveFromCartUseCase>(
  //   () => RemoveFromCartUseCase(repository: sl()),
  // );
  //
  // sl.registerLazySingleton<UpdateCartItemUseCase>(
  //   () => UpdateCartItemUseCase(repository: sl()),
  // );
  //
  // // BLoCs
  // sl.registerFactory<CartBloc>(
  //   () => CartBloc(
  //     getCart: sl(),
  //     addToCart: sl(),
  //     removeFromCart: sl(),
  //     updateCartItem: sl(),
  //   ),
  // );

  // ==================== CHECKOUT FEATURE ====================
  // Will be registered when implementing Phase 8

  // // Data sources
  // sl.registerLazySingleton<CheckoutRemoteDataSource>(
  //   () => CheckoutRemoteDataSourceImpl(dioClient: sl()),
  // );
  //
  // // Repository
  // sl.registerLazySingleton<CheckoutRepository>(
  //   () => CheckoutRepositoryImpl(remoteDataSource: sl()),
  // );
  //
  // // Use cases
  // sl.registerLazySingleton<ProcessCheckoutUseCase>(
  //   () => ProcessCheckoutUseCase(repository: sl()),
  // );
  //
  // // BLoCs
  // sl.registerFactory<CheckoutBloc>(
  //   () => CheckoutBloc(processCheckout: sl()),
  // );

  // ==================== ORDER FEATURE ====================
  // Will be registered when implementing Phase 9

  // // Data sources
  // sl.registerLazySingleton<OrderRemoteDataSource>(
  //   () => OrderRemoteDataSourceImpl(dioClient: sl()),
  // );
  //
  // // Repository
  // sl.registerLazySingleton<OrderRepository>(
  //   () => OrderRepositoryImpl(remoteDataSource: sl()),
  // );
  //
  // // Use cases
  // sl.registerLazySingleton<GetOrdersUseCase>(
  //   () => GetOrdersUseCase(repository: sl()),
  // );
  //
  // sl.registerLazySingleton<GetOrderDetailUseCase>(
  //   () => GetOrderDetailUseCase(repository: sl()),
  // );
  //
  // sl.registerLazySingleton<CreateOrderUseCase>(
  //   () => CreateOrderUseCase(repository: sl()),
  // );
  //
  // // BLoCs
  // sl.registerFactory<OrdersBloc>(
  //   () => OrdersBloc(getOrders: sl()),
  // );
  //
  // sl.registerFactory<OrderDetailBloc>(
  //   () => OrderDetailBloc(getOrderDetail: sl()),
  // );

  // ==================== PROFILE FEATURE ====================
  // Will be registered when implementing Phase 10

  // // Data sources
  // sl.registerLazySingleton<ProfileRemoteDataSource>(
  //   () => ProfileRemoteDataSourceImpl(dioClient: sl()),
  // );
  //
  // // Repository
  // sl.registerLazySingleton<ProfileRepository>(
  //   () => ProfileRepositoryImpl(remoteDataSource: sl()),
  // );
  //
  // // Use cases
  // sl.registerLazySingleton<GetProfileUseCase>(
  //   () => GetProfileUseCase(repository: sl()),
  // );
  //
  // sl.registerLazySingleton<UpdateProfileUseCase>(
  //   () => UpdateProfileUseCase(repository: sl()),
  // );
  //
  // // BLoCs
  // sl.registerFactory<ProfileBloc>(
  //   () => ProfileBloc(
  //     getProfile: sl(),
  //     updateProfile: sl(),
  //   ),
  // );

  // ==================== SEARCH FEATURE ====================
  // Will be registered when implementing Phase 11

  // // Reuses ProductRepository
  // // Use cases
  // sl.registerLazySingleton<SearchProductsUseCase>(
  //   () => SearchProductsUseCase(repository: sl()),
  // );
  //
  // // BLoCs
  // sl.registerFactory<SearchBloc>(
  //   () => SearchBloc(searchProducts: sl()),
  // );
}

/// Reset all registered dependencies
/// Useful for testing or when you need to re-initialize
///
/// Example:
/// ```dart
/// await resetServiceLocator();
/// await setupServiceLocator();
/// ```
Future<void> resetServiceLocator() async {
  await sl.reset();
}

/// Check if a dependency is registered
/// Useful for debugging or conditional registration
///
/// Example:
/// ```dart
/// if (isRegistered<AuthRepository>()) {
///   final repo = sl<AuthRepository>();
/// }
/// ```
bool isRegistered<T extends Object>() {
  return sl.isRegistered<T>();
}

/// Unregister a specific dependency
/// Useful for hot reload or dynamic feature loading
///
/// Example:
/// ```dart
/// unregister<AuthBloc>();
/// ```
void unregister<T extends Object>() {
  if (sl.isRegistered<T>()) {
    sl.unregister<T>();
  }
}
