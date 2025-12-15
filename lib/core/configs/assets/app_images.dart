/// Image asset paths for the Fashion E-Commerce app
/// All images are organized by category in assets/images/
class AppImages {
  // Private constructor to prevent instantiation
  AppImages._();

  // ==================== SPLASH SCREEN ====================

  /// Splash screen image
  static const String splash = 'assets/images/splash/splash.png';

  // ==================== MEN'S FASHION ====================

  /// Men's fashion product image 1
  static const String man1 = 'assets/images/men/man1.png';

  /// Men's fashion product image 2
  static const String man2 = 'assets/images/men/man2.png';

  /// Men's fashion product image 3
  static const String man3 = 'assets/images/men/man3.png';

  /// Men's fashion product image 4
  static const String man4 = 'assets/images/men/man4.png';

  /// Men's fashion product image 5
  static const String man5 = 'assets/images/men/man5.png';

  /// List of all men's fashion images
  static const List<String> menImages = [
    man1,
    man2,
    man3,
    man4,
    man5,
  ];

  // ==================== WOMEN'S FASHION ====================

  /// Women's fashion product image 1
  static const String woman1 = 'assets/images/women/woman1.png';

  /// Women's fashion product image 2
  static const String woman2 = 'assets/images/women/woman2.png';

  /// Women's fashion product image 3
  static const String woman3 = 'assets/images/women/woman3.png';

  /// Women's fashion product image 4
  static const String woman4 = 'assets/images/women/woman4.png';

  /// Women's fashion product image 5
  static const String woman5 = 'assets/images/women/woman5.png';

  /// List of all women's fashion images
  static const List<String> womenImages = [
    woman1,
    woman2,
    woman3,
    woman4,
    woman5,
  ];

  // ==================== BOYS' FASHION ====================

  /// Boys' fashion product image 1
  static const String boy1 = 'assets/images/boys/boy1.png';

  /// Boys' fashion product image 2
  static const String boy2 = 'assets/images/boys/boy2.png';

  /// Boys' fashion product image 3
  static const String boy3 = 'assets/images/boys/boy3.png';

  /// Boys' fashion product image 4
  static const String boy4 = 'assets/images/boys/boy4.png';

  /// Boys' fashion product image 5
  static const String boy5 = 'assets/images/boys/boy5.png';

  /// List of all boys' fashion images
  static const List<String> boysImages = [
    boy1,
    boy2,
    boy3,
    boy4,
    boy5,
  ];

  // ==================== GIRLS' FASHION ====================

  /// Girls' fashion product image 1
  static const String girl1 = 'assets/images/girls/girl1.png';

  /// Girls' fashion product image 2
  static const String girl2 = 'assets/images/girls/girl2.png';

  /// Girls' fashion product image 3
  static const String girl3 = 'assets/images/girls/girl3.png';

  /// Girls' fashion product image 4
  static const String girl4 = 'assets/images/girls/girl4.png';

  /// Girls' fashion product image 5
  static const String girl5 = 'assets/images/girls/girl5.png';

  /// List of all girls' fashion images
  static const List<String> girlsImages = [
    girl1,
    girl2,
    girl3,
    girl4,
    girl5,
  ];

  // ==================== GROUPED COLLECTIONS ====================

  /// All product images organized by category
  static const Map<String, List<String>> imagesByCategory = {
    'men': menImages,
    'women': womenImages,
    'boys': boysImages,
    'girls': girlsImages,
  };

  /// All product images in a single list
  static const List<String> allProductImages = [
    ...menImages,
    ...womenImages,
    ...boysImages,
    ...girlsImages,
  ];

  // ==================== HELPER METHODS ====================

  /// Get images for a specific category
  /// Returns empty list if category not found
  static List<String> getImagesByCategory(String category) {
    return imagesByCategory[category.toLowerCase()] ?? [];
  }

  /// Get random image from a specific category
  static String? getRandomImageFromCategory(String category) {
    final images = getImagesByCategory(category);
    if (images.isEmpty) return null;
    return images[(DateTime.now().millisecondsSinceEpoch % images.length)];
  }

  /// Get total number of images
  static int get totalImages => allProductImages.length + 1; // +1 for splash

  /// Get number of images in a category
  static int getImagesCountByCategory(String category) {
    return getImagesByCategory(category).length;
  }

  /// Check if category exists
  static bool categoryExists(String category) {
    return imagesByCategory.containsKey(category.toLowerCase());
  }

  /// Get all available categories
  static List<String> get availableCategories =>
      imagesByCategory.keys.toList();
}
