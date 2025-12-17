import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:fashion_app/core/constants/storage_constants.dart';
import 'package:fashion_app/core/errors/exceptions.dart';
import 'package:fashion_app/data/auth/models/user_model.dart';

/// Authentication Local Data Source
/// Handles all authentication-related local storage operations
abstract class AuthLocalDataSource {
  /// Save authentication token to local storage
  /// Throws CacheException if save fails
  Future<void> saveToken(String token);

  /// Get authentication token from local storage
  /// Returns token string or null if not found
  Future<String?> getToken();

  /// Delete authentication token from local storage
  /// Throws CacheException if delete fails
  Future<void> deleteToken();

  /// Save user data to local storage
  /// Throws CacheException if save fails
  Future<void> saveUser(UserModel user);

  /// Get user data from local storage
  /// Returns UserModel or null if not found
  /// Throws CacheException if parsing fails
  Future<UserModel?> getUser();

  /// Delete user data from local storage
  /// Throws CacheException if delete fails
  Future<void> deleteUser();

  /// Check if user is signed in (token exists)
  /// Returns true if token exists, false otherwise
  Future<bool> isSignedIn();

  /// Clear all authentication data (token and user)
  /// Throws CacheException if clear fails
  Future<void> clearAuthData();
}

/// Implementation of AuthLocalDataSource
class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final SharedPreferences sharedPreferences;

  AuthLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<void> saveToken(String token) async {
    try {
      final success = await sharedPreferences.setString(
        StorageConstants.authToken,
        token,
      );
      if (!success) {
        throw const CacheException(message: 'Failed to save auth token');
      }
    } catch (e) {
      throw CacheException(message: 'Failed to save auth token: $e');
    }
  }

  @override
  Future<String?> getToken() async {
    try {
      return sharedPreferences.getString(StorageConstants.authToken);
    } catch (e) {
      throw CacheException(message: 'Failed to get auth token: $e');
    }
  }

  @override
  Future<void> deleteToken() async {
    try {
      final success = await sharedPreferences.remove(StorageConstants.authToken);
      if (!success) {
        throw const CacheException(message: 'Failed to delete auth token');
      }
    } catch (e) {
      throw CacheException(message: 'Failed to delete auth token: $e');
    }
  }

  @override
  Future<void> saveUser(UserModel user) async {
    try {
      final userJson = json.encode(user.toJson());
      final success = await sharedPreferences.setString(
        StorageConstants.userData,
        userJson,
      );
      if (!success) {
        throw const CacheException(message: 'Failed to save user data');
      }
    } catch (e) {
      throw CacheException(message: 'Failed to save user data: $e');
    }
  }

  @override
  Future<UserModel?> getUser() async {
    try {
      final userJson = sharedPreferences.getString(StorageConstants.userData);
      if (userJson == null) return null;

      final userMap = json.decode(userJson) as Map<String, dynamic>;
      return UserModel.fromJson(userMap);
    } catch (e) {
      throw CacheException(message: 'Failed to get user data: $e');
    }
  }

  @override
  Future<void> deleteUser() async {
    try {
      final success = await sharedPreferences.remove(StorageConstants.userData);
      if (!success) {
        throw const CacheException(message: 'Failed to delete user data');
      }
    } catch (e) {
      throw CacheException(message: 'Failed to delete user data: $e');
    }
  }

  @override
  Future<bool> isSignedIn() async {
    try {
      final token = await getToken();
      return token != null && token.isNotEmpty;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<void> clearAuthData() async {
    try {
      await deleteToken();
      await deleteUser();
      await sharedPreferences.setBool(StorageConstants.isLoggedIn, false);
    } catch (e) {
      throw CacheException(message: 'Failed to clear auth data: $e');
    }
  }
}
