import 'package:flutter/material.dart';

class AppTextStyles {
  // Default Arabic font family for all text styles
  static const String _arabicFontFamily = 'IBMPlexSansArabic';

  // Display Styles
  static const TextStyle displayLarge = TextStyle(
    fontSize: 57,
    fontWeight: FontWeight.w400,
    height: 1.12,
    letterSpacing: -0.25,
    fontFamily: _arabicFontFamily,
  );

  static const TextStyle displayMedium = TextStyle(
    fontSize: 45,
    fontWeight: FontWeight.w400,
    height: 1.16,
    letterSpacing: 0,
    fontFamily: _arabicFontFamily,
  );

  static const TextStyle displaySmall = TextStyle(
    fontSize: 36,
    fontWeight: FontWeight.w400,
    height: 1.22,
    letterSpacing: 0,
    fontFamily: _arabicFontFamily,
  );

  // Headline Styles
  static const TextStyle headlineLarge = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.w400,
    height: 1.25,
    letterSpacing: 0,
    fontFamily: _arabicFontFamily,
  );

  static const TextStyle headlineMedium = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w400,
    height: 1.29,
    letterSpacing: 0,
    fontFamily: _arabicFontFamily,
  );

  static const TextStyle headlineSmall = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w400,
    height: 1.33,
    letterSpacing: 0,
    fontFamily: _arabicFontFamily,
  );

  // Title Styles
  static const TextStyle titleLarge = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w500,
    height: 1.27,
    letterSpacing: 0,
    fontFamily: _arabicFontFamily,
  );

  static const TextStyle titleMedium = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    height: 1.5,
    letterSpacing: 0.15,
    fontFamily: _arabicFontFamily,
  );

  static const TextStyle titleSmall = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    height: 1.43,
    letterSpacing: 0.1,
    fontFamily: _arabicFontFamily,
  );

  // Body Styles
  static const TextStyle bodyLarge = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 1.5,
    letterSpacing: 0.15,
    fontFamily: _arabicFontFamily,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 1.43,
    letterSpacing: 0.25,
    fontFamily: _arabicFontFamily,
  );

  static const TextStyle bodySmall = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    height: 1.33,
    letterSpacing: 0.4,
    fontFamily: _arabicFontFamily,
  );

  // Label Styles
  static const TextStyle labelLarge = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    height: 1.43,
    letterSpacing: 0.1,
    fontFamily: _arabicFontFamily,
  );

  static const TextStyle labelMedium = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    height: 1.33,
    letterSpacing: 0.5,
    fontFamily: _arabicFontFamily,
  );

  static const TextStyle labelSmall = TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.w500,
    height: 1.45,
    letterSpacing: 0.5,
    fontFamily: _arabicFontFamily,
  );

  // Arabic-Specific Styles (RTL Support)
  static const TextStyle arabicDisplayLarge = TextStyle(
    fontSize: 57,
    fontWeight: FontWeight.w400,
    height: 1.12,
    letterSpacing: -0.25,
    fontFamily: _arabicFontFamily,
  );

  static const TextStyle arabicHeadlineLarge = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.w400,
    height: 1.25,
    letterSpacing: 0,
    fontFamily: _arabicFontFamily,
  );

  static const TextStyle arabicTitleLarge = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w500,
    height: 1.27,
    letterSpacing: 0,
    fontFamily: _arabicFontFamily,
  );

  static const TextStyle arabicBodyLarge = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 1.5,
    letterSpacing: 0.15,
    fontFamily: _arabicFontFamily,
  );

  static const TextStyle arabicBodyMedium = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 1.43,
    letterSpacing: 0.25,
    fontFamily: _arabicFontFamily,
  );

  static const TextStyle arabicLabelLarge = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    height: 1.43,
    letterSpacing: 0.1,
    fontFamily: _arabicFontFamily,
  );

  // iOS-Inspired Home Screen Styles (Pixel-Perfect)
  // Using iOS point system (1pt = 1dp on standard displays)
  static const TextStyle homeWelcomeTitle = TextStyle(
    fontSize: 26, // 26pt (similar to iOS large title)
    fontWeight: FontWeight.w700,
    height: 1.2,
    fontFamily: _arabicFontFamily,
    color: Color(0xFF1C1C1E), // iOS label color
    letterSpacing: 0.37,
  );

  static const TextStyle homeWelcomeSubtitle = TextStyle(
    fontSize: 17, // 17pt (iOS body)
    fontWeight: FontWeight.w400,
    height: 1.4,
    fontFamily: _arabicFontFamily,
    color: Color(0xFF8E8E93), // iOS secondary label
    letterSpacing: -0.41,
  );

  static const TextStyle homeSectionTitle = TextStyle(
    fontSize: 22, // 22pt (iOS headline)
    fontWeight: FontWeight.w600,
    height: 1.3,
    fontFamily: _arabicFontFamily,
    color: Color(0xFF1C1C1E), // iOS label color
    letterSpacing: 0.35,
  );

  static const TextStyle homeSectionSubtitle = TextStyle(
    fontSize: 17, // 17pt (iOS subheadline)
    fontWeight: FontWeight.w500,
    height: 1.4,
    fontFamily: _arabicFontFamily,
    color: Color(0xFF8E8E93), // iOS secondary label
    letterSpacing: -0.41,
  );

  static const TextStyle homeBodyText = TextStyle(
    fontSize: 17, // 17pt (iOS body)
    fontWeight: FontWeight.w400,
    height: 1.4,
    fontFamily: _arabicFontFamily,
    color: Color(0xFF1C1C1E), // iOS label color
    letterSpacing: -0.43,
  );

  static const TextStyle homeHintText = TextStyle(
    fontSize: 17, // 17pt (iOS body)
    fontWeight: FontWeight.w400,
    height: 1.4,
    fontFamily: _arabicFontFamily,
    color: Color(0xFFC7C7CC), // iOS tertiary label
    letterSpacing: -0.41,
  );

  static const TextStyle homeButtonText = TextStyle(
    fontSize: 17, // 17pt (iOS button)
    fontWeight: FontWeight.w600,
    height: 1.3,
    fontFamily: _arabicFontFamily,
    color: Color(0xFFFFFFFF), // White on iOS buttons
    letterSpacing: -0.41,
  );

  static const TextStyle homeDoctorName = TextStyle(
    fontSize: 17, // 17pt (iOS body bold)
    fontWeight: FontWeight.w600,
    height: 1.3,
    fontFamily: _arabicFontFamily,
    color: Color(0xFF1C1C1E), // iOS label color
    letterSpacing: -0.41,
  );

  static const TextStyle homeDoctorSpecialty = TextStyle(
    fontSize: 15, // 15pt (iOS caption)
    fontWeight: FontWeight.w400,
    height: 1.33,
    fontFamily: _arabicFontFamily,
    color: Color(0xFF8E8E93), // iOS secondary label
    letterSpacing: -0.24,
  );

  static const TextStyle homeDoctorRating = TextStyle(
    fontSize: 15, // 15pt (iOS caption medium)
    fontWeight: FontWeight.w600,
    height: 1.33,
    fontFamily: _arabicFontFamily,
    color: Color(0xFF1C1C1E), // iOS label color
    letterSpacing: -0.24,
  );

  static const TextStyle homeCategoryLabel = TextStyle(
    fontSize: 13, // 13pt (iOS small body)
    fontWeight: FontWeight.w500,
    height: 1.38,
    fontFamily: _arabicFontFamily,
    color: Color(0xFF1C1C1E), // iOS label color
    letterSpacing: -0.08,
  );

  static const TextStyle homeCategoryCount = TextStyle(
    fontSize: 11, // 11pt (iOS footnote)
    fontWeight: FontWeight.w400,
    height: 1.27,
    fontFamily: _arabicFontFamily,
    color: Color(0xFF8E8E93), // iOS secondary label
    letterSpacing: 0.07,
  );

  // iOS Style Search Text
  static const TextStyle homeSearchHint = TextStyle(
    fontSize: 17, // 17pt (iOS search field)
    fontWeight: FontWeight.w400,
    height: 1.4,
    fontFamily: _arabicFontFamily,
    color: Color(0xFFC7C7CC), // iOS tertiary label
    letterSpacing: -0.41,
  );

  // iOS Style Quick Action Label
  static const TextStyle homeQuickActionLabel = TextStyle(
    fontSize: 13, // 13pt (iOS small body)
    fontWeight: FontWeight.w500,
    height: 1.38,
    fontFamily: _arabicFontFamily,
    color: Color(0xFF1C1C1E), // iOS label color
    letterSpacing: -0.08,
  );

  // iOS Style Price Text
  static const TextStyle homePrice = TextStyle(
    fontSize: 22, // 22pt (iOS price large)
    fontWeight: FontWeight.w600,
    height: 1.3,
    fontFamily: _arabicFontFamily,
    color: Color(0xFF1C1C1E), // iOS label color
    letterSpacing: 0.35,
  );
}
