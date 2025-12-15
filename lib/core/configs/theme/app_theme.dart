import 'package:flutter/material.dart';
import 'package:fashion_app/core/configs/theme/app_colors.dart';
import 'package:fashion_app/core/configs/theme/app_fonts.dart';

/// App theme configuration for Material Design
/// Implements dark mode theme following Fashion E-Commerce design requirements
class AppTheme {
  // Private constructor to prevent instantiation
  AppTheme._();

  // ==================== DARK THEME ====================

  /// Complete dark theme configuration
  static ThemeData get darkTheme => ThemeData(
        // Brightness
        brightness: Brightness.dark,

        // Color Scheme
        colorScheme: AppColors.darkColorScheme,

        // Scaffold Background
        scaffoldBackgroundColor: AppColors.background,

        // Primary Color
        primaryColor: AppColors.primary,

        // Text Theme
        textTheme: AppFonts.textTheme.apply(
          bodyColor: AppColors.textPrimary,
          displayColor: AppColors.textPrimary,
        ),

        // App Bar Theme
        appBarTheme: AppBarTheme(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.textPrimary,
          elevation: 0,
          centerTitle: true,
          titleTextStyle: AppFonts.appBarTitle.copyWith(
            color: AppColors.textPrimary,
          ),
          iconTheme: const IconThemeData(
            color: AppColors.textPrimary,
            size: 24,
          ),
        ),

        // Bottom Navigation Bar Theme
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: AppColors.primary,
          selectedItemColor: AppColors.textPrimary,
          unselectedItemColor: AppColors.textMuted,
          selectedLabelStyle: AppFonts.bottomNavLabel,
          unselectedLabelStyle: AppFonts.bottomNavLabel,
          type: BottomNavigationBarType.fixed,
          elevation: 8,
          showSelectedLabels: true,
          showUnselectedLabels: true,
        ),

        // Card Theme
        cardTheme: CardThemeData(
          color: AppColors.cardBackground,
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          margin: const EdgeInsets.all(8),
        ),

        // Elevated Button Theme
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.textPrimary,
            foregroundColor: AppColors.primary,
            textStyle: AppFonts.buttonLarge,
            elevation: 0,
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),

        // Text Button Theme
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: AppColors.textPrimary,
            textStyle: AppFonts.buttonMedium,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
        ),

        // Outlined Button Theme
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: AppColors.textPrimary,
            textStyle: AppFonts.buttonMedium,
            side: const BorderSide(color: AppColors.borderLight, width: 1.5),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),

        // Icon Button Theme
        iconButtonTheme: IconButtonThemeData(
          style: IconButton.styleFrom(
            foregroundColor: AppColors.textPrimary,
            iconSize: 24,
          ),
        ),

        // Input Decoration Theme
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: AppColors.inputBackground,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: AppColors.border, width: 1),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: AppColors.border, width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide:
                const BorderSide(color: AppColors.borderLight, width: 2),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: AppColors.error, width: 1),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: AppColors.error, width: 2),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: AppColors.disabled, width: 1),
          ),
          labelStyle: AppFonts.inputLabel.copyWith(
            color: AppColors.textSecondary,
          ),
          hintStyle: AppFonts.inputHint.copyWith(
            color: AppColors.textMuted,
          ),
          errorStyle: AppFonts.inputError.copyWith(
            color: AppColors.error,
          ),
          prefixIconColor: AppColors.textSecondary,
          suffixIconColor: AppColors.textSecondary,
        ),

        // Icon Theme
        iconTheme: const IconThemeData(
          color: AppColors.textPrimary,
          size: 24,
        ),

        // Divider Theme
        dividerTheme: const DividerThemeData(
          color: AppColors.divider,
          thickness: 1,
          space: 1,
        ),

        // Dialog Theme
        dialogTheme: DialogThemeData(
          backgroundColor: AppColors.cardBackground,
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          titleTextStyle: AppFonts.dialogTitle.copyWith(
            color: AppColors.textPrimary,
          ),
          contentTextStyle: AppFonts.dialogContent.copyWith(
            color: AppColors.textSecondary,
          ),
        ),

        // Bottom Sheet Theme
        bottomSheetTheme: const BottomSheetThemeData(
          backgroundColor: AppColors.cardBackground,
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(20),
            ),
          ),
          modalBackgroundColor: AppColors.cardBackground,
        ),

        // Snackbar Theme
        snackBarTheme: SnackBarThemeData(
          backgroundColor: AppColors.surface,
          contentTextStyle: AppFonts.body2.copyWith(
            color: AppColors.textPrimary,
          ),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),

        // Chip Theme
        chipTheme: ChipThemeData(
          backgroundColor: AppColors.surface,
          selectedColor: AppColors.textPrimary,
          disabledColor: AppColors.disabled,
          labelStyle: AppFonts.label,
          secondaryLabelStyle: AppFonts.label,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: const BorderSide(color: AppColors.border, width: 1),
          ),
        ),

        // Badge Theme
        badgeTheme: BadgeThemeData(
          backgroundColor: AppColors.cartBadge,
          textColor: AppColors.textPrimary,
          textStyle: AppFonts.tag,
          smallSize: 16,
          largeSize: 24,
        ),

        // Floating Action Button Theme
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: AppColors.textPrimary,
          foregroundColor: AppColors.primary,
          elevation: 4,
        ),

        // Progress Indicator Theme
        progressIndicatorTheme: const ProgressIndicatorThemeData(
          color: AppColors.textPrimary,
          linearTrackColor: AppColors.surface,
          circularTrackColor: AppColors.surface,
        ),

        // Slider Theme
        sliderTheme: SliderThemeData(
          activeTrackColor: AppColors.textPrimary,
          inactiveTrackColor: AppColors.surface,
          thumbColor: AppColors.textPrimary,
          overlayColor: AppColors.textPrimary.withValues(alpha: 0.2),
          valueIndicatorColor: AppColors.surface,
          valueIndicatorTextStyle: AppFonts.caption.copyWith(
            color: AppColors.textPrimary,
          ),
        ),

        // Switch Theme
        switchTheme: SwitchThemeData(
          thumbColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return AppColors.textPrimary;
            }
            return AppColors.textMuted;
          }),
          trackColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return AppColors.surface;
            }
            return AppColors.disabled;
          }),
        ),

        // Checkbox Theme
        checkboxTheme: CheckboxThemeData(
          fillColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return AppColors.textPrimary;
            }
            return AppColors.surface;
          }),
          checkColor: WidgetStateProperty.all(AppColors.primary),
          side: const BorderSide(color: AppColors.border, width: 1.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
        ),

        // Radio Theme
        radioTheme: RadioThemeData(
          fillColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return AppColors.textPrimary;
            }
            return AppColors.surface;
          }),
        ),

        // List Tile Theme
        listTileTheme: ListTileThemeData(
          tileColor: AppColors.surface,
          selectedTileColor: AppColors.surface,
          textColor: AppColors.textPrimary,
          iconColor: AppColors.textSecondary,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),

        // Tab Bar Theme
        tabBarTheme: TabBarThemeData(
          labelColor: AppColors.textPrimary,
          unselectedLabelColor: AppColors.textMuted,
          labelStyle: AppFonts.label,
          unselectedLabelStyle: AppFonts.label,
          indicator: const UnderlineTabIndicator(
            borderSide: BorderSide(color: AppColors.textPrimary, width: 2),
          ),
        ),

        // Tooltip Theme
        tooltipTheme: TooltipThemeData(
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(4),
          ),
          textStyle: AppFonts.caption.copyWith(
            color: AppColors.textPrimary,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        ),

        // Navigation Rail Theme
        navigationRailTheme: NavigationRailThemeData(
          backgroundColor: AppColors.primary,
          selectedIconTheme: const IconThemeData(
            color: AppColors.textPrimary,
            size: 24,
          ),
          unselectedIconTheme: const IconThemeData(
            color: AppColors.textMuted,
            size: 24,
          ),
          selectedLabelTextStyle: AppFonts.label.copyWith(
            color: AppColors.textPrimary,
          ),
          unselectedLabelTextStyle: AppFonts.label.copyWith(
            color: AppColors.textMuted,
          ),
        ),

        // Drawer Theme
        drawerTheme: const DrawerThemeData(
          backgroundColor: AppColors.primary,
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.horizontal(
              right: Radius.circular(0),
            ),
          ),
        ),

        // Use Material 3
        useMaterial3: true,
      );

  // ==================== HELPER METHODS ====================

  /// Get theme brightness
  static Brightness get brightness => Brightness.dark;

  /// Check if theme is dark
  static bool get isDark => true;

  /// Check if theme is light
  static bool get isLight => false;
}
