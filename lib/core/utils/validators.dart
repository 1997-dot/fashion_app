import 'package:fashion_app/core/constants/app_constants.dart';

/// Input validators for the Fashion E-Commerce app
/// Used for form validation across the application
/// Returns error message if validation fails, null if valid
class Validators {
  // Private constructor to prevent instantiation
  Validators._();

  // ==================== EMAIL VALIDATION ====================

  /// Validate email address
  /// Returns error message if invalid, null if valid
  static String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email is required';
    }

    final email = value.trim();
    final emailRegex = RegExp(AppConstants.emailRegex);

    if (!emailRegex.hasMatch(email)) {
      return 'Please enter a valid email address';
    }

    return null;
  }

  // ==================== PASSWORD VALIDATION ====================

  /// Validate password
  /// Returns error message if invalid, null if valid
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }

    if (value.length < AppConstants.minPasswordLength) {
      return 'Password must be at least ${AppConstants.minPasswordLength} characters';
    }

    if (value.length > AppConstants.maxPasswordLength) {
      return 'Password must not exceed ${AppConstants.maxPasswordLength} characters';
    }

    // Check if password contains at least one letter and one number
    final hasLetter = value.contains(RegExp(r'[A-Za-z]'));
    final hasDigit = value.contains(RegExp(r'\d'));

    if (!hasLetter || !hasDigit) {
      return 'Password must contain at least one letter and one number';
    }

    return null;
  }

  /// Validate confirm password
  /// Checks if confirm password matches the original password
  static String? validateConfirmPassword(String? value, String? password) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }

    if (value != password) {
      return 'Passwords do not match';
    }

    return null;
  }

  // ==================== NAME VALIDATION ====================

  /// Validate name (username, full name, etc.)
  /// Returns error message if invalid, null if valid
  static String? validateName(String? value, {String fieldName = 'Name'}) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required';
    }

    final name = value.trim();

    if (name.length < AppConstants.minUsernameLength) {
      return '$fieldName must be at least ${AppConstants.minUsernameLength} characters';
    }

    if (name.length > AppConstants.maxUsernameLength) {
      return '$fieldName must not exceed ${AppConstants.maxUsernameLength} characters';
    }

    return null;
  }

  // ==================== PHONE VALIDATION ====================

  /// Validate phone number
  /// Returns error message if invalid, null if valid
  static String? validatePhone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Phone number is required';
    }

    final phone = value.trim().replaceAll(RegExp(r'\s+'), '');
    final phoneRegex = RegExp(AppConstants.phoneRegex);

    if (!phoneRegex.hasMatch(phone)) {
      return 'Please enter a valid phone number (10-15 digits)';
    }

    return null;
  }

  // ==================== REQUIRED FIELD VALIDATION ====================

  /// Validate required field
  /// Generic validator for any required field
  static String? validateRequired(String? value, {String fieldName = 'Field'}) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required';
    }
    return null;
  }

  // ==================== ADDRESS VALIDATION ====================

  /// Validate address
  /// Returns error message if invalid, null if valid
  static String? validateAddress(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Address is required';
    }

    final address = value.trim();

    if (address.length < 10) {
      return 'Address must be at least 10 characters';
    }

    if (address.length > AppConstants.maxAddressLength) {
      return 'Address must not exceed ${AppConstants.maxAddressLength} characters';
    }

    return null;
  }

  // ==================== NUMERIC VALIDATION ====================

  /// Validate number (positive integer)
  /// Returns error message if invalid, null if valid
  static String? validateNumber(String? value, {String fieldName = 'Number'}) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required';
    }

    final number = int.tryParse(value.trim());

    if (number == null) {
      return 'Please enter a valid number';
    }

    if (number < 0) {
      return '$fieldName must be a positive number';
    }

    return null;
  }

  /// Validate quantity
  /// Validates cart item quantity within allowed range
  static String? validateQuantity(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Quantity is required';
    }

    final quantity = int.tryParse(value.trim());

    if (quantity == null) {
      return 'Please enter a valid quantity';
    }

    if (quantity < AppConstants.minCartQuantity) {
      return 'Quantity must be at least ${AppConstants.minCartQuantity}';
    }

    if (quantity > AppConstants.maxCartQuantity) {
      return 'Quantity must not exceed ${AppConstants.maxCartQuantity}';
    }

    return null;
  }

  // ==================== PRICE VALIDATION ====================

  /// Validate price (positive decimal)
  /// Returns error message if invalid, null if valid
  static String? validatePrice(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Price is required';
    }

    final price = double.tryParse(value.trim());

    if (price == null) {
      return 'Please enter a valid price';
    }

    if (price < 0) {
      return 'Price must be a positive number';
    }

    return null;
  }

  // ==================== URL VALIDATION ====================

  /// Validate URL
  /// Returns error message if invalid, null if valid
  static String? validateUrl(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'URL is required';
    }

    final url = value.trim();
    final urlRegex = RegExp(AppConstants.urlRegex);

    if (!urlRegex.hasMatch(url)) {
      return 'Please enter a valid URL';
    }

    return null;
  }

  // ==================== LENGTH VALIDATION ====================

  /// Validate minimum length
  /// Generic validator for minimum string length
  static String? validateMinLength(
    String? value,
    int minLength, {
    String fieldName = 'Field',
  }) {
    if (value == null || value.isEmpty) {
      return '$fieldName is required';
    }

    if (value.length < minLength) {
      return '$fieldName must be at least $minLength characters';
    }

    return null;
  }

  /// Validate maximum length
  /// Generic validator for maximum string length
  static String? validateMaxLength(
    String? value,
    int maxLength, {
    String fieldName = 'Field',
  }) {
    if (value == null || value.isEmpty) {
      return null; // Optional field
    }

    if (value.length > maxLength) {
      return '$fieldName must not exceed $maxLength characters';
    }

    return null;
  }

  /// Validate length range
  /// Generic validator for string length within a range
  static String? validateLengthRange(
    String? value,
    int minLength,
    int maxLength, {
    String fieldName = 'Field',
  }) {
    if (value == null || value.isEmpty) {
      return '$fieldName is required';
    }

    if (value.length < minLength) {
      return '$fieldName must be at least $minLength characters';
    }

    if (value.length > maxLength) {
      return '$fieldName must not exceed $maxLength characters';
    }

    return null;
  }

  // ==================== CREDIT CARD VALIDATION ====================

  /// Validate credit card number (basic validation)
  /// Returns error message if invalid, null if valid
  static String? validateCreditCard(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Card number is required';
    }

    final cardNumber = value.trim().replaceAll(RegExp(r'\s+'), '');

    if (cardNumber.length < 13 || cardNumber.length > 19) {
      return 'Please enter a valid card number';
    }

    if (!RegExp(r'^\d+$').hasMatch(cardNumber)) {
      return 'Card number must contain only digits';
    }

    return null;
  }

  /// Validate CVV
  /// Returns error message if invalid, null if valid
  static String? validateCVV(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'CVV is required';
    }

    final cvv = value.trim();

    if (cvv.length < 3 || cvv.length > 4) {
      return 'CVV must be 3 or 4 digits';
    }

    if (!RegExp(r'^\d+$').hasMatch(cvv)) {
      return 'CVV must contain only digits';
    }

    return null;
  }

  /// Validate expiry date (MM/YY format)
  /// Returns error message if invalid, null if valid
  static String? validateExpiryDate(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Expiry date is required';
    }

    final expiry = value.trim();

    if (!RegExp(r'^\d{2}/\d{2}$').hasMatch(expiry)) {
      return 'Expiry date must be in MM/YY format';
    }

    final parts = expiry.split('/');
    final month = int.tryParse(parts[0]);
    final year = int.tryParse(parts[1]);

    if (month == null || year == null) {
      return 'Invalid expiry date';
    }

    if (month < 1 || month > 12) {
      return 'Invalid month';
    }

    // Check if card is expired
    final now = DateTime.now();
    final currentYear = now.year % 100; // Get last 2 digits
    final currentMonth = now.month;

    if (year < currentYear || (year == currentYear && month < currentMonth)) {
      return 'Card has expired';
    }

    return null;
  }

  // ==================== SEARCH VALIDATION ====================

  /// Validate search query
  /// Returns error message if invalid, null if valid
  static String? validateSearchQuery(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter a search term';
    }

    final query = value.trim();

    if (query.length < 2) {
      return 'Search term must be at least 2 characters';
    }

    if (query.length > AppConstants.maxSearchLength) {
      return 'Search term is too long';
    }

    return null;
  }
}
