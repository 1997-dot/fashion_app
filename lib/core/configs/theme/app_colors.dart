import 'package:flutter/material.dart';

/// App color palette following the dark mode/black-centric design
/// Based on Fashion E-Commerce design requirements
class AppColors {
  // Private constructor to prevent instantiation
  AppColors._();

  // ==================== PRIMARY COLORS ====================

  /// Pure Black - Main background color
  /// Used for: App background, primary surfaces
  static const Color primary = Color(0xFF000000);

  /// Off-Black - Secondary surfaces
  /// Used for: Cards, input fields, elevated surfaces
  static const Color secondary = Color(0xFF1A1A1A);

  /// Darker off-black for depth
  static const Color surface = Color(0xFF1F1F1F);

  // ==================== TEXT COLORS ====================

  /// Pure White - Primary text color
  /// Used for: Headlines, important text, high contrast elements
  static const Color textPrimary = Color(0xFFFFFFFF);

  /// Light Grey - Secondary text color
  /// Used for: Descriptions, secondary information
  static const Color textSecondary = Color(0xFFB0B0B0);

  /// Muted Grey - Tertiary text color
  /// Used for: Hints, placeholders, disabled text
  static const Color textMuted = Color(0xFF666666);

  /// Very light grey for subtle text
  static const Color textHint = Color(0xFF999999);

  // ==================== BACKGROUND COLORS ====================

  /// Pure black background
  static const Color background = Color(0xFF000000);

  /// Card background (slightly elevated from background)
  static const Color cardBackground = Color(0xFF1F1F1F);

  /// Input field background
  static const Color inputBackground = Color(0xFF1A1A1A);

  // ==================== ACCENT COLORS ====================

  /// Subtle accent for interactive elements
  static const Color accent = Color(0xFF333333);

  /// Hover/pressed state
  static const Color accentDark = Color(0xFF2A2A2A);

  // ==================== BORDER COLORS ====================

  /// Subtle border color
  static const Color border = Color(0xFF2A2A2A);

  /// Lighter border for emphasis
  static const Color borderLight = Color(0xFF404040);

  /// Divider color
  static const Color divider = Color(0xFF1F1F1F);

  // ==================== STATUS COLORS ====================

  /// Success state (orders delivered, actions completed)
  static const Color success = Color(0xFF4CAF50);

  /// Success light variant
  static const Color successLight = Color(0xFF66BB6A);

  /// Error state (failed actions, validation errors)
  static const Color error = Color(0xFFE53935);

  /// Error light variant
  static const Color errorLight = Color(0xFFEF5350);

  /// Warning state (alerts, caution)
  static const Color warning = Color(0xFFFFA726);

  /// Warning light variant
  static const Color warningLight = Color(0xFFFFB74D);

  /// Info state (information, tips)
  static const Color info = Color(0xFF42A5F5);

  /// Info light variant
  static const Color infoLight = Color(0xFF64B5F6);

  // ==================== FUNCTIONAL COLORS ====================

  /// Disabled state for buttons and inputs
  static const Color disabled = Color(0xFF424242);

  /// Overlay/shadow color (used with opacity)
  static const Color overlay = Color(0xFF000000);

  /// Shimmer base color for loading states
  static const Color shimmerBase = Color(0xFF1A1A1A);

  /// Shimmer highlight color
  static const Color shimmerHighlight = Color(0xFF2A2A2A);

  // ==================== SEMANTIC COLORS ====================

  /// Favorite/like color (heart icon)
  static const Color favorite = Color(0xFFE91E63);

  /// Cart badge color
  static const Color cartBadge = Color(0xFFE53935);

  /// Price highlight color
  static const Color priceHighlight = Color(0xFFFFFFFF);

  /// Discount/sale color
  static const Color discount = Color(0xFFFF5252);

  // ==================== GRADIENT COLORS ====================

  /// Gradient start (for premium effects)
  static const Color gradientStart = Color(0xFF000000);

  /// Gradient middle
  static const Color gradientMiddle = Color(0xFF1A1A1A);

  /// Gradient end
  static const Color gradientEnd = Color(0xFF2A2A2A);

  // ==================== HELPER METHODS ====================

  /// Get a color with opacity
  static Color withOpacity(Color color, double opacity) {
    return color.withValues(alpha: opacity);
  }

  /// Get overlay color with standard opacity for modals/dialogs
  static Color get modalOverlay => overlay.withValues(alpha: 0.7);

  /// Get overlay color for bottom sheets
  static Color get bottomSheetOverlay => overlay.withValues(alpha: 0.5);

  /// Get shadow color with standard opacity
  static Color get shadow => overlay.withValues(alpha: 0.2);

  // ==================== COLOR SCHEMES ====================

  /// Material ColorScheme for dark theme
  static const ColorScheme darkColorScheme = ColorScheme(
    brightness: Brightness.dark,
    primary: primary,
    onPrimary: textPrimary,
    secondary: secondary,
    onSecondary: textPrimary,
    error: error,
    onError: textPrimary,
    surface: surface,
    onSurface: textPrimary,
  );
}
