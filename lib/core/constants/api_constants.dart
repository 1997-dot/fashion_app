/// API-related constants for the Fashion E-Commerce app
/// Contains base URLs, timeout configurations, and HTTP headers
class ApiConstants {
  // Private constructor to prevent instantiation
  ApiConstants._();

  // ==================== BASE URLs ====================

  /// Base URL for local development
  static const String baseUrlDev = 'http://127.0.0.1:8000/api';

  /// Base URL for production (to be configured)
  static const String baseUrlProd = 'https://api.fashionapp.com/api';

  /// Current base URL based on environment
  /// Change this to baseUrlProd for production builds
  static const String baseUrl = baseUrlDev;

  // ==================== TIMEOUT CONFIGURATIONS ====================

  /// Connection timeout in milliseconds (30 seconds)
  static const int connectionTimeout = 30000;

  /// Receive timeout in milliseconds (30 seconds)
  static const int receiveTimeout = 30000;

  /// Send timeout in milliseconds (30 seconds)
  static const int sendTimeout = 30000;

  // ==================== HTTP HEADERS ====================

  /// Content-Type for JSON requests
  static const String contentTypeJson = 'application/json';

  /// Content-Type for multipart/form-data (file uploads)
  static const String contentTypeMultipart = 'multipart/form-data';

  /// Accept header for JSON responses
  static const String acceptJson = 'application/json';

  /// Authorization header key
  static const String authorizationHeader = 'Authorization';

  /// Bearer token prefix for Authorization header
  static const String bearerPrefix = 'Bearer';

  // ==================== HTTP STATUS CODES ====================

  /// Success status code
  static const int statusOk = 200;

  /// Created status code
  static const int statusCreated = 201;

  /// No content status code
  static const int statusNoContent = 204;

  /// Bad request status code
  static const int statusBadRequest = 400;

  /// Unauthorized status code (invalid/missing token)
  static const int statusUnauthorized = 401;

  /// Forbidden status code
  static const int statusForbidden = 403;

  /// Not found status code
  static const int statusNotFound = 404;

  /// Unprocessable entity status code (validation failed)
  static const int statusUnprocessableEntity = 422;

  /// Internal server error status code
  static const int statusInternalServerError = 500;

  // ==================== RESPONSE KEYS ====================

  /// Status key in API response
  static const String statusKey = 'status';

  /// Message key in API response
  static const String messageKey = 'message';

  /// Data key in API response
  static const String dataKey = 'data';

  /// Errors key in API response
  static const String errorsKey = 'errors';

  /// Token key in authentication response
  static const String tokenKey = 'token';

  /// User key in authentication response
  static const String userKey = 'user';

  // ==================== PAGINATION ====================

  /// Default page number
  static const int defaultPage = 1;

  /// Default items per page
  static const int defaultPageSize = 20;

  /// Maximum items per page
  static const int maxPageSize = 100;

  // ==================== CACHE SETTINGS ====================

  /// Cache duration in minutes (for product images, etc.)
  static const int cacheDurationMinutes = 60;

  /// Maximum cache size in MB
  static const int maxCacheSizeMB = 100;

  // ==================== FILE UPLOAD SETTINGS ====================

  /// Maximum image file size in MB
  static const int maxImageSizeMB = 5;

  /// Maximum image file size in bytes
  static const int maxImageSizeBytes = maxImageSizeMB * 1024 * 1024;

  /// Allowed image file extensions
  static const List<String> allowedImageExtensions = [
    'jpg',
    'jpeg',
    'png',
    'gif',
    'webp',
  ];

  // ==================== API VERSION ====================

  /// API version
  static const String apiVersion = 'v1';

  // ==================== HELPER METHODS ====================

  /// Build complete URL with path
  static String buildUrl(String path) {
    // Remove leading slash if present
    final cleanPath = path.startsWith('/') ? path.substring(1) : path;
    return '$baseUrl/$cleanPath';
  }

  /// Build Authorization header value with Bearer token
  static String buildAuthorizationHeader(String token) {
    return '$bearerPrefix $token';
  }

  /// Get default headers for JSON requests
  static Map<String, String> get defaultHeaders => {
        'Content-Type': contentTypeJson,
        'Accept': acceptJson,
      };

  /// Get headers with authorization token
  static Map<String, String> getAuthHeaders(String token) => {
        ...defaultHeaders,
        authorizationHeader: buildAuthorizationHeader(token),
      };

  /// Check if status code is successful (200-299)
  static bool isSuccessStatusCode(int statusCode) {
    return statusCode >= 200 && statusCode < 300;
  }

  /// Check if status code is client error (400-499)
  static bool isClientError(int statusCode) {
    return statusCode >= 400 && statusCode < 500;
  }

  /// Check if status code is server error (500-599)
  static bool isServerError(int statusCode) {
    return statusCode >= 500 && statusCode < 600;
  }
}
