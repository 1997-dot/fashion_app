import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:fashion_app/core/configs/theme/app_theme.dart';
import 'package:fashion_app/core/constants/app_constants.dart';
import 'package:fashion_app/service_locator.dart';
import 'package:fashion_app/presentation/splash/pages/splash.dart';

/// Main entry point of the Fashion E-Commerce application
/// Initializes core dependencies and runs the app
///
/// Setup order:
/// 1. Ensure Flutter bindings are initialized
/// 2. Configure system UI (status bar, navigation bar)
/// 3. Setup dependency injection (service locator)
/// 4. Run the app
void main() async {
  // Ensure Flutter bindings are initialized
  // Required for async operations in main() before runApp()
  WidgetsFlutterBinding.ensureInitialized();

  // Configure system UI overlay style
  // Set status bar and navigation bar colors for dark mode
  await _configureSystemUI();

  // Setup dependency injection
  // Register all core dependencies (DioClient, SharedPreferences, etc.)
  await setupServiceLocator();

  // Run the application
  runApp(const MyApp());
}

/// Configure system UI overlay style
/// Sets status bar and navigation bar appearance for dark mode
Future<void> _configureSystemUI() async {
  // Set system UI overlay style for dark mode
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      // Status bar (top)
      statusBarColor: Colors.transparent, // Transparent for edge-to-edge
      statusBarIconBrightness: Brightness.light, // Light icons for dark background
      statusBarBrightness: Brightness.dark, // Dark status bar (iOS)

      // Navigation bar (bottom - Android)
      systemNavigationBarColor: Color(0xFF000000), // Pure black
      systemNavigationBarIconBrightness: Brightness.light, // Light icons
      systemNavigationBarDividerColor: Colors.transparent,
    ),
  );

  // Set preferred orientations
  // Lock to portrait mode for better UX
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
}

/// Root widget of the Fashion E-Commerce application
/// Configures MaterialApp with theme, routes, and initial page
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // ==================== APP CONFIGURATION ====================

      /// App title (shown in task switcher)
      title: AppConstants.appName,

      /// Debug banner
      debugShowCheckedModeBanner: false,

      // ==================== THEME CONFIGURATION ====================

      /// Dark theme (primary theme)
      theme: AppTheme.darkTheme,

      /// Theme mode - always dark for this app
      themeMode: ThemeMode.dark,

      // ==================== NAVIGATION CONFIGURATION ====================

      /// Initial route - Splash screen
      /// SplashPage will check auth state and navigate accordingly:
      /// - If user is signed in → Navigate to HomePage
      /// - If user is not signed in → Navigate to SignInPage
      home: const SplashPage(),

      /// Named routes (will be configured as features are added)
      /// Example:
      /// routes: {
      ///   '/signin': (context) => const SignInPage(),
      ///   '/signup': (context) => const SignUpPage(),
      ///   '/home': (context) => const HomePage(),
      ///   '/product-detail': (context) => const ProductDetailPage(),
      ///   '/cart': (context) => const CartPage(),
      ///   '/checkout': (context) => const CheckoutPage(),
      ///   '/profile': (context) => const ProfilePage(),
      ///   '/favorites': (context) => const FavoritesPage(),
      ///   '/orders': (context) => const OrdersPage(),
      ///   '/search': (context) => const SearchPage(),
      /// },

      // ==================== BUILDER & WRAPPER ====================

      /// Builder wrapper for global configurations
      /// Can be used for:
      /// - Global BLoC providers
      /// - Navigation observer
      /// - Error handling
      /// - Responsive wrappers
      builder: (context, child) {
        // Add global error handling
        ErrorWidget.builder = (FlutterErrorDetails errorDetails) {
          return _buildErrorWidget(errorDetails);
        };

        return child ?? const SizedBox.shrink();
      },

      // ==================== LOCALIZATION ====================

      /// Locale configuration (currently English only)
      /// Can be expanded for multi-language support
      // locale: const Locale('en', 'US'),
      // localizationsDelegates: const [
      //   AppLocalizations.delegate,
      //   GlobalMaterialLocalizations.delegate,
      //   GlobalWidgetsLocalizations.delegate,
      //   GlobalCupertinoLocalizations.delegate,
      // ],
      // supportedLocales: const [
      //   Locale('en', 'US'), // English
      //   Locale('ar', 'SA'), // Arabic (for future)
      // ],
    );
  }

  /// Build error widget for production
  /// Shows user-friendly error message instead of red error screen
  Widget _buildErrorWidget(FlutterErrorDetails errorDetails) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      home: Scaffold(
        backgroundColor: const Color(0xFF000000),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Error icon
                const Icon(
                  Icons.error_outline,
                  color: Color(0xFFFF4444),
                  size: 80,
                ),
                const SizedBox(height: 24),

                // Error title
                const Text(
                  'Oops! Something went wrong',
                  style: TextStyle(
                    color: Color(0xFFFFFFFF),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),

                // Error message
                const Text(
                  'We encountered an unexpected error.\nPlease restart the app.',
                  style: TextStyle(
                    color: Color(0xFFB3B3B3),
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),

                // Debug info (only show in debug mode)
                if (kDebugMode) ...[
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1A1A1A),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      errorDetails.toString(),
                      style: const TextStyle(
                        color: Color(0xFFFF4444),
                        fontSize: 12,
                        fontFamily: 'monospace',
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Debug mode flag
/// Used to show/hide debug information
const bool kDebugMode = bool.fromEnvironment('dart.vm.product') == false;
