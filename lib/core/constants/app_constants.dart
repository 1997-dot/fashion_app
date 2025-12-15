/// General application constants for the Fashion E-Commerce app
/// Contains app-wide configuration values, limits, and defaults
class AppConstants {
  // Private constructor to prevent instantiation
  AppConstants._();

  // ==================== APP INFORMATION ====================

  /// Application name
  static const String appName = 'Fashion App';

  /// Application tagline
  static const String appTagline = 'DISCOVER YOUR STYLE.';

  /// Application version
  static const String appVersion = '1.0.0';

  /// Build number
  static const int buildNumber = 1;

  // ==================== PAGINATION ====================

  /// Default number of items per page
  static const int defaultPageSize = 20;

  /// Maximum number of items per page
  static const int maxPageSize = 100;

  /// Initial page number
  static const int initialPage = 1;

  // ==================== VALIDATION LIMITS ====================

  /// Minimum password length
  static const int minPasswordLength = 8;

  /// Maximum password length
  static const int maxPasswordLength = 50;

  /// Minimum username length
  static const int minUsernameLength = 3;

  /// Maximum username length
  static const int maxUsernameLength = 50;

  /// Maximum phone number length
  static const int maxPhoneLength = 15;

  /// Minimum phone number length
  static const int minPhoneLength = 10;

  /// Maximum address length
  static const int maxAddressLength = 200;

  /// Maximum search query length
  static const int maxSearchLength = 100;

  // ==================== FILE UPLOAD LIMITS ====================

  /// Maximum image file size in MB
  static const int maxImageSizeMB = 5;

  /// Maximum image file size in bytes
  static const int maxImageSizeBytes = maxImageSizeMB * 1024 * 1024;

  /// Allowed image file extensions
  static const List<String> allowedImageExtensions = [
    '.jpg',
    '.jpeg',
    '.png',
    '.gif',
    '.webp',
  ];

  /// Allowed image MIME types
  static const List<String> allowedImageMimeTypes = [
    'image/jpeg',
    'image/png',
    'image/gif',
    'image/webp',
  ];

  // ==================== CACHE SETTINGS ====================

  /// Cache duration in hours
  static const int cacheDurationHours = 24;

  /// Cache duration in minutes
  static const int cacheDurationMinutes = cacheDurationHours * 60;

  /// Maximum number of recent searches to save
  static const int maxRecentSearches = 10;

  /// Maximum number of cached products
  static const int maxCachedProducts = 100;

  // ==================== UI SETTINGS ====================

  /// Animation duration in milliseconds
  static const int animationDurationMs = 300;

  /// Long animation duration in milliseconds
  static const int longAnimationDurationMs = 500;

  /// Short animation duration in milliseconds
  static const int shortAnimationDurationMs = 150;

  /// Debounce duration for search (milliseconds)
  static const int searchDebounceDurationMs = 500;

  /// Splash screen duration in seconds
  static const int splashDurationSeconds = 2;

  /// Snackbar duration in seconds
  static const int snackbarDurationSeconds = 3;

  /// Toast duration in seconds
  static const int toastDurationSeconds = 2;

  // ==================== CART SETTINGS ====================

  /// Minimum cart item quantity
  static const int minCartQuantity = 1;

  /// Maximum cart item quantity
  static const int maxCartQuantity = 99;

  /// Default cart item quantity
  static const int defaultCartQuantity = 1;

  // ==================== CUSTOMIZATION SETTINGS ====================

  /// Minimum spicy level (0%)
  static const double minSpicyLevel = 0.0;

  /// Maximum spicy level (100%)
  static const double maxSpicyLevel = 1.0;

  /// Default spicy level (0%)
  static const double defaultSpicyLevel = 0.0;

  /// Spicy level step (10%)
  static const double spicyLevelStep = 0.1;

  // ==================== PRICE SETTINGS ====================

  /// Currency symbol
  static const String currencySymbol = '\$';

  /// Currency code
  static const String currencyCode = 'USD';

  /// Decimal places for price display
  static const int priceDecimalPlaces = 2;

  /// Minimum order amount
  static const double minOrderAmount = 1.0;

  // ==================== RATING SETTINGS ====================

  /// Minimum rating
  static const double minRating = 0.0;

  /// Maximum rating
  static const double maxRating = 5.0;

  /// Default rating
  static const double defaultRating = 0.0;

  // ==================== ORDER STATUS ====================

  /// Order status values
  static const String orderStatusPending = 'pending';
  static const String orderStatusConfirmed = 'confirmed';
  static const String orderStatusPreparing = 'preparing';
  static const String orderStatusReady = 'ready';
  static const String orderStatusOnTheWay = 'on_the_way';
  static const String orderStatusDelivered = 'delivered';
  static const String orderStatusCancelled = 'cancelled';

  /// All order statuses
  static const List<String> orderStatuses = [
    orderStatusPending,
    orderStatusConfirmed,
    orderStatusPreparing,
    orderStatusReady,
    orderStatusOnTheWay,
    orderStatusDelivered,
    orderStatusCancelled,
  ];

  // ==================== PAYMENT METHODS ====================

  /// Payment method: Credit Card
  static const String paymentCreditCard = 'credit_card';

  /// Payment method: PayPal
  static const String paymentPayPal = 'paypal';

  /// Payment method: Cash on Delivery
  static const String paymentCashOnDelivery = 'cash_on_delivery';

  /// All payment methods
  static const List<String> paymentMethods = [
    paymentCreditCard,
    paymentPayPal,
    paymentCashOnDelivery,
  ];

  // ==================== REGEX PATTERNS ====================

  /// Email validation regex
  static const String emailRegex =
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';

  /// Phone number validation regex (digits only)
  static const String phoneRegex = r'^\d{10,15}$';

  /// Password validation regex (at least 8 chars, 1 letter, 1 number)
  static const String passwordRegex =
      r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d@$!%*#?&]{8,}$';

  /// URL validation regex
  static const String urlRegex =
      r'^https?:\/\/(www\.)?[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()@:%_\+.~#?&//=]*)$';

  // ==================== DATE FORMATS ====================

  /// Standard date format (DD/MM/YYYY)
  static const String dateFormat = 'dd/MM/yyyy';

  /// Date with time format (DD/MM/YYYY HH:mm)
  static const String dateTimeFormat = 'dd/MM/yyyy HH:mm';

  /// Time format (HH:mm)
  static const String timeFormat = 'HH:mm';

  /// Month year format (MMM yyyy)
  static const String monthYearFormat = 'MMM yyyy';

  /// Full date format (EEEE, dd MMMM yyyy)
  static const String fullDateFormat = 'EEEE, dd MMMM yyyy';

  // ==================== HELPER METHODS ====================

  /// Check if order status is active (not delivered or cancelled)
  static bool isActiveOrderStatus(String status) {
    return status != orderStatusDelivered && status != orderStatusCancelled;
  }

  /// Check if order status is final (delivered or cancelled)
  static bool isFinalOrderStatus(String status) {
    return status == orderStatusDelivered || status == orderStatusCancelled;
  }

  /// Get order status display name
  static String getOrderStatusDisplayName(String status) {
    switch (status) {
      case orderStatusPending:
        return 'Pending';
      case orderStatusConfirmed:
        return 'Confirmed';
      case orderStatusPreparing:
        return 'Preparing';
      case orderStatusReady:
        return 'Ready';
      case orderStatusOnTheWay:
        return 'On the Way';
      case orderStatusDelivered:
        return 'Delivered';
      case orderStatusCancelled:
        return 'Cancelled';
      default:
        return status;
    }
  }

  /// Get payment method display name
  static String getPaymentMethodDisplayName(String method) {
    switch (method) {
      case paymentCreditCard:
        return 'Credit Card';
      case paymentPayPal:
        return 'PayPal';
      case paymentCashOnDelivery:
        return 'Cash on Delivery';
      default:
        return method;
    }
  }

  /// Format price with currency symbol
  static String formatPrice(double price) {
    return '$currencySymbol${price.toStringAsFixed(priceDecimalPlaces)}';
  }

  /// Validate quantity
  static bool isValidQuantity(int quantity) {
    return quantity >= minCartQuantity && quantity <= maxCartQuantity;
  }

  /// Validate spicy level
  static bool isValidSpicyLevel(double level) {
    return level >= minSpicyLevel && level <= maxSpicyLevel;
  }

  /// Clamp quantity to valid range
  static int clampQuantity(int quantity) {
    return quantity.clamp(minCartQuantity, maxCartQuantity);
  }

  /// Clamp spicy level to valid range
  static double clampSpicyLevel(double level) {
    return level.clamp(minSpicyLevel, maxSpicyLevel);
  }
}
