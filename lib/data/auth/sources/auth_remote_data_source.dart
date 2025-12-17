import 'package:fashion_app/core/network/api_endpoints.dart';
import 'package:fashion_app/core/network/dio_client.dart';
import 'package:fashion_app/data/auth/models/auth_response_model.dart';
import 'package:fashion_app/data/auth/models/user_model.dart';

/// Authentication Remote Data Source
/// Handles all authentication-related API calls
abstract class AuthRemoteDataSource {
  /// Sign in with email and password
  /// Returns AuthResponseModel containing token and user data
  /// Throws ServerException if API call fails
  Future<AuthResponseModel> signIn({
    required String email,
    required String password,
  });

  /// Sign up with name, email, and password
  /// Returns AuthResponseModel containing token and user data
  /// Throws ServerException if API call fails
  Future<AuthResponseModel> signUp({
    required String name,
    required String email,
    required String password,
  });

  /// Get current user profile from API
  /// Returns UserModel
  /// Throws ServerException or UnauthorizedException if API call fails
  Future<UserModel> getCurrentUser();
}

/// Implementation of AuthRemoteDataSource
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final DioClient dioClient;

  AuthRemoteDataSourceImpl({required this.dioClient});

  @override
  Future<AuthResponseModel> signIn({
    required String email,
    required String password,
  }) async {
    // Call sign in API endpoint
    final response = await dioClient.post(
      ApiEndpoints.login,
      data: {
        'email': email,
        'password': password,
      },
    );

    // Parse response to AuthResponseModel
    return AuthResponseModel.fromJson(response.data as Map<String, dynamic>);
  }

  @override
  Future<AuthResponseModel> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    // Call sign up API endpoint
    final response = await dioClient.post(
      ApiEndpoints.register,
      data: {
        'name': name,
        'email': email,
        'password': password,
      },
    );

    // Parse response to AuthResponseModel
    return AuthResponseModel.fromJson(response.data as Map<String, dynamic>);
  }

  @override
  Future<UserModel> getCurrentUser() async {
    // Call profile API endpoint
    final response = await dioClient.get(ApiEndpoints.profile);

    // Parse response to UserModel
    return UserModel.fromJson(response.data as Map<String, dynamic>);
  }
}
