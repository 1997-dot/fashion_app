import 'package:equatable/equatable.dart';

/// Failures for the Fashion E-Commerce app
/// Used in the domain layer to represent operation failures
/// All use cases return Either<Failure, Success>
/// Follows Clean Architecture - domain layer abstraction

/// Base failure class
/// All failures extend this class and use Equatable for value equality
abstract class Failure extends Equatable {
  final String message;

  const Failure(this.message);

  @override
  List<Object?> get props => [message];

  @override
  String toString() => message;
}

// ==================== SERVER FAILURES ====================

/// Failure when server returns an error response
/// Used for: API errors, validation errors, server-side issues
/// Maps from: ServerException
class ServerFailure extends Failure {
  final int? statusCode;
  final Map<String, List<String>>? validationErrors;

  const ServerFailure({
    required String message,
    this.statusCode,
    this.validationErrors,
  }) : super(message);

  @override
  List<Object?> get props => [message, statusCode, validationErrors];

  @override
  String toString() {
    final buffer = StringBuffer(message);
    if (statusCode != null) {
      buffer.write(' (Status: $statusCode)');
    }
    if (validationErrors != null && validationErrors!.isNotEmpty) {
      buffer.write('\nValidation Errors:');
      validationErrors!.forEach((field, errors) {
        buffer.write('\n  $field: ${errors.join(', ')}');
      });
    }
    return buffer.toString();
  }

  /// Get validation error for a specific field
  List<String>? getFieldErrors(String fieldName) {
    return validationErrors?[fieldName];
  }

  /// Get first validation error for a specific field
  String? getFirstFieldError(String fieldName) {
    final errors = getFieldErrors(fieldName);
    return errors?.isNotEmpty == true ? errors!.first : null;
  }

  /// Check if has validation errors
  bool get hasValidationErrors =>
      validationErrors != null && validationErrors!.isNotEmpty;

  /// Check if specific field has validation error
  bool hasFieldError(String fieldName) {
    return validationErrors?.containsKey(fieldName) ?? false;
  }
}

// ==================== NETWORK FAILURES ====================

/// Failure when network connectivity issues occur
/// Used for: Connection timeout, no internet, DNS errors
/// Maps from: NetworkException
class NetworkFailure extends Failure {
  const NetworkFailure([
    String message = 'Network error. Please check your connection.',
  ]) : super(message);

  @override
  String toString() => 'Network Error: $message';
}

// ==================== AUTHENTICATION FAILURES ====================

/// Failure when authentication fails
/// Used for: Invalid credentials, expired token, unauthorized access
/// Maps from: UnauthorizedException
class AuthFailure extends Failure {
  const AuthFailure([
    String message = 'Authentication failed. Please login again.',
  ]) : super(message);

  @override
  String toString() => 'Authentication Error: $message';
}

// ==================== CACHE FAILURES ====================

/// Failure when local storage operations fail
/// Used for: SharedPreferences errors, local database errors
/// Maps from: CacheException
class CacheFailure extends Failure {
  const CacheFailure([
    String message = 'Local storage error occurred.',
  ]) : super(message);

  @override
  String toString() => 'Cache Error: $message';
}

// ==================== VALIDATION FAILURES ====================

/// Failure for client-side validation errors
/// Used for: Form validation, input validation
/// Maps from: ValidationException
class ValidationFailure extends Failure {
  final Map<String, String> fieldErrors;

  const ValidationFailure({
    String message = 'Validation failed.',
    required this.fieldErrors,
  }) : super(message);

  @override
  List<Object?> get props => [message, fieldErrors];

  @override
  String toString() {
    final buffer = StringBuffer(message);
    if (fieldErrors.isNotEmpty) {
      buffer.write('\nErrors:');
      fieldErrors.forEach((field, error) {
        buffer.write('\n  $field: $error');
      });
    }
    return buffer.toString();
  }

  /// Get error for a specific field
  String? getFieldError(String fieldName) => fieldErrors[fieldName];

  /// Check if specific field has error
  bool hasFieldError(String fieldName) => fieldErrors.containsKey(fieldName);

  /// Get all field names with errors
  List<String> get errorFields => fieldErrors.keys.toList();

  /// Check if has any errors
  bool get hasErrors => fieldErrors.isNotEmpty;
}

// ==================== FILE FAILURES ====================

/// Failure when file operations fail
/// Used for: Image upload, file download, file access
/// Maps from: FileException
class FileFailure extends Failure {
  const FileFailure([
    String message = 'File operation failed.',
  ]) : super(message);

  @override
  String toString() => 'File Error: $message';
}

// ==================== PARSING FAILURES ====================

/// Failure when data parsing fails
/// Used for: JSON parsing errors, unexpected data format
/// Maps from: ParsingException
class ParsingFailure extends Failure {
  const ParsingFailure([
    String message = 'Failed to parse data.',
  ]) : super(message);

  @override
  String toString() => 'Parsing Error: $message';
}

// ==================== PERMISSION FAILURES ====================

/// Failure when required permissions are not granted
/// Used for: Camera, storage, location permissions
/// Maps from: PermissionException
class PermissionFailure extends Failure {
  final String permission;

  const PermissionFailure({
    required this.permission,
    String? message,
  }) : super(message ?? 'Permission denied: $permission');

  @override
  List<Object?> get props => [message, permission];

  @override
  String toString() => 'Permission Error: $message';
}

// ==================== NOT FOUND FAILURES ====================

/// Failure when requested resource is not found
/// Used for: 404 errors, missing data
class NotFoundFailure extends Failure {
  const NotFoundFailure([
    String message = 'Resource not found.',
  ]) : super(message);

  @override
  String toString() => 'Not Found: $message';
}

// ==================== UNKNOWN FAILURES ====================

/// Failure for unexpected errors
/// Used as fallback when error type is unknown
class UnknownFailure extends Failure {
  const UnknownFailure([
    String message = 'An unexpected error occurred.',
  ]) : super(message);

  @override
  String toString() => 'Unknown Error: $message';
}

// ==================== HELPER FUNCTIONS ====================

/// Map exception to failure
/// Used in repository implementations to convert exceptions to failures
Failure mapExceptionToFailure(Exception exception) {
  // This is a helper that can be used in repositories
  // The actual mapping is done in the repository layer
  // This function provides a centralized mapping logic
  return UnknownFailure(exception.toString());
}

/// Create server failure with validation errors
ServerFailure createValidationFailure({
  required String message,
  required Map<String, List<String>> errors,
  int? statusCode,
}) {
  return ServerFailure(
    message: message,
    statusCode: statusCode,
    validationErrors: errors,
  );
}

/// Create network failure with custom message
NetworkFailure createNetworkFailure([String? message]) {
  return NetworkFailure(
    message ?? 'Network error. Please check your connection.',
  );
}

/// Create auth failure with custom message
AuthFailure createAuthFailure([String? message]) {
  return AuthFailure(
    message ?? 'Authentication failed. Please login again.',
  );
}
