/// API endpoint paths for the Fashion E-Commerce app
/// Based on the API documentation
/// All endpoints are relative to the base URL (http://127.0.0.1:8000/api)
class ApiEndpoints {
  // Private constructor to prevent instantiation
  ApiEndpoints._();

  // ==================== AUTHENTICATION ENDPOINTS ====================

  /// Register a new user
  /// Method: POST
  /// Content-Type: multipart/form-data
  /// Auth Required: No
  /// Body: name, email, phone, password, image (optional)
  static const String register = '/register';

  /// Login with email and password
  /// Method: POST
  /// Content-Type: application/json
  /// Auth Required: No
  /// Body: email, password
  static const String login = '/login';

  /// Logout current user
  /// Method: POST
  /// Content-Type: application/json
  /// Auth Required: Yes
  static const String logout = '/logout';

  // ==================== PROFILE ENDPOINTS ====================

  /// Get current user's profile data
  /// Method: GET
  /// Auth Required: Yes
  static const String profile = '/profile';

  /// Update user's profile data
  /// Method: POST
  /// Content-Type: multipart/form-data
  /// Auth Required: Yes
  /// Body: name, email, phone, image, address (all optional)
  static const String updateProfile = '/update-profile';

  // ==================== CATEGORY ENDPOINTS ====================

  /// Get all categories
  /// Method: GET
  /// Auth Required: No
  static const String categories = '/categories';

  /// Get category by ID
  /// Method: GET
  /// Auth Required: No
  /// Returns a specific category with its details
  static String categoryById(int id) => '/categories/$id';

  // ==================== PRODUCT ENDPOINTS ====================

  /// Get all products (with optional filters)
  /// Method: GET
  /// Auth Required: Yes
  /// Query Params: name (optional), category_id (optional)
  /// Examples:
  /// - /products
  /// - /products?name=Shirt
  /// - /products?category_id=1
  /// - /products?name=Shirt&category_id=1
  static const String products = '/products';

  /// Get product by ID
  /// Method: GET
  /// Auth Required: Yes
  /// Returns product details with available toppings and sides
  static String productById(int id) => '/products/$id';

  // ==================== FAVORITE ENDPOINTS ====================

  /// Toggle favorite (add/remove)
  /// Method: POST
  /// Content-Type: application/json
  /// Auth Required: Yes
  /// Body: product_id
  static const String toggleFavorite = '/toggle-favorite';

  /// Get user's favorite products
  /// Method: GET
  /// Auth Required: Yes
  static const String favorites = '/favorites';

  // ==================== PRODUCT OPTIONS ENDPOINTS ====================

  /// Get all available toppings
  /// Method: GET
  /// Auth Required: Yes
  static const String toppings = '/toppings';

  /// Get all available side options
  /// Method: GET
  /// Auth Required: Yes
  static const String sideOptions = '/side-options';

  // ==================== CART ENDPOINTS ====================

  /// Add items to cart
  /// Method: POST
  /// Content-Type: application/json
  /// Auth Required: Yes
  /// Body: { items: [{ product_id, quantity, spicy, toppings[], side_options[] }] }
  static const String addToCart = '/cart/add';

  /// Get user's cart
  /// Method: GET
  /// Auth Required: Yes
  static const String cart = '/cart';

  /// Remove item from cart
  /// Method: DELETE
  /// Auth Required: Yes
  /// Path param: cart_item_id
  static String removeFromCart(int cartItemId) => '/cart/remove/$cartItemId';

  // ==================== ORDER ENDPOINTS ====================

  /// Create a new order
  /// Method: POST
  /// Content-Type: application/json
  /// Auth Required: Yes
  /// Body: { items: [{ product_id, quantity, spicy, toppings[], side_options[] }] }
  static const String createOrder = '/orders';

  /// Get all user orders
  /// Method: GET
  /// Auth Required: Yes
  static const String orders = '/orders';

  /// Get order details by ID
  /// Method: GET
  /// Auth Required: Yes
  /// Path param: order_id
  static String orderById(int orderId) => '/orders/$orderId';

  // ==================== SEARCH ENDPOINTS ====================

  /// Search products by name
  /// Method: GET
  /// Auth Required: Yes
  /// Query param: name
  /// Example: /products?name=searchQuery
  static String searchProducts(String query) => '/products?name=$query';

  /// Search products by name and category
  /// Method: GET
  /// Auth Required: Yes
  /// Query params: name, category_id
  static String searchProductsByCategory(String query, int categoryId) =>
      '/products?name=$query&category_id=$categoryId';

  // ==================== HELPER METHODS ====================

  /// Build products endpoint with query parameters
  /// Supports filtering by name and/or category
  static String buildProductsUrl({String? name, int? categoryId}) {
    final queryParams = <String>[];

    if (name != null && name.isNotEmpty) {
      queryParams.add('name=$name');
    }

    if (categoryId != null) {
      queryParams.add('category_id=$categoryId');
    }

    if (queryParams.isEmpty) {
      return products;
    }

    return '$products?${queryParams.join('&')}';
  }

  /// Build URL with query parameters
  static String buildUrlWithParams(
    String endpoint,
    Map<String, dynamic> params,
  ) {
    if (params.isEmpty) return endpoint;

    final queryParams = params.entries
        .where((entry) => entry.value != null)
        .map((entry) => '${entry.key}=${entry.value}')
        .join('&');

    return queryParams.isEmpty ? endpoint : '$endpoint?$queryParams';
  }

  /// Check if endpoint requires authentication
  static bool requiresAuth(String endpoint) {
    // Endpoints that DON'T require authentication
    const noAuthEndpoints = [
      register,
      login,
      categories,
    ];

    return !noAuthEndpoints.contains(endpoint);
  }

  /// Get HTTP method for endpoint
  static String getMethod(String endpoint) {
    // GET endpoints
    if (endpoint == profile ||
        endpoint == categories ||
        endpoint == products ||
        endpoint == favorites ||
        endpoint == toppings ||
        endpoint == sideOptions ||
        endpoint == cart ||
        endpoint == orders ||
        endpoint.startsWith('/products/') ||
        endpoint.startsWith('/categories/') ||
        endpoint.startsWith('/orders/')) {
      return 'GET';
    }

    // DELETE endpoints
    if (endpoint.startsWith('/cart/remove/')) {
      return 'DELETE';
    }

    // POST endpoints (default for most actions)
    return 'POST';
  }

  /// Check if endpoint uses multipart/form-data
  static bool usesMultipart(String endpoint) {
    return endpoint == register || endpoint == updateProfile;
  }
}
