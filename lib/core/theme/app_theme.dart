import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';

class AppTheme {
  // Force Arabic font for all text by setting fontFamilyFallbacks
  static const List<String> _arabicFontFamilyFallback = ['IBMPlexSansArabic'];

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      fontFamily: 'IBMPlexSansArabic',
      fontFamilyFallback: _arabicFontFamilyFallback,

      // Color Scheme
      colorScheme: const ColorScheme.light(
        primary: AppColors.primary,
        primaryContainer: AppColors.primaryLight,
        secondary: AppColors.secondary,
        secondaryContainer: AppColors.secondaryLight,
        tertiary: AppColors.accent,
        tertiaryContainer: AppColors.accentLight,
        error: AppColors.error,
        surface: AppColors.surface,
        onPrimary: AppColors.textOnPrimary,
        onSecondary: AppColors.textOnPrimary,
        onSurface: AppColors.textPrimary,
        onError: AppColors.textOnPrimary,
      ),

      // Scaffold Background
      scaffoldBackgroundColor: AppColors.background,

      // AppBar Theme
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.surface,
        foregroundColor: AppColors.textPrimary,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimary,
          fontFamily: 'IBMPlexSansArabic',
        ),
      ),

      // Text Theme - Force Arabic font for all text
      textTheme: TextTheme(
        displayLarge: AppTextStyles.displayLarge.copyWith(
          fontFamily: 'IBMPlexSansArabic',
        ),
        displayMedium: AppTextStyles.displayMedium.copyWith(
          fontFamily: 'IBMPlexSansArabic',
        ),
        displaySmall: AppTextStyles.displaySmall.copyWith(
          fontFamily: 'IBMPlexSansArabic',
        ),
        headlineLarge: AppTextStyles.headlineLarge.copyWith(
          fontFamily: 'IBMPlexSansArabic',
        ),
        headlineMedium: AppTextStyles.headlineMedium.copyWith(
          fontFamily: 'IBMPlexSansArabic',
        ),
        headlineSmall: AppTextStyles.headlineSmall.copyWith(
          fontFamily: 'IBMPlexSansArabic',
        ),
        titleLarge: AppTextStyles.titleLarge.copyWith(
          fontFamily: 'IBMPlexSansArabic',
        ),
        titleMedium: AppTextStyles.titleMedium.copyWith(
          fontFamily: 'IBMPlexSansArabic',
        ),
        titleSmall: AppTextStyles.titleSmall.copyWith(
          fontFamily: 'IBMPlexSansArabic',
        ),
        bodyLarge: AppTextStyles.bodyLarge.copyWith(
          fontFamily: 'IBMPlexSansArabic',
        ),
        bodyMedium: AppTextStyles.bodyMedium.copyWith(
          fontFamily: 'IBMPlexSansArabic',
        ),
        bodySmall: AppTextStyles.bodySmall.copyWith(
          fontFamily: 'IBMPlexSansArabic',
        ),
        labelLarge: AppTextStyles.labelLarge.copyWith(
          fontFamily: 'IBMPlexSansArabic',
        ),
        labelMedium: AppTextStyles.labelMedium.copyWith(
          fontFamily: 'IBMPlexSansArabic',
        ),
        labelSmall: AppTextStyles.labelSmall.copyWith(
          fontFamily: 'IBMPlexSansArabic',
        ),
      ),

      // Card Theme
      // cardTheme: CardTheme(
      //   color: AppColors.cardBackground,
      //   elevation: 2,
      //   shadowColor: AppColors.shadow,
      //   shape: RoundedRectangleBorder(
      //     borderRadius: BorderRadius.circular(12),
      //   ),
      // ),

      // Button Themes
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.textOnPrimary,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          textStyle: AppTextStyles.labelLarge.copyWith(
            fontFamily: 'IBMPlexSansArabic',
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primary,
          side: const BorderSide(color: AppColors.primary, width: 1.5),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          textStyle: AppTextStyles.labelLarge.copyWith(
            fontFamily: 'IBMPlexSansArabic',
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.primary,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          textStyle: AppTextStyles.labelLarge.copyWith(
            fontFamily: 'IBMPlexSansArabic',
          ),
        ),
      ),

      // Input Decoration Theme
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.error),
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        hintStyle: AppTextStyles.bodyMedium.copyWith(
          color: AppColors.textHint,
          fontFamily: 'IBMPlexSansArabic',
        ),
        labelStyle: AppTextStyles.bodyMedium.copyWith(
          fontFamily: 'IBMPlexSansArabic',
        ),
      ),

      // Bottom Navigation Bar Theme
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.surface,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.textSecondary,
        selectedLabelStyle: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          fontFamily: 'IBMPlexSansArabic',
        ),
        unselectedLabelStyle: TextStyle(
          fontSize: 12,
          fontFamily: 'IBMPlexSansArabic',
        ),
      ),

      // Floating Action Button Theme
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppColors.secondary,
        foregroundColor: AppColors.textOnPrimary,
      ),

      // Divider Theme
      dividerTheme: const DividerThemeData(
        color: AppColors.border,
        thickness: 1,
        space: 1,
      ),

      // Chip Theme
      chipTheme: ChipThemeData(
        backgroundColor: AppColors.surface,
        selectedColor: AppColors.primary.withOpacity(0.1),
        checkmarkColor: AppColors.primary,
        deleteIconColor: AppColors.error,
        labelStyle: AppTextStyles.bodyMedium.copyWith(
          fontFamily: 'IBMPlexSansArabic',
        ),
        secondaryLabelStyle: AppTextStyles.bodyMedium.copyWith(
          fontFamily: 'IBMPlexSansArabic',
        ),
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      fontFamily: 'IBMPlexSansArabic',
      fontFamilyFallback: _arabicFontFamilyFallback,

      // Color Scheme
      colorScheme: const ColorScheme.dark(
        primary: AppColors.primaryLight,
        primaryContainer: AppColors.primary,
        secondary: AppColors.secondaryLight,
        secondaryContainer: AppColors.secondary,
        tertiary: AppColors.accentLight,
        tertiaryContainer: AppColors.accent,
        error: AppColors.error,
        surface: AppColors.primaryDark,
        onPrimary: AppColors.textOnPrimary,
        onSecondary: AppColors.textOnPrimary,
        onSurface: AppColors.textOnPrimary,
        onError: AppColors.textOnPrimary,
      ),

      // Scaffold Background
      scaffoldBackgroundColor: AppColors.primaryDark,

      // Text Theme - Force Arabic font for all text (dark mode)
      textTheme: TextTheme(
        displayLarge: AppTextStyles.displayLarge.copyWith(
          fontFamily: 'IBMPlexSansArabic',
          color: Colors.white,
        ),
        displayMedium: AppTextStyles.displayMedium.copyWith(
          fontFamily: 'IBMPlexSansArabic',
          color: Colors.white,
        ),
        displaySmall: AppTextStyles.displaySmall.copyWith(
          fontFamily: 'IBMPlexSansArabic',
          color: Colors.white,
        ),
        headlineLarge: AppTextStyles.headlineLarge.copyWith(
          fontFamily: 'IBMPlexSansArabic',
          color: Colors.white,
        ),
        headlineMedium: AppTextStyles.headlineMedium.copyWith(
          fontFamily: 'IBMPlexSansArabic',
          color: Colors.white,
        ),
        headlineSmall: AppTextStyles.headlineSmall.copyWith(
          fontFamily: 'IBMPlexSansArabic',
          color: Colors.white,
        ),
        titleLarge: AppTextStyles.titleLarge.copyWith(
          fontFamily: 'IBMPlexSansArabic',
          color: Colors.white,
        ),
        titleMedium: AppTextStyles.titleMedium.copyWith(
          fontFamily: 'IBMPlexSansArabic',
          color: Colors.white,
        ),
        titleSmall: AppTextStyles.titleSmall.copyWith(
          fontFamily: 'IBMPlexSansArabic',
          color: Colors.white,
        ),
        bodyLarge: AppTextStyles.bodyLarge.copyWith(
          fontFamily: 'IBMPlexSansArabic',
          color: Colors.white,
        ),
        bodyMedium: AppTextStyles.bodyMedium.copyWith(
          fontFamily: 'IBMPlexSansArabic',
          color: Colors.white70,
        ),
        bodySmall: AppTextStyles.bodySmall.copyWith(
          fontFamily: 'IBMPlexSansArabic',
          color: Colors.white70,
        ),
        labelLarge: AppTextStyles.labelLarge.copyWith(
          fontFamily: 'IBMPlexSansArabic',
          color: Colors.white,
        ),
        labelMedium: AppTextStyles.labelMedium.copyWith(
          fontFamily: 'IBMPlexSansArabic',
          color: Colors.white70,
        ),
        labelSmall: AppTextStyles.labelSmall.copyWith(
          fontFamily: 'IBMPlexSansArabic',
          color: Colors.white70,
        ),
      ),

      // Card Theme for Dark Mode
      // cardTheme: CardTheme(
      //   color: AppColors.primary,
      //   elevation: 2,
      //   shadowColor: AppColors.shadow,
      //   shape: RoundedRectangleBorder(
      //     borderRadius: BorderRadius.circular(12),
      //   ),
      // ),

      // Input Decoration Theme for Dark Mode
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.primary,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.primaryLight, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.error),
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        hintStyle: AppTextStyles.bodyMedium.copyWith(
          color: AppColors.textHint,
          fontFamily: 'IBMPlexSansArabic',
        ),
        labelStyle: AppTextStyles.bodyMedium.copyWith(
          fontFamily: 'IBMPlexSansArabic',
          color: Colors.white70,
        ),
      ),
    );
  }
}
