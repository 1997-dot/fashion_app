import 'package:flutter/material.dart';

/// Pure Dart navigation helper for the Fashion E-Commerce app
/// Provides clean navigation methods without requiring BuildContext extensions
/// Follows Clean Architecture by keeping navigation logic separate
///
/// Usage:
/// ```dart
/// // Navigate to a new page
/// AppNavigator.push(context, ProductDetailPage(productId: 1));
///
/// // Replace current page
/// AppNavigator.pushReplacement(context, HomePage());
///
/// // Navigate and clear all previous routes
/// AppNavigator.pushAndRemoveUntil(context, SignInPage());
///
/// // Pop current page
/// AppNavigator.pop(context);
///
/// // Pop with result
/// AppNavigator.pop(context, result: selectedProduct);
/// ```
class AppNavigator {
  // Private constructor to prevent instantiation
  AppNavigator._();

  // ==================== BASIC NAVIGATION ====================

  /// Navigate to a new page
  /// Pushes a new route onto the navigation stack
  ///
  /// Parameters:
  /// - [context]: BuildContext for navigation
  /// - [page]: Widget to navigate to
  ///
  /// Returns: Future that completes when the pushed route is popped
  /// with the value passed to [pop]
  ///
  /// Example:
  /// ```dart
  /// final result = await AppNavigator.push(
  ///   context,
  ///   ProductDetailPage(productId: 1),
  /// );
  /// if (result != null) {
  ///   print('Product selected: $result');
  /// }
  /// ```
  static Future<T?> push<T>(BuildContext context, Widget page) {
    return Navigator.of(context).push<T>(
      MaterialPageRoute(builder: (_) => page),
    );
  }

  /// Navigate to a new page with custom route
  /// Allows custom transitions, animations, etc.
  ///
  /// Example:
  /// ```dart
  /// AppNavigator.pushRoute(
  ///   context,
  ///   PageRouteBuilder(
  ///     pageBuilder: (_, __, ___) => ProductDetailPage(),
  ///     transitionsBuilder: (_, animation, __, child) {
  ///       return FadeTransition(opacity: animation, child: child);
  ///     },
  ///   ),
  /// );
  /// ```
  static Future<T?> pushRoute<T>(BuildContext context, Route<T> route) {
    return Navigator.of(context).push(route);
  }

  /// Navigate to a new page and replace the current one
  /// Removes the current route and replaces it with a new one
  ///
  /// Example:
  /// ```dart
  /// // After successful login, replace login page with home page
  /// AppNavigator.pushReplacement(context, HomePage());
  /// ```
  static Future<T?> pushReplacement<T, TO>(
    BuildContext context,
    Widget page, {
    TO? result,
  }) {
    return Navigator.of(context).pushReplacement<T, TO>(
      MaterialPageRoute(builder: (_) => page),
      result: result,
    );
  }

  /// Navigate to a new page and replace with custom route
  static Future<T?> pushReplacementRoute<T, TO>(
    BuildContext context,
    Route<T> route, {
    TO? result,
  }) {
    return Navigator.of(context).pushReplacement(route, result: result);
  }

  /// Navigate to a new page and remove all previous routes
  /// Useful for logout, going to home after deep linking, etc.
  ///
  /// Parameters:
  /// - [context]: BuildContext for navigation
  /// - [page]: Widget to navigate to
  /// - [predicate]: Optional function to determine which routes to remove
  ///   If null, removes all previous routes
  ///
  /// Example:
  /// ```dart
  /// // After logout, clear all routes and go to sign in
  /// AppNavigator.pushAndRemoveUntil(context, SignInPage());
  ///
  /// // Keep routes until you reach the home page
  /// AppNavigator.pushAndRemoveUntil(
  ///   context,
  ///   ProductDetailPage(),
  ///   predicate: (route) => route.settings.name == '/home',
  /// );
  /// ```
  static Future<T?> pushAndRemoveUntil<T>(
    BuildContext context,
    Widget page, {
    bool Function(Route<dynamic>)? predicate,
  }) {
    return Navigator.of(context).pushAndRemoveUntil<T>(
      MaterialPageRoute(builder: (_) => page),
      predicate ?? (route) => false,
    );
  }

  /// Navigate to a new page and remove all previous routes with custom route
  static Future<T?> pushAndRemoveUntilRoute<T>(
    BuildContext context,
    Route<T> route, {
    bool Function(Route<dynamic>)? predicate,
  }) {
    return Navigator.of(context).pushAndRemoveUntil(
      route,
      predicate ?? (route) => false,
    );
  }

  // ==================== NAMED ROUTES ====================

  /// Navigate to a named route
  ///
  /// Example:
  /// ```dart
  /// AppNavigator.pushNamed(context, '/product-detail', arguments: {'id': 1});
  /// ```
  static Future<T?> pushNamed<T>(
    BuildContext context,
    String routeName, {
    Object? arguments,
  }) {
    return Navigator.of(context).pushNamed<T>(
      routeName,
      arguments: arguments,
    );
  }

  /// Navigate to a named route and replace current one
  static Future<T?> pushReplacementNamed<T, TO>(
    BuildContext context,
    String routeName, {
    TO? result,
    Object? arguments,
  }) {
    return Navigator.of(context).pushReplacementNamed<T, TO>(
      routeName,
      result: result,
      arguments: arguments,
    );
  }

  /// Navigate to a named route and remove all previous routes
  static Future<T?> pushNamedAndRemoveUntil<T>(
    BuildContext context,
    String routeName, {
    bool Function(Route<dynamic>)? predicate,
    Object? arguments,
  }) {
    return Navigator.of(context).pushNamedAndRemoveUntil<T>(
      routeName,
      predicate ?? (route) => false,
      arguments: arguments,
    );
  }

  // ==================== POP OPERATIONS ====================

  /// Pop the current route
  /// Removes the top route from the navigation stack
  ///
  /// Parameters:
  /// - [context]: BuildContext for navigation
  /// - [result]: Optional result to return to the previous route
  ///
  /// Example:
  /// ```dart
  /// // Simple pop
  /// AppNavigator.pop(context);
  ///
  /// // Pop with result
  /// AppNavigator.pop(context, result: selectedProduct);
  /// ```
  static void pop<T>(BuildContext context, {T? result}) {
    Navigator.of(context).pop(result);
  }

  /// Pop routes until a certain condition is met
  ///
  /// Example:
  /// ```dart
  /// // Pop until you reach the home page
  /// AppNavigator.popUntil(
  ///   context,
  ///   predicate: (route) => route.settings.name == '/home',
  /// );
  /// ```
  static void popUntil(
    BuildContext context, {
    required bool Function(Route<dynamic>) predicate,
  }) {
    Navigator.of(context).popUntil(predicate);
  }

  /// Pop routes until a named route is reached
  ///
  /// Example:
  /// ```dart
  /// AppNavigator.popUntilNamed(context, '/home');
  /// ```
  static void popUntilNamed(BuildContext context, String routeName) {
    Navigator.of(context).popUntil(
      (route) => route.settings.name == routeName,
    );
  }

  /// Check if the navigator can pop
  /// Returns true if there are routes to pop
  ///
  /// Example:
  /// ```dart
  /// if (AppNavigator.canPop(context)) {
  ///   AppNavigator.pop(context);
  /// } else {
  ///   // Show exit confirmation dialog
  /// }
  /// ```
  static bool canPop(BuildContext context) {
    return Navigator.of(context).canPop();
  }

  /// Safely pop if possible, otherwise do nothing
  ///
  /// Example:
  /// ```dart
  /// AppNavigator.maybePop(context);
  /// ```
  static Future<bool> maybePop<T>(BuildContext context, {T? result}) {
    return Navigator.of(context).maybePop(result);
  }

  // ==================== ADVANCED NAVIGATION ====================

  /// Remove a specific route from the stack
  ///
  /// Example:
  /// ```dart
  /// AppNavigator.removeRoute(context, oldRoute);
  /// ```
  static void removeRoute(BuildContext context, Route<dynamic> route) {
    Navigator.of(context).removeRoute(route);
  }

  /// Remove a route below the current one
  ///
  /// Example:
  /// ```dart
  /// AppNavigator.removeRouteBelow(context, anchorRoute);
  /// ```
  static void removeRouteBelow(
    BuildContext context,
    Route<dynamic> anchorRoute,
  ) {
    Navigator.of(context).removeRouteBelow(anchorRoute);
  }

  /// Replace a route with a new one
  ///
  /// Example:
  /// ```dart
  /// AppNavigator.replace(
  ///   context,
  ///   oldRoute: currentRoute,
  ///   newRoute: MaterialPageRoute(builder: (_) => NewPage()),
  /// );
  /// ```
  static void replace<T>(
    BuildContext context, {
    required Route<dynamic> oldRoute,
    required Route<T> newRoute,
  }) {
    Navigator.of(context).replace(oldRoute: oldRoute, newRoute: newRoute);
  }

  // ==================== UTILITY METHODS ====================

  /// Get the current route name
  /// Returns null if route has no name
  static String? getCurrentRouteName(BuildContext context) {
    return ModalRoute.of(context)?.settings.name;
  }

  /// Get the current route arguments
  /// Returns null if route has no arguments
  static Object? getCurrentRouteArguments(BuildContext context) {
    return ModalRoute.of(context)?.settings.arguments;
  }

  /// Check if a specific route is in the navigation stack
  static bool hasRoute(BuildContext context, String routeName) {
    bool found = false;
    Navigator.of(context).popUntil((route) {
      if (route.settings.name == routeName) {
        found = true;
      }
      return true;
    });
    return found;
  }

  // ==================== CUSTOM TRANSITIONS ====================

  /// Create a slide transition route from bottom to top
  static Route<T> slideFromBottom<T>(Widget page) {
    return PageRouteBuilder<T>(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.easeInOut;

        final tween = Tween(begin: begin, end: end).chain(
          CurveTween(curve: curve),
        );

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  /// Create a slide transition route from right to left
  static Route<T> slideFromRight<T>(Widget page) {
    return PageRouteBuilder<T>(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.easeInOut;

        final tween = Tween(begin: begin, end: end).chain(
          CurveTween(curve: curve),
        );

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  /// Create a fade transition route
  static Route<T> fadeTransition<T>(Widget page) {
    return PageRouteBuilder<T>(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
    );
  }

  /// Create a scale transition route
  static Route<T> scaleTransition<T>(Widget page) {
    return PageRouteBuilder<T>(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const curve = Curves.easeInOut;

        final tween = Tween(begin: 0.0, end: 1.0).chain(
          CurveTween(curve: curve),
        );

        return ScaleTransition(
          scale: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  /// Create a rotation transition route
  static Route<T> rotationTransition<T>(Widget page) {
    return PageRouteBuilder<T>(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const curve = Curves.easeInOut;

        final tween = Tween(begin: 0.0, end: 1.0).chain(
          CurveTween(curve: curve),
        );

        return RotationTransition(
          turns: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  // ==================== DIALOG & BOTTOM SHEET HELPERS ====================

  /// Show a modal bottom sheet
  ///
  /// Example:
  /// ```dart
  /// final result = await AppNavigator.showBottomSheet(
  ///   context,
  ///   child: FilterBottomSheet(),
  /// );
  /// ```
  static Future<T?> showBottomSheet<T>(
    BuildContext context, {
    required Widget child,
    bool isDismissible = true,
    bool enableDrag = true,
    Color? backgroundColor,
  }) {
    return showModalBottomSheet<T>(
      context: context,
      isDismissible: isDismissible,
      enableDrag: enableDrag,
      backgroundColor: backgroundColor,
      builder: (context) => child,
    );
  }

  /// Show a dialog
  ///
  /// Example:
  /// ```dart
  /// final confirmed = await AppNavigator.showAppDialog(
  ///   context,
  ///   child: ConfirmationDialog(message: 'Delete item?'),
  /// );
  /// ```
  static Future<T?> showAppDialog<T>(
    BuildContext context, {
    required Widget child,
    bool barrierDismissible = true,
  }) {
    return showDialog<T>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (context) => child,
    );
  }
}
