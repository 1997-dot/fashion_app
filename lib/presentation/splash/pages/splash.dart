import 'package:flutter/material.dart';
import 'package:fashion_app/core/configs/theme/app_colors.dart';
import 'package:fashion_app/core/constants/app_constants.dart';

/// Splash Screen - Initial page shown when app launches
///
/// Responsibilities:
/// 1. Display app branding (logo, tagline)
/// 2. Check authentication status
/// 3. Navigate to appropriate page:
///    - If authenticated → HomePage
///    - If not authenticated → SignInPage
///
/// This is a placeholder implementation for Phase 1
/// Full implementation with BLoC will be done in Phase 3
class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  /// Initialize app and check authentication
  /// Placeholder for now - will use SplashBloc in Phase 3
  Future<void> _initializeApp() async {
    // TODO: Phase 3 - Add SplashBloc to check auth state
    // final isSignedIn = await sl<IsSignedInUseCase>()(NoParams());
    // isSignedIn.fold(
    //   (failure) => Navigator.pushReplacement(context, SignInPage()),
    //   (signedIn) {
    //     if (signedIn) {
    //       Navigator.pushReplacement(context, HomePage());
    //     } else {
    //       Navigator.pushReplacement(context, SignInPage());
    //     }
    //   },
    // );

    // For now, just show splash for 2 seconds
    await Future.delayed(
      Duration(seconds: AppConstants.splashDurationSeconds),
    );

    // TODO: Navigate to SignInPage when implemented
    // For now, stay on splash screen
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Spacer to push content down
              const Spacer(flex: 2),

              // Large "F." Logo
              Text(
                'F.',
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 120,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 4,
                ),
              ),

              const SizedBox(height: 16),

              // "FASHION." Text
              Text(
                'FASHION.',
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 8,
                ),
              ),

              const SizedBox(height: 8),

              // "E-COMMERCE" Subtitle
              Text(
                'E-COMMERCE',
                style: TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 4,
                ),
              ),

              const SizedBox(height: 40),

              // Tagline
              Text(
                AppConstants.appTagline,
                style: TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  letterSpacing: 2,
                ),
              ),

              // Spacer to push content up
              const Spacer(flex: 3),

              // Loading indicator
              SizedBox(
                width: 32,
                height: 32,
                child: CircularProgressIndicator(
                  strokeWidth: 3,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    AppColors.textPrimary,
                  ),
                ),
              ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
