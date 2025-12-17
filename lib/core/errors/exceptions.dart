/// Custom exceptions for the Fashion E-Commerce app
/// Used in the data layer to represent different types of errors
/// These exceptions are transformed to Failures in the domain layer
library;

/// Base exception class for all custom exceptions
abstract class AppException implements Exception {
  final String message;
  final int? statusCode;

  const AppException({
    required this.message,
    this.statusCode,
  });

  @override
  String toString() => message;
}

// ==================== SERVER EXCEPTIONS ====================

/// Exception thrown when server returns an error response (4xx, 5xx)
/// Used for API errors, validation errors, and server-side issues
class ServerException extends AppException {
  /// Optional validation errors map (field name -> error messages)
  final Map<String, List<String>>? errors;

  const ServerException({
    required super.message,
    super.statusCode,
    this.errors,
  });

  @override
  String toString() {
    final buffer = StringBuffer(message);
    if (statusCode != null) {
      buffer.write(' (Status: $statusCode)');
    }
    if (errors != null && errors!.isNotEmpty) {
      buffer.write('\nValidation Errors: ${errors.toString()}');
    }
    return buffer.toString();
  }
}

// ==================== NETWORK EXCEPTIONS ====================

/// Exception thrown when network connectivity issues occur
/// Used for: Connection timeout, no internet, DNS errors, etc.
class NetworkException extends AppException {
  const NetworkException({
    required super.message,
    super.statusCode,
  });

  @override
  String toString() => 'Network Error: $message';
}

// ==================== AUTHENTICATION EXCEPTIONS ====================

/// Exception thrown when authentication fails (401 Unauthorized)
/// Used for: Invalid token, expired token, missing credentials
class UnauthorizedException extends AppException {
  const UnauthorizedException({
    String? message,
  }) : super(
          message: message ?? 'Session expired. Please login again.',
          statusCode: 401,
        );

  @override
  String toString() => 'Unauthorized: $message';
}

// ==================== CACHE EXCEPTIONS ====================

/// Exception thrown when local storage/cache operations fail
/// Used for: SharedPreferences errors, file system errors
class CacheException extends AppException {
  const CacheException({
    String? message,
  }) : super(
          message: message ?? 'Local storage error occurred.',
        );

  @override
  String toString() => 'Cache Error: $message';
}

// ==================== VALIDATION EXCEPTIONS ====================

/// Exception thrown for validation errors on the client side
/// Used for: Form validation, input validation before API calls
class ValidationException extends AppException {
  /// Map of field names to error messages
  final Map<String, String> fieldErrors;

  const ValidationException({
    String? message,
    required this.fieldErrors,
  }) : super(
          message: message ?? 'Validation failed.',
        );

  @override
  String toString() {
    final buffer = StringBuffer(message);
    if (fieldErrors.isNotEmpty) {
      buffer.write('\nErrors: ${fieldErrors.toString()}');
    }
    return buffer.toString();
  }

  /// Get error message for a specific field
  String? getFieldError(String fieldName) => fieldErrors[fieldName];

  /// Check if a specific field has an error
  bool hasFieldError(String fieldName) => fieldErrors.containsKey(fieldName);
}

// ==================== FILE EXCEPTIONS ====================

/// Exception thrown when file operations fail
/// Used for: Image upload, file download, file access errors
class FileException extends AppException {
  const FileException({
    required super.message,
  });

  @override
  String toString() => 'File Error: $message';
}

// ==================== PARSING EXCEPTIONS ====================

/// Exception thrown when JSON parsing fails
/// Used for: Malformed API responses, unexpected data format
class ParsingException extends AppException {
  const ParsingException({
    String? message,
  }) : super(
          message: message ?? 'Failed to parse server response.',
        );

  @override
  String toString() => 'Parsing Error: $message';
}

// ==================== PERMISSION EXCEPTIONS ====================

/// Exception thrown when required permissions are not granted
/// Used for: Camera permission, storage permission, etc.
class PermissionException extends AppException {
  /// The permission that was denied
  final String permission;

  const PermissionException({
    required this.permission,
    String? message,
  }) : super(
          message: message ?? 'Permission denied: $permission',
        );

  @override
  String toString() => 'Permission Error: $message';
}

// ==================== UNKNOWN EXCEPTIONS ====================

/// Exception thrown for unexpected errors
/// Used as a fallback when error type is unknown
class UnknownException extends AppException {
  const UnknownException({
    String? message,
  }) : super(
          message: message ?? 'An unknown error occurred.',
        );

  @override
  String toString() => 'Unknown Error: $message';
}
