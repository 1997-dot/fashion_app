import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:fashion_app/core/configs/assets/app_images.dart';
import 'package:fashion_app/core/configs/theme/app_colors.dart';
import 'package:fashion_app/core/constants/storage_constants.dart';
import 'package:fashion_app/presentation/home/pages/home.dart';
import 'package:fashion_app/presentation/auth/pages/signin.dart';
import 'package:fashion_app/service_locator.dart';

/// Splash Screen - Initial page shown when app launches
///
/// Displays the splash.png image for 3 seconds
/// Then checks authentication status and navigates accordingly:
/// - If user is logged in → Navigate to HomePage
/// - If user is not logged in → Navigate to SignInPage
class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _initializeAndNavigate();
  }

  /// Initialize app and navigate after checking auth status
  Future<void> _initializeAndNavigate() async {
    // Wait for exactly 3 seconds (show splash screen)
    await Future.delayed(const Duration(seconds: 3));

    // Check if user is logged in
    final isLoggedIn = await _checkAuthStatus();

    // Navigate based on auth status
    if (mounted) {
      if (isLoggedIn) {
        // User is logged in → Navigate to HomePage
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const HomePage(),
          ),
        );
      } else {
        // User is not logged in → Navigate to SignInPage
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const SignInPage(),
          ),
        );
      }
    }
  }

  /// Check if user is logged in
  /// Returns true if auth token exists in SharedPreferences
  Future<bool> _checkAuthStatus() async {
    try {
      // Get SharedPreferences instance from service locator
      final prefs = sl<SharedPreferences>();

      // Check if auth token exists
      final token = prefs.getString(StorageConstants.authToken);

      // User is logged in if token is not null and not empty
      return token != null && token.isNotEmpty;
    } catch (e) {
      // If any error occurs, assume user is not logged in
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: Image.asset(
          AppImages.splash,
          fit: BoxFit.contain,
          width: double.infinity,
          height: double.infinity,
        ),
      ),
    );
  }
}
