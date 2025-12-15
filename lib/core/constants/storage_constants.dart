/// SharedPreferences storage keys for the Fashion E-Commerce app
/// Used for local data persistence (authentication tokens, user data, settings)
class StorageConstants {
  // Private constructor to prevent instantiation
  StorageConstants._();

  // ==================== AUTHENTICATION ====================

  /// Key for storing authentication token
  /// Type: String
  /// Used by: AuthInterceptor, AuthLocalDataSource
  static const String authToken = 'auth_token';

  /// Key for storing user data (JSON string)
  /// Type: String (JSON)
  /// Used by: AuthLocalDataSource
  static const String userData = 'user_data';

  /// Key for checking if user is logged in
  /// Type: bool
  /// Used by: SplashBloc, AuthBloc
  static const String isLoggedIn = 'is_logged_in';

  /// Key for storing user ID
  /// Type: int
  /// Used by: AuthLocalDataSource
  static const String userId = 'user_id';

  /// Key for storing user email
  /// Type: String
  /// Used by: AuthLocalDataSource
  static const String userEmail = 'user_email';

  /// Key for storing user name
  /// Type: String
  /// Used by: AuthLocalDataSource
  static const String userName = 'user_name';

  /// Key for storing user phone
  /// Type: String
  /// Used by: AuthLocalDataSource
  static const String userPhone = 'user_phone';

  /// Key for storing user profile image URL
  /// Type: String
  /// Used by: AuthLocalDataSource
  static const String userImage = 'user_image';

  /// Key for storing user address
  /// Type: String
  /// Used by: ProfileLocalDataSource
  static const String userAddress = 'user_address';

  // ==================== APP SETTINGS ====================

  /// Key for first app launch detection
  /// Type: bool
  /// Used by: SplashBloc, OnboardingBloc
  static const String isFirstLaunch = 'is_first_launch';

  /// Key for app theme mode (dark/light)
  /// Type: String ('dark' or 'light')
  /// Used by: ThemeBloc
  static const String themeMode = 'theme_mode';

  /// Key for app language/locale
  /// Type: String (language code)
  /// Used by: LocaleBloc
  static const String language = 'language';

  /// Key for notification settings
  /// Type: bool
  /// Used by: SettingsBloc
  static const String notificationsEnabled = 'notifications_enabled';

  // ==================== CART & FAVORITES ====================

  /// Key for storing cart items (JSON string)
  /// Type: String (JSON array)
  /// Used by: CartLocalDataSource
  static const String cartItems = 'cart_items';

  /// Key for storing cart item count
  /// Type: int
  /// Used by: CartBloc
  static const String cartItemCount = 'cart_item_count';

  /// Key for storing favorite product IDs (JSON string)
  /// Type: String (JSON array of integers)
  /// Used by: FavoriteLocalDataSource
  static const String favoriteProductIds = 'favorite_product_ids';

  // ==================== SEARCH & FILTERS ====================

  /// Key for storing recent search queries (JSON string)
  /// Type: String (JSON array)
  /// Used by: SearchBloc
  static const String recentSearches = 'recent_searches';

  /// Key for storing last selected category ID
  /// Type: int
  /// Used by: ProductsBloc
  static const String lastCategoryId = 'last_category_id';

  // ==================== CACHE ====================

  /// Key for storing cached products (JSON string)
  /// Type: String (JSON array)
  /// Used by: ProductLocalDataSource
  static const String cachedProducts = 'cached_products';

  /// Key for storing cached categories (JSON string)
  /// Type: String (JSON array)
  /// Used by: ProductLocalDataSource
  static const String cachedCategories = 'cached_categories';

  /// Key for storing cache timestamp
  /// Type: String (ISO 8601 datetime)
  /// Used by: Cache management
  static const String cacheTimestamp = 'cache_timestamp';

  /// Key for storing last cache update time
  /// Type: int (milliseconds since epoch)
  /// Used by: Cache validation
  static const String lastCacheUpdate = 'last_cache_update';

  // ==================== ONBOARDING & INTRO ====================

  /// Key for tracking if onboarding was completed
  /// Type: bool
  /// Used by: OnboardingBloc
  static const String onboardingCompleted = 'onboarding_completed';

  /// Key for tracking current onboarding page
  /// Type: int
  /// Used by: OnboardingBloc
  static const String onboardingCurrentPage = 'onboarding_current_page';

  // ==================== HELPER METHODS ====================

  /// Get all authentication-related keys
  static List<String> get authKeys => [
        authToken,
        userData,
        isLoggedIn,
        userId,
        userEmail,
        userName,
        userPhone,
        userImage,
        userAddress,
      ];

  /// Get all cache-related keys
  static List<String> get cacheKeys => [
        cachedProducts,
        cachedCategories,
        cacheTimestamp,
        lastCacheUpdate,
      ];

  /// Get all user-specific keys (for logout clearing)
  static List<String> get userSpecificKeys => [
        ...authKeys,
        cartItems,
        cartItemCount,
        favoriteProductIds,
        recentSearches,
        lastCategoryId,
      ];

  /// Get all app settings keys
  static List<String> get settingsKeys => [
        themeMode,
        language,
        notificationsEnabled,
        isFirstLaunch,
        onboardingCompleted,
        onboardingCurrentPage,
      ];

  /// Check if a key is authentication-related
  static bool isAuthKey(String key) => authKeys.contains(key);

  /// Check if a key is cache-related
  static bool isCacheKey(String key) => cacheKeys.contains(key);

  /// Check if a key is user-specific (should be cleared on logout)
  static bool isUserSpecificKey(String key) => userSpecificKeys.contains(key);
}
