import 'package:dio/dio.dart';
import 'package:fashion_app/core/constants/api_constants.dart';
import 'package:fashion_app/core/network/interceptors/auth_interceptor.dart';
import 'package:fashion_app/core/network/interceptors/error_interceptor.dart';
import 'package:fashion_app/core/network/interceptors/logging_interceptor.dart';

/// Dio HTTP client wrapper for making API requests
/// Implements Clean Architecture principles with dependency injection support
/// Configured with base URL, timeouts, and interceptors
class DioClient {
  // Dio instance
  late final Dio _dio;

  // Getter for dio instance (for dependency injection)
  Dio get dio => _dio;

  /// Constructor with optional custom Dio instance
  DioClient({Dio? dio}) {
    _dio = dio ?? Dio();
    _configureDio();
    _addInterceptors();
  }

  // ==================== CONFIGURATION ====================

  /// Configure Dio with base options
  void _configureDio() {
    _dio.options = BaseOptions(
      // Base URL from API constants
      baseUrl: ApiConstants.baseUrl,

      // Timeout configurations
      connectTimeout: const Duration(milliseconds: ApiConstants.connectionTimeout),
      receiveTimeout: const Duration(milliseconds: ApiConstants.receiveTimeout),
      sendTimeout: const Duration(milliseconds: ApiConstants.sendTimeout),

      // Default headers
      headers: {
        'Content-Type': ApiConstants.contentTypeJson,
        'Accept': ApiConstants.acceptJson,
      },

      // Response type
      responseType: ResponseType.json,

      // Follow redirects
      followRedirects: true,
      maxRedirects: 5,

      // Validate status (200-299 are successful)
      validateStatus: (status) {
        return status != null && status < 500;
      },
    );
  }

  /// Add interceptors to Dio instance
  void _addInterceptors() {
    _dio.interceptors.addAll([
      // Logging interceptor (should be first to log everything)
      LoggingInterceptor(),

      // Auth interceptor (adds token to requests)
      AuthInterceptor(),

      // Error interceptor (handles errors and transforms to custom exceptions)
      ErrorInterceptor(),
    ]);
  }

  // ==================== HTTP METHODS ====================

  /// GET request
  /// [endpoint] - API endpoint path
  /// [queryParameters] - Optional query parameters
  /// [options] - Optional request options
  /// Returns Response object
  Future<Response> get(
    String endpoint, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      final response = await _dio.get(
        endpoint,
        queryParameters: queryParameters,
        options: options,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  /// POST request
  /// [endpoint] - API endpoint path
  /// [data] - Request body data
  /// [queryParameters] - Optional query parameters
  /// [options] - Optional request options
  /// Returns Response object
  Future<Response> post(
    String endpoint, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      final response = await _dio.post(
        endpoint,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  /// PUT request
  /// [endpoint] - API endpoint path
  /// [data] - Request body data
  /// [queryParameters] - Optional query parameters
  /// [options] - Optional request options
  /// Returns Response object
  Future<Response> put(
    String endpoint, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      final response = await _dio.put(
        endpoint,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  /// PATCH request
  /// [endpoint] - API endpoint path
  /// [data] - Request body data
  /// [queryParameters] - Optional query parameters
  /// [options] - Optional request options
  /// Returns Response object
  Future<Response> patch(
    String endpoint, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      final response = await _dio.patch(
        endpoint,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  /// DELETE request
  /// [endpoint] - API endpoint path
  /// [data] - Optional request body data
  /// [queryParameters] - Optional query parameters
  /// [options] - Optional request options
  /// Returns Response object
  Future<Response> delete(
    String endpoint, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      final response = await _dio.delete(
        endpoint,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // ==================== MULTIPART/FILE UPLOAD ====================

  /// POST request with multipart/form-data (for file uploads)
  /// [endpoint] - API endpoint path
  /// [data] - FormData with files and fields
  /// [queryParameters] - Optional query parameters
  /// [onSendProgress] - Optional callback for upload progress
  /// Returns Response object
  Future<Response> postMultipart(
    String endpoint, {
    required FormData data,
    Map<String, dynamic>? queryParameters,
    ProgressCallback? onSendProgress,
  }) async {
    try {
      final response = await _dio.post(
        endpoint,
        data: data,
        queryParameters: queryParameters,
        options: Options(
          contentType: ApiConstants.contentTypeMultipart,
        ),
        onSendProgress: onSendProgress,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  /// Create FormData from map with optional files
  /// [fields] - Map of field names and values
  /// [files] - Map of field names and file paths
  /// Returns FormData object
  Future<FormData> createFormData({
    required Map<String, dynamic> fields,
    Map<String, String>? files,
  }) async {
    final formData = FormData.fromMap(fields);

    if (files != null) {
      for (final entry in files.entries) {
        final filePath = entry.value;
        final fieldName = entry.key;

        formData.files.add(
          MapEntry(
            fieldName,
            await MultipartFile.fromFile(
              filePath,
              filename: filePath.split('/').last,
            ),
          ),
        );
      }
    }

    return formData;
  }

  // ==================== DOWNLOAD ====================

  /// Download file
  /// [urlPath] - URL or endpoint to download from
  /// [savePath] - Local path to save the file
  /// [onReceiveProgress] - Optional callback for download progress
  /// Returns Response object
  Future<Response> download(
    String urlPath,
    String savePath, {
    ProgressCallback? onReceiveProgress,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      final response = await _dio.download(
        urlPath,
        savePath,
        onReceiveProgress: onReceiveProgress,
        queryParameters: queryParameters,
        options: options,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // ==================== HELPER METHODS ====================

  /// Update base URL (useful for switching between dev/prod)
  void updateBaseUrl(String newBaseUrl) {
    _dio.options.baseUrl = newBaseUrl;
  }

  /// Add custom header to all requests
  void addHeader(String key, String value) {
    _dio.options.headers[key] = value;
  }

  /// Remove header from all requests
  void removeHeader(String key) {
    _dio.options.headers.remove(key);
  }

  /// Clear all custom headers
  void clearHeaders() {
    _dio.options.headers.clear();
  }

  /// Update connection timeout
  void updateConnectionTimeout(int milliseconds) {
    _dio.options.connectTimeout = Duration(milliseconds: milliseconds);
  }

  /// Update receive timeout
  void updateReceiveTimeout(int milliseconds) {
    _dio.options.receiveTimeout = Duration(milliseconds: milliseconds);
  }

  /// Cancel all pending requests
  void cancelRequests({String? reason}) {
    _dio.close(force: true);
  }

  /// Clear interceptors (useful for testing)
  void clearInterceptors() {
    _dio.interceptors.clear();
  }

  /// Add custom interceptor
  void addInterceptor(Interceptor interceptor) {
    _dio.interceptors.add(interceptor);
  }
}
