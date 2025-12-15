import 'dart:developer' as developer;
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

/// Logging Interceptor
/// Logs all HTTP requests and responses for debugging purposes
/// Only active in debug mode to avoid performance overhead in production
/// Follows Clean Architecture principles - infrastructure layer
class LoggingInterceptor extends Interceptor {
  /// Enable/disable logging (default: only in debug mode)
  final bool enabled;

  /// Enable/disable request body logging
  final bool logRequestBody;

  /// Enable/disable response body logging
  final bool logResponseBody;

  /// Enable/disable request headers logging
  final bool logRequestHeaders;

  /// Enable/disable response headers logging
  final bool logResponseHeaders;

  /// Constructor with configuration options
  LoggingInterceptor({
    bool? enabled,
    this.logRequestBody = true,
    this.logResponseBody = true,
    this.logRequestHeaders = true,
    this.logResponseHeaders = false,
  }) : enabled = enabled ?? kDebugMode;

  // ==================== REQUEST INTERCEPTOR ====================

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) {
    if (enabled) {
      _logRequest(options);
    }
    handler.next(options);
  }

  // ==================== RESPONSE INTERCEPTOR ====================

  @override
  void onResponse(
    Response response,
    ResponseInterceptorHandler handler,
  ) {
    if (enabled) {
      _logResponse(response);
    }
    handler.next(response);
  }

  // ==================== ERROR INTERCEPTOR ====================

  @override
  void onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) {
    if (enabled) {
      _logDioError(err);
    }
    handler.next(err);
  }

  // ==================== LOGGING METHODS ====================

  /// Log HTTP request details
  void _logRequest(RequestOptions options) {
    final logLines = <String>[];

    // Header
    logLines.add('╔═══════════════════════════════════════════════════════════');
    logLines.add('║ 📤 REQUEST');
    logLines.add('╠═══════════════════════════════════════════════════════════');

    // Request info
    logLines.add('║ Method: ${options.method}');
    logLines.add('║ URL: ${options.uri}');

    // Headers
    if (logRequestHeaders && options.headers.isNotEmpty) {
      logLines.add('╟───────────────────────────────────────────────────────────');
      logLines.add('║ Headers:');
      options.headers.forEach((key, value) {
        // Mask sensitive headers
        final maskedValue = _maskSensitiveValue(key, value);
        logLines.add('║   $key: $maskedValue');
      });
    }

    // Query parameters
    if (options.queryParameters.isNotEmpty) {
      logLines.add('╟───────────────────────────────────────────────────────────');
      logLines.add('║ Query Parameters:');
      options.queryParameters.forEach((key, value) {
        logLines.add('║   $key: $value');
      });
    }

    // Request body
    if (logRequestBody && options.data != null) {
      logLines.add('╟───────────────────────────────────────────────────────────');
      logLines.add('║ Body:');
      logLines.add('║ ${_formatJson(options.data)}');
    }

    // Footer
    logLines.add('╚═══════════════════════════════════════════════════════════');

    // Log to console
    _logToConsole(logLines.join('\n'));
  }

  /// Log HTTP response details
  void _logResponse(Response response) {
    final logLines = <String>[];

    // Header
    logLines.add('╔═══════════════════════════════════════════════════════════');
    logLines.add('║ 📥 RESPONSE');
    logLines.add('╠═══════════════════════════════════════════════════════════');

    // Response info
    logLines.add('║ Status Code: ${response.statusCode}');
    logLines.add('║ Status Message: ${response.statusMessage}');
    logLines.add('║ URL: ${response.requestOptions.uri}');

    // Headers
    if (logResponseHeaders && response.headers.map.isNotEmpty) {
      logLines.add('╟───────────────────────────────────────────────────────────');
      logLines.add('║ Headers:');
      response.headers.map.forEach((key, value) {
        logLines.add('║   $key: ${value.join(', ')}');
      });
    }

    // Response body
    if (logResponseBody && response.data != null) {
      logLines.add('╟───────────────────────────────────────────────────────────');
      logLines.add('║ Body:');
      logLines.add('║ ${_formatJson(response.data)}');
    }

    // Footer
    logLines.add('╚═══════════════════════════════════════════════════════════');

    // Log to console
    _logToConsole(logLines.join('\n'));
  }

  /// Log HTTP error details
  void _logDioError(DioException error) {
    final logLines = <String>[];

    // Header
    logLines.add('╔═══════════════════════════════════════════════════════════');
    logLines.add('║ ❌ ERROR');
    logLines.add('╠═══════════════════════════════════════════════════════════');

    // Error info
    logLines.add('║ Type: ${error.type}');
    logLines.add('║ Message: ${error.message}');

    if (error.response != null) {
      logLines.add('║ Status Code: ${error.response?.statusCode}');
      logLines.add('║ Status Message: ${error.response?.statusMessage}');
      logLines.add('║ URL: ${error.requestOptions.uri}');

      // Error response body
      if (logResponseBody && error.response?.data != null) {
        logLines.add('╟───────────────────────────────────────────────────────────');
        logLines.add('║ Error Response:');
        logLines.add('║ ${_formatJson(error.response?.data)}');
      }
    } else {
      logLines.add('║ URL: ${error.requestOptions.uri}');
      logLines.add('║ No response received');
    }

    // Stack trace (optional, only in debug mode)
    if (kDebugMode) {
      logLines.add('╟───────────────────────────────────────────────────────────');
      logLines.add('║ Stack Trace:');
      final stackTrace = error.stackTrace.toString();
      // Only log first 5 lines of stack trace
      final stackLines = stackTrace.split('\n').take(5);
      for (final line in stackLines) {
        logLines.add('║ $line');
      }
    }

    // Footer
    logLines.add('╚═══════════════════════════════════════════════════════════');

    // Log to console (with error level)
    _logToConsole(logLines.join('\n'), level: 1000);
  }

  // ==================== HELPER METHODS ====================

  /// Format JSON data for logging
  String _formatJson(dynamic data) {
    try {
      if (data is String) {
        return data;
      }
      // Limit JSON string length to avoid huge logs
      final jsonString = data.toString();
      if (jsonString.length > 1000) {
        return '${jsonString.substring(0, 1000)}... (truncated)';
      }
      return jsonString;
    } catch (e) {
      return data.toString();
    }
  }

  /// Mask sensitive values in headers (Authorization, API keys, etc.)
  String _maskSensitiveValue(String key, dynamic value) {
    final lowerKey = key.toLowerCase();
    const sensitiveKeys = [
      'authorization',
      'api-key',
      'api_key',
      'token',
      'password',
      'secret',
    ];

    if (sensitiveKeys.any((k) => lowerKey.contains(k))) {
      final valueStr = value.toString();
      if (valueStr.length > 10) {
        // Show first 10 chars and mask the rest
        return '${valueStr.substring(0, 10)}... (masked)';
      }
      return '*** (masked)';
    }

    return value.toString();
  }

  /// Log message using developer.log for better performance
  void _logToConsole(String message, {int level = 800}) {
    developer.log(
      message,
      name: 'HTTP',
      level: level,
    );
  }
}
