import 'package:dio/dio.dart';
import 'package:fashion_app/core/constants/api_constants.dart';
import 'package:fashion_app/core/errors/exceptions.dart';

/// Error Interceptor
/// Transforms Dio errors into custom application exceptions
/// Provides clean error handling for the presentation layer
/// Follows Clean Architecture principles - infrastructure layer
class ErrorInterceptor extends Interceptor {
  @override
  void onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) {
    // Transform DioException to custom exception based on error type
    final customException = _transformError(err);

    // If we transformed it to a custom exception, reject with it
    // Otherwise, continue with the original DioException
    if (customException != null) {
      handler.reject(
        DioException(
          requestOptions: err.requestOptions,
          error: customException,
          type: err.type,
          response: err.response,
        ),
      );
    } else {
      handler.next(err);
    }
  }

  // ==================== ERROR TRANSFORMATION ====================

  /// Transform DioException to custom application exception
  Exception? _transformError(DioException error) {
    switch (error.type) {
      // Connection timeout
      case DioExceptionType.connectionTimeout:
        return NetworkException(
          message: 'Connection timeout. Please check your internet connection.',
          statusCode: null,
        );

      // Send timeout (request taking too long)
      case DioExceptionType.sendTimeout:
        return NetworkException(
          message: 'Request timeout. Please try again.',
          statusCode: null,
        );

      // Receive timeout (server not responding)
      case DioExceptionType.receiveTimeout:
        return NetworkException(
          message: 'Server not responding. Please try again later.',
          statusCode: null,
        );

      // Bad certificate (SSL/TLS error)
      case DioExceptionType.badCertificate:
        return NetworkException(
          message: 'Security certificate error. Please check your connection.',
          statusCode: null,
        );

      // Bad response (4xx, 5xx errors)
      case DioExceptionType.badResponse:
        return _handleResponseError(error);

      // Request cancelled
      case DioExceptionType.cancel:
        return NetworkException(
          message: 'Request cancelled.',
          statusCode: null,
        );

      // Connection error (no internet, DNS error, etc.)
      case DioExceptionType.connectionError:
        return NetworkException(
          message: 'No internet connection. Please check your network.',
          statusCode: null,
        );

      // Unknown error
      case DioExceptionType.unknown:
        return NetworkException(
          message: 'An unexpected error occurred. Please try again.',
          statusCode: null,
        );
    }
  }

  /// Handle response errors (4xx, 5xx status codes)
  Exception _handleResponseError(DioException error) {
    final statusCode = error.response?.statusCode;
    final responseData = error.response?.data;

    // Extract error message from response
    String message = _extractErrorMessage(responseData);

    // Handle specific HTTP status codes
    switch (statusCode) {
      // 400 - Bad Request (validation errors)
      case ApiConstants.statusBadRequest:
        return ServerException(
          message: message.isEmpty ? 'Invalid request. Please check your input.' : message,
          statusCode: statusCode,
          errors: _extractValidationErrors(responseData),
        );

      // 401 - Unauthorized (invalid or missing token)
      case ApiConstants.statusUnauthorized:
        return UnauthorizedException(
          message: message.isEmpty ? 'Session expired. Please login again.' : message,
        );

      // 403 - Forbidden (no permission)
      case ApiConstants.statusForbidden:
        return ServerException(
          message: message.isEmpty ? 'You do not have permission to perform this action.' : message,
          statusCode: statusCode,
        );

      // 404 - Not Found
      case ApiConstants.statusNotFound:
        return ServerException(
          message: message.isEmpty ? 'Resource not found.' : message,
          statusCode: statusCode,
        );

      // 422 - Unprocessable Entity (validation failed)
      case ApiConstants.statusUnprocessableEntity:
        return ServerException(
          message: message.isEmpty ? 'Validation failed. Please check your input.' : message,
          statusCode: statusCode,
          errors: _extractValidationErrors(responseData),
        );

      // 500 - Internal Server Error
      case ApiConstants.statusInternalServerError:
        return ServerException(
          message: message.isEmpty ? 'Server error. Please try again later.' : message,
          statusCode: statusCode,
        );

      // Other error codes
      default:
        if (statusCode != null && statusCode >= 400 && statusCode < 500) {
          // Client errors (4xx)
          return ServerException(
            message: message.isEmpty ? 'Request failed. Please try again.' : message,
            statusCode: statusCode,
          );
        } else if (statusCode != null && statusCode >= 500) {
          // Server errors (5xx)
          return ServerException(
            message: message.isEmpty ? 'Server error. Please try again later.' : message,
            statusCode: statusCode,
          );
        } else {
          // Unknown status code
          return ServerException(
            message: message.isEmpty ? 'An error occurred. Please try again.' : message,
            statusCode: statusCode,
          );
        }
    }
  }

  // ==================== HELPER METHODS ====================

  /// Extract error message from response data
  /// API response format: { "status": false, "message": "Error message", "errors": {...} }
  String _extractErrorMessage(dynamic responseData) {
    if (responseData == null) return '';

    try {
      if (responseData is Map<String, dynamic>) {
        // Try to get message from standard API response format
        final message = responseData[ApiConstants.messageKey];
        if (message != null && message is String && message.isNotEmpty) {
          return message;
        }

        // Try to get first error from errors object
        final errors = responseData[ApiConstants.errorsKey];
        if (errors != null && errors is Map<String, dynamic>) {
          final firstError = errors.values.firstOrNull;
          if (firstError != null) {
            if (firstError is List && firstError.isNotEmpty) {
              return firstError.first.toString();
            } else if (firstError is String) {
              return firstError;
            }
          }
        }
      }

      // Fallback: convert to string
      final dataString = responseData.toString();
      if (dataString.length > 200) {
        return '${dataString.substring(0, 200)}...';
      }
      return dataString;
    } catch (e) {
      return '';
    }
  }

  /// Extract validation errors from response data
  /// Returns a map of field names to error messages
  Map<String, List<String>>? _extractValidationErrors(dynamic responseData) {
    if (responseData == null) return null;

    try {
      if (responseData is Map<String, dynamic>) {
        final errors = responseData[ApiConstants.errorsKey];
        if (errors != null && errors is Map<String, dynamic>) {
          final validationErrors = <String, List<String>>{};

          errors.forEach((key, value) {
            if (value is List) {
              validationErrors[key] = value.map((e) => e.toString()).toList();
            } else if (value is String) {
              validationErrors[key] = [value];
            }
          });

          return validationErrors.isNotEmpty ? validationErrors : null;
        }
      }
    } catch (e) {
      return null;
    }

    return null;
  }

  /// Check if error is a network connectivity issue
  bool _isNetworkError(DioException error) {
    return error.type == DioExceptionType.connectionTimeout ||
        error.type == DioExceptionType.connectionError ||
        error.type == DioExceptionType.receiveTimeout;
  }

  /// Check if error is a server error (5xx)
  bool _isServerError(DioException error) {
    final statusCode = error.response?.statusCode;
    return statusCode != null && statusCode >= 500 && statusCode < 600;
  }

  /// Check if error is a client error (4xx)
  bool _isClientError(DioException error) {
    final statusCode = error.response?.statusCode;
    return statusCode != null && statusCode >= 400 && statusCode < 500;
  }

  /// Check if error is authentication related (401)
  bool _isAuthError(DioException error) {
    return error.response?.statusCode == ApiConstants.statusUnauthorized;
  }
}
