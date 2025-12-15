import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fashion_app/core/constants/api_constants.dart';
import 'package:fashion_app/core/constants/storage_constants.dart';

/// Authentication Interceptor
/// Automatically adds Bearer token to all authenticated API requests
/// Reads token from SharedPreferences and adds it to Authorization header
/// Follows Clean Architecture principles - infrastructure layer
class AuthInterceptor extends Interceptor {
  // SharedPreferences instance (will be injected via dependency injection)
  SharedPreferences? _prefs;

  /// Constructor with optional SharedPreferences instance
  AuthInterceptor({SharedPreferences? sharedPreferences})
      : _prefs = sharedPreferences;

  // ==================== REQUEST INTERCEPTOR ====================

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    try {
      // Get SharedPreferences instance if not already set
      _prefs ??= await SharedPreferences.getInstance();

      // Get stored auth token
      final token = _prefs?.getString(StorageConstants.authToken);

      // If token exists, add it to Authorization header
      if (token != null && token.isNotEmpty) {
        options.headers[ApiConstants.authorizationHeader] =
            ApiConstants.buildAuthorizationHeader(token);
      }

      // Continue with the request
      handler.next(options);
    } catch (e) {
      // If error occurs, continue without token
      // This prevents the app from crashing if SharedPreferences fails
      handler.next(options);
    }
  }

  // ==================== RESPONSE INTERCEPTOR ====================

  @override
  void onResponse(
    Response response,
    ResponseInterceptorHandler handler,
  ) {
    // Check if response contains a new token (after login/register)
    // and save it to SharedPreferences
    _saveTokenIfPresent(response);

    // Continue with the response
    handler.next(response);
  }

  // ==================== ERROR INTERCEPTOR ====================

  @override
  void onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    // Handle 401 Unauthorized - token expired or invalid
    if (err.response?.statusCode == ApiConstants.statusUnauthorized) {
      // Clear stored token
      await _clearToken();

      // Optionally: Trigger logout or redirect to login
      // This can be handled by the error interceptor or in the presentation layer
    }

    // Continue with the error
    handler.next(err);
  }

  // ==================== HELPER METHODS ====================

  /// Save token from response if present
  /// Called after successful login/register
  void _saveTokenIfPresent(Response response) async {
    try {
      // Check if response data contains token
      if (response.data is Map<String, dynamic>) {
        final data = response.data as Map<String, dynamic>;

        // Check for token in response data
        String? token;

        // Token might be in data.data.token (login/register response)
        if (data[ApiConstants.dataKey] is Map<String, dynamic>) {
          final dataMap = data[ApiConstants.dataKey] as Map<String, dynamic>;
          token = dataMap[ApiConstants.tokenKey] as String?;
        }
        // Or directly in data.token
        else if (data.containsKey(ApiConstants.tokenKey)) {
          token = data[ApiConstants.tokenKey] as String?;
        }

        // Save token if found
        if (token != null && token.isNotEmpty) {
          _prefs ??= await SharedPreferences.getInstance();
          await _prefs?.setString(StorageConstants.authToken, token);
        }
      }
    } catch (e) {
      // Silently fail - token saving is not critical for response handling
      // Actual token storage should be handled by the data layer
    }
  }

  /// Clear stored authentication token
  /// Called when token is invalid or expired (401 error)
  Future<void> _clearToken() async {
    try {
      _prefs ??= await SharedPreferences.getInstance();
      await _prefs?.remove(StorageConstants.authToken);
    } catch (e) {
      // Silently fail
    }
  }

  /// Get current stored token (for debugging/testing)
  Future<String?> getCurrentToken() async {
    try {
      _prefs ??= await SharedPreferences.getInstance();
      return _prefs?.getString(StorageConstants.authToken);
    } catch (e) {
      return null;
    }
  }

  /// Check if user is authenticated (has valid token)
  Future<bool> isAuthenticated() async {
    final token = await getCurrentToken();
    return token != null && token.isNotEmpty;
  }

  /// Manually set token (useful for testing or manual login)
  Future<void> setToken(String token) async {
    try {
      _prefs ??= await SharedPreferences.getInstance();
      await _prefs?.setString(StorageConstants.authToken, token);
    } catch (e) {
      // Handle error
    }
  }

  /// Manually clear token (useful for logout)
  Future<void> clearToken() async {
    await _clearToken();
  }
}
