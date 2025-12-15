import 'package:flutter/material.dart';

/// Extensions for the Fashion E-Commerce app
/// Provides convenient extension methods on common types

// ==================== STRING EXTENSIONS ====================

extension StringExtensions on String {
  /// Capitalize first letter of string
  String capitalize() {
    if (isEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1).toLowerCase()}';
  }

  /// Capitalize first letter of each word
  String capitalizeWords() {
    if (isEmpty) return this;
    return split(' ').map((word) => word.capitalize()).join(' ');
  }

  /// Check if string is a valid email
  bool get isValidEmail {
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return emailRegex.hasMatch(this);
  }

  /// Check if string is a valid phone number
  bool get isValidPhone {
    final phoneRegex = RegExp(r'^\d{10,15}$');
    final cleanPhone = replaceAll(RegExp(r'\s+'), '');
    return phoneRegex.hasMatch(cleanPhone);
  }

  /// Check if string is a valid URL
  bool get isValidUrl {
    final urlRegex = RegExp(
      r'^https?:\/\/(www\.)?[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()@:%_\+.~#?&//=]*)$',
    );
    return urlRegex.hasMatch(this);
  }

  /// Remove all whitespace
  String removeWhitespace() {
    return replaceAll(RegExp(r'\s+'), '');
  }

  /// Truncate string to specified length
  String truncate(int maxLength, {String suffix = '...'}) {
    if (length <= maxLength) return this;
    return '${substring(0, maxLength)}$suffix';
  }

  /// Convert string to Title Case
  String toTitleCase() {
    return capitalizeWords();
  }

  /// Check if string contains only digits
  bool get isNumeric {
    return RegExp(r'^\d+$').hasMatch(this);
  }

  /// Check if string contains only alphabets
  bool get isAlphabetic {
    return RegExp(r'^[a-zA-Z]+$').hasMatch(this);
  }

  /// Check if string is alphanumeric
  bool get isAlphanumeric {
    return RegExp(r'^[a-zA-Z0-9]+$').hasMatch(this);
  }

  /// Parse string to int, returns null if invalid
  int? toIntOrNull() {
    return int.tryParse(this);
  }

  /// Parse string to double, returns null if invalid
  double? toDoubleOrNull() {
    return double.tryParse(this);
  }

  /// Check if string is empty or null
  bool get isNullOrEmpty {
    return trim().isEmpty;
  }

  /// Check if string is not empty or null
  bool get isNotNullOrEmpty {
    return trim().isNotEmpty;
  }

  /// Reverse string
  String reverse() {
    return split('').reversed.join();
  }

  /// Count occurrences of a substring
  int countOccurrences(String substring) {
    return substring.allMatches(this).length;
  }

  /// Replace first occurrence
  String replaceFirst(String from, String to) {
    final index = indexOf(from);
    if (index == -1) return this;
    return replaceRange(index, index + from.length, to);
  }
}

// ==================== NULLABLE STRING EXTENSIONS ====================

extension NullableStringExtensions on String? {
  /// Check if string is null or empty
  bool get isNullOrEmpty {
    return this == null || this!.trim().isEmpty;
  }

  /// Check if string is not null or empty
  bool get isNotNullOrEmpty {
    return !isNullOrEmpty;
  }

  /// Get value or default if null
  String orDefault([String defaultValue = '']) {
    return this ?? defaultValue;
  }
}

// ==================== INT EXTENSIONS ====================

extension IntExtensions on int {
  /// Format as currency
  String toCurrency({String symbol = '\$'}) {
    return '$symbol${toStringAsFixed(2)}';
  }

  /// Check if number is even
  bool get isEven => this % 2 == 0;

  /// Check if number is odd
  bool get isOdd => this % 2 != 0;

  /// Clamp value between min and max
  int clampValue(int min, int max) {
    return clamp(min, max).toInt();
  }

  /// Convert to formatted string with thousand separators
  String toFormattedString() {
    return toString().replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match match) => '${match[1]},',
        );
  }
}

// ==================== DOUBLE EXTENSIONS ====================

extension DoubleExtensions on double {
  /// Format as currency
  String toCurrency({String symbol = '\$', int decimals = 2}) {
    return '$symbol${toStringAsFixed(decimals)}';
  }

  /// Format as percentage
  String toPercentage({int decimals = 0}) {
    return '${toStringAsFixed(decimals)}%';
  }

  /// Round to decimal places
  double roundToDecimal(int decimals) {
    final mod = 10.0 * decimals;
    return (this * mod).round() / mod;
  }

  /// Clamp value between min and max
  double clampValue(double min, double max) {
    return clamp(min, max).toDouble();
  }
}

// ==================== DATETIME EXTENSIONS ====================

extension DateTimeExtensions on DateTime {
  /// Check if date is today
  bool get isToday {
    final now = DateTime.now();
    return year == now.year && month == now.month && day == now.day;
  }

  /// Check if date is yesterday
  bool get isYesterday {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return year == yesterday.year &&
        month == yesterday.month &&
        day == yesterday.day;
  }

  /// Check if date is tomorrow
  bool get isTomorrow {
    final tomorrow = DateTime.now().add(const Duration(days: 1));
    return year == tomorrow.year &&
        month == tomorrow.month &&
        day == tomorrow.day;
  }

  /// Check if date is in the past
  bool get isPast {
    return isBefore(DateTime.now());
  }

  /// Check if date is in the future
  bool get isFuture {
    return isAfter(DateTime.now());
  }

  /// Get time ago string (e.g., "2 hours ago")
  String get timeAgo {
    final now = DateTime.now();
    final difference = now.difference(this);

    if (difference.inDays > 365) {
      final years = (difference.inDays / 365).floor();
      return '$years ${years == 1 ? 'year' : 'years'} ago';
    } else if (difference.inDays > 30) {
      final months = (difference.inDays / 30).floor();
      return '$months ${months == 1 ? 'month' : 'months'} ago';
    } else if (difference.inDays > 0) {
      return '${difference.inDays} ${difference.inDays == 1 ? 'day' : 'days'} ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} ${difference.inHours == 1 ? 'hour' : 'hours'} ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} ${difference.inMinutes == 1 ? 'minute' : 'minutes'} ago';
    } else {
      return 'Just now';
    }
  }

  /// Format as "DD/MM/YYYY"
  String toFormattedDate() {
    return '${day.toString().padLeft(2, '0')}/${month.toString().padLeft(2, '0')}/$year';
  }

  /// Format as "DD/MM/YYYY HH:mm"
  String toFormattedDateTime() {
    return '${toFormattedDate()} ${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';
  }

  /// Format as "HH:mm"
  String toFormattedTime() {
    return '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';
  }

  /// Get start of day
  DateTime get startOfDay {
    return DateTime(year, month, day);
  }

  /// Get end of day
  DateTime get endOfDay {
    return DateTime(year, month, day, 23, 59, 59, 999);
  }

  /// Add days
  DateTime addDays(int days) {
    return add(Duration(days: days));
  }

  /// Subtract days
  DateTime subtractDays(int days) {
    return subtract(Duration(days: days));
  }
}

// ==================== LIST EXTENSIONS ====================

extension ListExtensions<T> on List<T> {
  /// Check if list is null or empty
  bool get isNullOrEmpty => isEmpty;

  /// Check if list is not null or empty
  bool get isNotNullOrEmpty => isNotEmpty;

  /// Get first element or null if empty
  T? get firstOrNull => isEmpty ? null : first;

  /// Get last element or null if empty
  T? get lastOrNull => isEmpty ? null : last;

  /// Chunk list into smaller lists of specified size
  List<List<T>> chunk(int size) {
    final chunks = <List<T>>[];
    for (var i = 0; i < length; i += size) {
      chunks.add(sublist(i, i + size > length ? length : i + size));
    }
    return chunks;
  }
}

// ==================== BUILDCONTEXT EXTENSIONS ====================

extension BuildContextExtensions on BuildContext {
  /// Get theme
  ThemeData get theme => Theme.of(this);

  /// Get text theme
  TextTheme get textTheme => Theme.of(this).textTheme;

  /// Get color scheme
  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  /// Get media query
  MediaQueryData get mediaQuery => MediaQuery.of(this);

  /// Get screen size
  Size get screenSize => mediaQuery.size;

  /// Get screen width
  double get screenWidth => screenSize.width;

  /// Get screen height
  double get screenHeight => screenSize.height;

  /// Check if keyboard is visible
  bool get isKeyboardVisible => mediaQuery.viewInsets.bottom > 0;

  /// Get keyboard height
  double get keyboardHeight => mediaQuery.viewInsets.bottom;

  /// Check if device is in dark mode
  bool get isDarkMode => theme.brightness == Brightness.dark;

  /// Check if device is tablet
  bool get isTablet => screenWidth > 600;

  /// Check if device is phone
  bool get isPhone => screenWidth <= 600;

  /// Get safe area padding
  EdgeInsets get safeAreaPadding => mediaQuery.padding;

  /// Get bottom safe area padding
  double get bottomSafeArea => mediaQuery.padding.bottom;

  /// Get top safe area padding
  double get topSafeArea => mediaQuery.padding.top;

  /// Navigate to page
  Future<T?> push<T>(Widget page) {
    return Navigator.of(this).push<T>(
      MaterialPageRoute(builder: (_) => page),
    );
  }

  /// Navigate and replace current page
  Future<T?> pushReplacement<T, TO>(Widget page) {
    return Navigator.of(this).pushReplacement<T, TO>(
      MaterialPageRoute(builder: (_) => page),
    );
  }

  /// Navigate and remove all previous pages
  Future<T?> pushAndRemoveUntil<T>(
    Widget page, {
    bool Function(Route<dynamic>)? predicate,
  }) {
    return Navigator.of(this).pushAndRemoveUntil<T>(
      MaterialPageRoute(builder: (_) => page),
      predicate ?? (route) => false,
    );
  }

  /// Pop current page
  void pop<T>([T? result]) {
    Navigator.of(this).pop(result);
  }

  /// Check if can pop
  bool get canPop => Navigator.of(this).canPop();

  /// Show snackbar
  void showSnackbar(String message, {Duration? duration}) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: duration ?? const Duration(seconds: 3),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  /// Hide keyboard
  void hideKeyboard() {
    FocusScope.of(this).unfocus();
  }

  /// Request focus
  void requestFocus(FocusNode focusNode) {
    FocusScope.of(this).requestFocus(focusNode);
  }
}

// ==================== COLOR EXTENSIONS ====================

extension ColorExtensions on Color {
  /// Convert color to hex string
  String toHex({bool includeAlpha = false}) {
    final alphaValue = ((a * 255.0).round() & 0xff);
    final redValue = ((r * 255.0).round() & 0xff);
    final greenValue = ((g * 255.0).round() & 0xff);
    final blueValue = ((b * 255.0).round() & 0xff);

    if (includeAlpha) {
      return '#${alphaValue.toRadixString(16).padLeft(2, '0')}'
          '${redValue.toRadixString(16).padLeft(2, '0')}'
          '${greenValue.toRadixString(16).padLeft(2, '0')}'
          '${blueValue.toRadixString(16).padLeft(2, '0')}';
    } else {
      return '#${redValue.toRadixString(16).padLeft(2, '0')}'
          '${greenValue.toRadixString(16).padLeft(2, '0')}'
          '${blueValue.toRadixString(16).padLeft(2, '0')}';
    }
  }

  /// Darken color by percentage (0.0 to 1.0)
  Color darken([double amount = 0.1]) {
    assert(amount >= 0 && amount <= 1);
    final hsl = HSLColor.fromColor(this);
    final newLightness = (hsl.lightness - amount).clamp(0.0, 1.0);
    return hsl.withLightness(newLightness).toColor();
  }

  /// Lighten color by percentage (0.0 to 1.0)
  Color lighten([double amount = 0.1]) {
    assert(amount >= 0 && amount <= 1);
    final hsl = HSLColor.fromColor(this);
    final newLightness = (hsl.lightness + amount).clamp(0.0, 1.0);
    return hsl.withLightness(newLightness).toColor();
  }
}
