import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// App typography configuration using Google Fonts
/// Based on Fashion E-Commerce design requirements
class AppFonts {
  // Private constructor to prevent instantiation
  AppFonts._();

  /// Primary font family - Montserrat (modern, clean, fashion-forward)
  static const String primaryFontFamily = 'Montserrat';

  /// Secondary font family - Roboto (fallback)
  static const String secondaryFontFamily = 'Roboto';

  // ==================== FONT WEIGHTS ====================

  static const FontWeight light = FontWeight.w300;
  static const FontWeight regular = FontWeight.w400;
  static const FontWeight medium = FontWeight.w500;
  static const FontWeight semiBold = FontWeight.w600;
  static const FontWeight bold = FontWeight.w700;
  static const FontWeight extraBold = FontWeight.w800;

  // ==================== HEADING STYLES ====================

  /// Heading 1 - Large titles (e.g., "FASHION.", splash screen)
  static TextStyle get heading1 => GoogleFonts.montserrat(
        fontSize: 48,
        fontWeight: bold,
        letterSpacing: 1.5,
        height: 1.2,
      );

  /// Heading 2 - Page titles (e.g., "CHECKOUT", "CREATE ACCOUNT")
  static TextStyle get heading2 => GoogleFonts.montserrat(
        fontSize: 32,
        fontWeight: bold,
        letterSpacing: 1.2,
        height: 1.3,
      );

  /// Heading 3 - Section headers
  static TextStyle get heading3 => GoogleFonts.montserrat(
        fontSize: 24,
        fontWeight: semiBold,
        letterSpacing: 0.5,
        height: 1.4,
      );

  /// Heading 4 - Card titles, product names
  static TextStyle get heading4 => GoogleFonts.montserrat(
        fontSize: 20,
        fontWeight: semiBold,
        letterSpacing: 0.25,
        height: 1.4,
      );

  /// Heading 5 - Subsection headers
  static TextStyle get heading5 => GoogleFonts.montserrat(
        fontSize: 18,
        fontWeight: medium,
        letterSpacing: 0.15,
        height: 1.4,
      );

  /// Heading 6 - Small headers
  static TextStyle get heading6 => GoogleFonts.montserrat(
        fontSize: 16,
        fontWeight: medium,
        letterSpacing: 0.15,
        height: 1.4,
      );

  // ==================== BODY TEXT STYLES ====================

  /// Body 1 - Primary body text (descriptions, content)
  static TextStyle get body1 => GoogleFonts.montserrat(
        fontSize: 16,
        fontWeight: regular,
        letterSpacing: 0.5,
        height: 1.5,
      );

  /// Body 2 - Secondary body text (smaller content)
  static TextStyle get body2 => GoogleFonts.montserrat(
        fontSize: 14,
        fontWeight: regular,
        letterSpacing: 0.25,
        height: 1.5,
      );

  /// Body 3 - Tertiary body text (even smaller content)
  static TextStyle get body3 => GoogleFonts.montserrat(
        fontSize: 12,
        fontWeight: regular,
        letterSpacing: 0.25,
        height: 1.5,
      );

  // ==================== CAPTION & LABEL STYLES ====================

  /// Caption - Small text (hints, metadata, timestamps)
  static TextStyle get caption => GoogleFonts.montserrat(
        fontSize: 12,
        fontWeight: regular,
        letterSpacing: 0.4,
        height: 1.4,
      );

  /// Overline - Uppercase small text (categories, labels)
  static TextStyle get overline => GoogleFonts.montserrat(
        fontSize: 10,
        fontWeight: medium,
        letterSpacing: 1.5,
        height: 1.6,
      );

  /// Label - Form labels, button text
  static TextStyle get label => GoogleFonts.montserrat(
        fontSize: 14,
        fontWeight: medium,
        letterSpacing: 0.5,
        height: 1.4,
      );

  // ==================== BUTTON TEXT STYLES ====================

  /// Button Large - Primary action buttons
  static TextStyle get buttonLarge => GoogleFonts.montserrat(
        fontSize: 16,
        fontWeight: semiBold,
        letterSpacing: 1.25,
        height: 1.2,
      );

  /// Button Medium - Secondary action buttons
  static TextStyle get buttonMedium => GoogleFonts.montserrat(
        fontSize: 14,
        fontWeight: semiBold,
        letterSpacing: 1.0,
        height: 1.2,
      );

  /// Button Small - Tertiary action buttons
  static TextStyle get buttonSmall => GoogleFonts.montserrat(
        fontSize: 12,
        fontWeight: medium,
        letterSpacing: 0.75,
        height: 1.2,
      );

  // ==================== INPUT FIELD STYLES ====================

  /// Input Text - Text field input
  static TextStyle get inputText => GoogleFonts.montserrat(
        fontSize: 16,
        fontWeight: regular,
        letterSpacing: 0.5,
        height: 1.4,
      );

  /// Input Label - Text field label
  static TextStyle get inputLabel => GoogleFonts.montserrat(
        fontSize: 14,
        fontWeight: medium,
        letterSpacing: 0.4,
        height: 1.4,
      );

  /// Input Hint - Text field placeholder
  static TextStyle get inputHint => GoogleFonts.montserrat(
        fontSize: 16,
        fontWeight: regular,
        letterSpacing: 0.5,
        height: 1.4,
      );

  /// Input Error - Error message below field
  static TextStyle get inputError => GoogleFonts.montserrat(
        fontSize: 12,
        fontWeight: regular,
        letterSpacing: 0.4,
        height: 1.4,
      );

  // ==================== SPECIAL TEXT STYLES ====================

  /// Price - Product prices
  static TextStyle get price => GoogleFonts.montserrat(
        fontSize: 20,
        fontWeight: bold,
        letterSpacing: 0.5,
        height: 1.2,
      );

  /// Price Large - Emphasized prices (checkout total)
  static TextStyle get priceLarge => GoogleFonts.montserrat(
        fontSize: 28,
        fontWeight: bold,
        letterSpacing: 0.5,
        height: 1.2,
      );

  /// Price Small - Secondary prices (original price, discounts)
  static TextStyle get priceSmall => GoogleFonts.montserrat(
        fontSize: 16,
        fontWeight: semiBold,
        letterSpacing: 0.25,
        height: 1.2,
      );

  /// Tag - Badges, chips (NEW, SALE, etc.)
  static TextStyle get tag => GoogleFonts.montserrat(
        fontSize: 10,
        fontWeight: bold,
        letterSpacing: 1.0,
        height: 1.2,
      );

  /// App Bar Title - Title in app bar
  static TextStyle get appBarTitle => GoogleFonts.montserrat(
        fontSize: 20,
        fontWeight: semiBold,
        letterSpacing: 0.15,
        height: 1.2,
      );

  /// Bottom Nav Label - Bottom navigation bar labels
  static TextStyle get bottomNavLabel => GoogleFonts.montserrat(
        fontSize: 12,
        fontWeight: medium,
        letterSpacing: 0.5,
        height: 1.2,
      );

  /// Dialog Title - Alert/dialog titles
  static TextStyle get dialogTitle => GoogleFonts.montserrat(
        fontSize: 20,
        fontWeight: semiBold,
        letterSpacing: 0.15,
        height: 1.4,
      );

  /// Dialog Content - Alert/dialog body text
  static TextStyle get dialogContent => GoogleFonts.montserrat(
        fontSize: 16,
        fontWeight: regular,
        letterSpacing: 0.5,
        height: 1.5,
      );

  // ==================== TEXT THEME ====================

  /// Complete Material TextTheme for the app
  static TextTheme get textTheme => TextTheme(
        // Display styles (largest)
        displayLarge: heading1,
        displayMedium: heading2,
        displaySmall: heading3,

        // Headline styles
        headlineLarge: heading3,
        headlineMedium: heading4,
        headlineSmall: heading5,

        // Title styles
        titleLarge: heading4,
        titleMedium: heading5,
        titleSmall: heading6,

        // Body styles
        bodyLarge: body1,
        bodyMedium: body2,
        bodySmall: body3,

        // Label styles
        labelLarge: buttonLarge,
        labelMedium: buttonMedium,
        labelSmall: buttonSmall,
      );

  // ==================== HELPER METHODS ====================

  /// Apply color to a text style
  static TextStyle withColor(TextStyle style, Color color) {
    return style.copyWith(color: color);
  }

  /// Apply font weight to a text style
  static TextStyle withWeight(TextStyle style, FontWeight weight) {
    return style.copyWith(fontWeight: weight);
  }

  /// Apply font size to a text style
  static TextStyle withSize(TextStyle style, double size) {
    return style.copyWith(fontSize: size);
  }

  /// Apply letter spacing to a text style
  static TextStyle withLetterSpacing(TextStyle style, double spacing) {
    return style.copyWith(letterSpacing: spacing);
  }

  /// Apply line height to a text style
  static TextStyle withHeight(TextStyle style, double height) {
    return style.copyWith(height: height);
  }

  /// Apply decoration to a text style
  static TextStyle withDecoration(
    TextStyle style,
    TextDecoration decoration,
  ) {
    return style.copyWith(decoration: decoration);
  }
}
