import 'package:flutter/material.dart';

class AppColors {
  // Primary Colors
  static const Color primary = Color(0xFF172F41);
  static const Color primaryLight = Color(0xFF2A4A5E);
  static const Color primaryDark = Color(0xFF0D1F2D);

  // Secondary Colors
  static const Color secondary = Color(0xFF4A90E2);
  static const Color secondaryLight = Color(0xFF6BA3E5);
  static const Color secondaryDark = Color(0xFF357ABD);

  // Accent Colors
  static const Color accent = Color(0xFF50E3C2);
  static const Color accentLight = Color(0xFF7FE8D4);
  static const Color accentDark = Color(0xFF3BC9A8);

  // Status Colors
  static const Color success = Color(0xFF4CAF50);
  static const Color warning = Color(0xFFFF9800);
  static const Color error = Color(0xFFF44336);
  static const Color info = Color(0xFF2196F3);

  // Neutral Colors
  static const Color background = Color(0xFFF5F5F5);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color cardBackground = Color(0xFFFFFFFF);

  // Text Colors
  static const Color textPrimary = Color(0xFF212121);
  static const Color textSecondary = Color(0xFF757575);
  static const Color textHint = Color(0xFFBDBDBD);
  static const Color textOnPrimary = Color(0xFFFFFFFF);

  // Border Colors
  static const Color border = Color(0xFFE0E0E0);
  static const Color borderLight = Color(0xFFF0F0F0);

  // Shadow Colors
  static const Color shadow = Color(0x1F000000);

  // Medical Theme Colors
  static const Color healthGreen = Color(0xFF4CAF50);
  static const Color healthBlue = Color(0xFF2196F3);
  static const Color healthPurple = Color(0xFF9C27B0);
  static const Color healthOrange = Color(0xFFFF9800);

  // Quick Actions Colors (Legacy - keeping for compatibility)
  static const Color quickActionBlue = Color(0xFF2196F3);
  static const Color quickActionGreenLegacy =
      Color(0xFF4CAF50); // Renamed to avoid conflict
  static const Color quickActionPurple = Color(0xFF9C27B0);
  static const Color quickActionOrange = Color(0xFFFF9800);

  // Onboarding Colors (from Figma)
  static const Color onboardingBackground = Color(0xFFF8F8F8);
  static const Color onboardingButtonPrimary = Color(0xFF0061DF);
  static const Color onboardingButtonSecondary = Color(0xFF172F41);
  static const Color onboardingTextSecondary = Color(0xFFAAAAAA);

  // Authentication Colors (from Figma)
  static const Color authBackground =
      Color(0xFF172F41); // Welcome screen background
  static const Color authButtonTransparent =
      Color(0x26FFFFFF); // Semi-transparent white for social buttons
  static const Color authButtonSolid =
      Color(0xFFFFFFFF); // Solid white for email button
  static const Color authTextPrimary = Color(0xFFFFFFFF); // White text
  static const Color authTextSecondary =
      Color(0xFF0061DF); // Blue text for email button

  // iOS-Inspired Medical Theme (Cupertino Design System)
  static const Color medicalPrimary = Color(0xFF0A84FF); // iOS blue
  static const Color medicalSecondary = Color(0xFF30D158); // iOS green
  static const Color medicalAccent = Color(0xFFFF9F0A); // iOS orange
  static const Color medicalPurple = Color(0xFFBF5AF2); // iOS purple
  static const Color medicalPink = Color(0xFFFF2D55); // iOS red/pink
  static const Color medicalTeal = Color(0xFF5AC8FA); // iOS light blue

  // Status Colors (Medical Context)
  static const Color onlineStatus = Color(0xFF34C759); // Available doctor
  static const Color busyStatus = Color(0xFFFF9500); // Busy/away
  static const Color offlineStatus = Color(0xFF8E8E93); // Offline
  static const colorAvailableStatus = Color(0xFF30D158); // Available today
  static const Color emergencyStatus = Color(0xFFFF3B30); // Emergency

  // Home Screen Colors (Pixel-Perfect iOS Style)
  static const Color homeBackground =
      Color(0xFFF2F2F7); // iOS system background
  static const Color homePrimaryText = Color(0xFF1C1C1E); // iOS label (dark)
  static const Color homeSecondaryText =
      Color(0xFF8E8E93); // iOS secondary label
  static const Color homeTertiaryText = Color(0xFFC7C7CC); // iOS tertiary label
  static const Color homeAccentBlue = Color(0xFF0A84FF); // iOS system blue
  static const Color homeCardBackground =
      Color(0xFFFFFFFF); // iOS system background
  static const Color homeDivider = Color(0xFFD1D1D6); // iOS separator
  static const Color homeNavigationBarBackground = Color(0xFFF2F2F7);

  // Interactive States
  static const Color homeButtonBackground =
      Color(0xFF0A84FF); // iOS button blue
  static const Color homeButtonDisabled = Color(0xFFD1D1D6); // iOS disabled
  static const Color homeOverlay = Color(0x40000000); // iOS overlay

  // Enhanced Quick Action Colors (iOS Palette)
  static const Color quickActionYellow = Color(0xFFFF9F0A); // iOS yellow
  static const Color quickActionPink = Color(0xFFFF2D55); // iOS red
  static const Color quickActionTeal = Color(0xFF5AC8FA); // iOS blue
  static const Color quickActionGreen = Color(0xFF30D158); // iOS green

  // Shadow System (Pixel-Perfect)
  static const List<BoxShadow> cardShadow = [
    BoxShadow(
      color: Color(0x0A000000),
      offset: Offset(0, 2),
      blurRadius: 8,
    ),
    BoxShadow(
      color: Color(0x05000000),
      offset: Offset(0, 4),
      blurRadius: 12,
    ),
  ];

  static const List<BoxShadow> buttonShadow = [
    BoxShadow(
      color: Color(0x19000000),
      offset: Offset(0, 4),
      blurRadius: 12,
    ),
  ];

  static const List<BoxShadow> heavyShadow = [
    BoxShadow(
      color: Color(0x1A000000),
      offset: Offset(0, 10),
      blurRadius: 25,
    ),
  ];

  // Figma Design Colors (Medical Health App)
  static const Color figmaPrimary = Color(0xFF172F41); // Deep medical blue
  static const Color figmaSecondary = Color(0xFF4A90E2); // Medical accent blue
  static const Color figmaAccent = Color(0xFF50E3C2); // Fresh medical green
  static const Color figmaBackground = Color(0xFFF8F9FA); // Clean medical white
  static const Color figmaSurface = Color(0xFFFFFFFF); // Pure medical white
  static const Color figmaCardBackground = Color(0xFFFFFFFF);
  static const Color figmaDivider = Color(0xFFE8EAED); // Subtle divider

  // Medical Category Colors (Figma-inspired)
  static const Color neurologyColor = Color(0xFF9C27B0); // Purple for brain
  static const Color cardiologyColor = Color(0xFFF44336); // Red for heart
  static const Color dentistryColor = Color(0xFF2196F3); // Blue for teeth
  static const Color orthopedicsColor = Color(0xFFFF9800); // Orange for bones
  static const Color pediatricsColor = Color(0xFF4CAF50); // Green for children
  static const Color gynecologyColor =
      Color(0xFFE91E63); // Pink for women's health
  static const Color dermatologyColor = Color(0xFFFDD835); // Yellow for skin

  // Enhanced Status Colors (Medical Context)
  static const Color doctorOnlineStatus = Color(0xFF34C759); // Available doctor
  static const Color doctorBusyStatus = Color(0xFFFF9500); // Busy/away
  static const Color doctorOfflineStatus = Color(0xFF8E8E93); // Offline
  static const Color todayAvailableStatus =
      Color(0xFF30D158); // Available today
  static const Color emergencyAlertStatus = Color(0xFFFF3B30); // Emergency
  static const Color appointmentBookedStatus = Color(0xFF007AFF); // Scheduled

  // Quick Action Colors (Figma Enhanced)
  static const Color quickActionVideo = Color(0xFF007AFF); // Video call blue
  static const Color quickAppointment = Color(0xFF34C759); // Appointment green
  static const Color quickChat = Color(0xFF5856D6); // Chat purple
  static const Color quickEmergency = Color(0xFFFF3B30); // Emergency red
  static const Color quickRecords = Color(0xFFFF9500); // Records orange

  // Doctor Status Indicators
  static const Color doctorIndicatorAvailable = Color(0xFF34C759);
  static const Color doctorIndicatorBusy = Color(0xFFFF9500);
  static const Color doctorIndicatorOffline = Color(0xFF8E8E93);

  // Rating Colors
  static const Color ratingStar = Color(0xFFFF9500); // Gold star
  static const Color ratingEmpty = Color(0xFFE5E5EA); // Empty star

  // Search and Filter Colors
  static const Color searchBackground = Color(0xFFF2F2F7);
  static const Color searchIcon = Color(0xFF8E8E93);

  // Gradient Colors (Enhanced)
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primary, primaryLight],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient accentGradient = LinearGradient(
    colors: [accent, accentLight],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Medical Gradient
  static const LinearGradient medicalGradient = LinearGradient(
    colors: [figmaPrimary, figmaSecondary],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
