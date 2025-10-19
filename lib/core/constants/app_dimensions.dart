/// App dimension constants for consistent spacing, sizing, and layout
/// Based on iOS 8pt grid system and Cupertino design principles
class AppDimensions {
  // iOS 8pt Grid System (1pt = 1dp on standard displays)
  static const double gridSize = 8.0;

  // Spacing scale based on iOS grid
  static const double spacing2xs = 4.0; // 0.5 * gridSize
  static const double spacingXs = 8.0; // 1 * gridSize
  static const double spacingSm = 12.0; // 1.5 * gridSize
  static const double spacingMd = 16.0; // 2 * gridSize
  static const double spacingLg = 20.0; // 2.5 * gridSize
  static const double spacingXl = 24.0; // 3 * gridSize
  static const double spacing2xl = 32.0; // 4 * gridSize
  static const double spacing3xl = 40.0; // 5 * gridSize
  static const double spacing4xl = 48.0; // 6 * gridSize

  // Border Radius (Cupertino style)
  static const double radiusXs = 4.0; // Small radius
  static const double radiusSm = 6.0; // Small-medium
  static const double radiusMd = 8.0; // Standard radius
  static const double radiusLg = 10.0; // Large radius (buttons)
  static const double radiusXl = 12.0; // Extra large radius
  static const double radius2xl = 16.0; // Cards and containers
  static const double radius3xl = 20.0; // Large containers
  static const double radius4xl = 24.0; // Special elements
  static const double radiusCircular = 100.0; // Perfect circle

  // Legacy Padding (use spacing scale instead)
  @Deprecated('Use spacing scale instead - e.g., AppDimensions.spacingMd')
  static const double paddingSmall = 8.0;
  @Deprecated('Use spacing scale instead - e.g., AppDimensions.spacingMd')
  static const double paddingMedium = 16.0;
  @Deprecated('Use spacing scale instead - e.g., AppDimensions.spacingXl')
  static const double paddingLarge = 24.0;
  @Deprecated('Use spacing scale instead - e.g., AppDimensions.spacing2xl')
  static const double paddingExtraLarge = 32.0;
  @Deprecated('Use spacing scale instead - e.g., AppDimensions.spacing4xl')
  static const double paddingXXLarge = 48.0;

  // Legacy Margin (use spacing scale instead)
  @Deprecated('Use spacing scale instead - e.g., AppDimensions.spacingMd')
  static const double marginSmall = 8.0;
  @Deprecated('Use spacing scale instead - e.g., AppDimensions.spacingMd')
  static const double marginMedium = 16.0;
  @Deprecated('Use spacing scale instead - e.g., AppDimensions.spacingXl')
  static const double marginLarge = 24.0;
  @Deprecated('Use spacing scale instead - e.g., AppDimensions.spacing2xl')
  static const double marginExtraLarge = 32.0;
  @Deprecated('Use spacing scale instead - e.g., AppDimensions.spacing4xl')
  static const double marginXXLarge = 48.0;

  // Icon Sizes (iOS standard)
  static const double iconXs = 16.0; // Small system icon
  static const double iconSm = 20.0; // Medium system icon
  static const double iconMd = 24.0; // Large system icon
  static const double iconLg = 32.0; // Extra large system icon
  static const double iconXl = 48.0; // XXL system icon

  // Legacy Icon Sizes (keep for backward compatibility)
  @Deprecated('Use icon scale instead - e.g., AppDimensions.iconSm')
  static const double iconSizeSmall = 16.0;
  @Deprecated('Use icon scale instead - e.g., AppDimensions.iconSm')
  static const double iconSizeMedium = 20.0;
  @Deprecated('Use icon scale instead - e.g., AppDimensions.iconMd')
  static const double iconSizeLarge = 24.0;
  @Deprecated('Use icon scale instead - e.g., AppDimensions.iconLg')
  static const double iconSizeExtraLarge = 32.0;
  @Deprecated('Use icon scale instead - e.g., AppDimensions.iconXl')
  static const double iconSizeXXLarge = 48.0;

  // iOS Button Heights (Cupertino standard)
  static const double buttonSm = 32.0; // Small button height
  static const double buttonMd =
      44.0; // Standard iOS button height (minimum touch target)
  static const double buttonLg = 50.0; // Large button height
  static const double buttonXl = 56.0; // Extra large button height

  // Legacy Button Heights
  @Deprecated('Use button scale instead - e.g., AppDimensions.buttonMd')
  static const double buttonHeightSmall = 32.0;
  @Deprecated('Use button scale instead - e.g., AppDimensions.buttonMd')
  static const double buttonHeightMedium = 44.0;
  @Deprecated('Use button scale instead - e.g., AppDimensions.buttonLg')
  static const double buttonHeightLarge = 52.0;

  // iOS Input Field Heights
  static const double inputSm = 36.0; // Small input height
  static const double inputMd = 44.0; // Standard iOS input height
  static const double inputLg = 52.0; // Large input height

  // Legacy Input Heights
  @Deprecated('Use input scale instead - e.g., AppDimensions.inputMd')
  static const double inputHeightSmall = 40.0;
  @Deprecated('Use input scale instead - e.g., AppDimensions.inputMd')
  static const double inputHeightMedium = 48.0;
  @Deprecated('Use input scale instead - e.g., AppDimensions.inputLg')
  static const double inputHeightLarge = 56.0;

  // iOS Card Heights (for home screen components)
  static const double cardCompact = 80.0; // Compact cards (nearby doctors)
  static const double cardStandard = 120.0; // Standard cards (quick actions)
  static const double cardExtended = 160.0; // Extended cards (featured doctors)
  static const double cardFull = 200.0; // Full cards (health tips)

  // Legacy Card Heights (keep for compatibility)
  static const double cardHeightSmall = 80.0;
  static const double cardHeightMedium = 120.0;
  static const double cardHeightLarge = 160.0;

  // iOS Avatar Sizes (CircleImageView standard)
  static const double avatarXs = 32.0; // Small avatar (list item)
  static const double avatarSm =
      40.0; // Medium avatar (category card beside text)
  static const double avatarMd =
      48.0; // Standard avatar (navigation, small profile)
  static const double avatarLg = 64.0; // Large avatar (medium profile)
  static const double avatarXl =
      80.0; // Extra large avatar (large profile, featured doctor)

  // Legacy Avatar Sizes
  static const double avatarSizeSmall = 32.0;
  static const double avatarSizeMedium = 48.0;
  static const double avatarSizeLarge = 64.0;
  static const double avatarSizeExtraLarge = 80.0;

  // iOS Navigation Heights (Cupertino standards)
  static const double statusBarHeight = 44.0; // iOS status bar
  static const double navigationBarHeight = 44.0; // iOS navigation bar
  static const double appBarHeight =
      statusBarHeight + navigationBarHeight; // 88pt total
  static const double bottomNavHeight =
      80.0; // Bottom navigation tab bar height

  // Home Screen Specific Dimensions (iOS-inspired)
  static const double menuBarHeight =
      64.0; // Menu bar with notifications and user info
  static const double categoryIconSize =
      60.0; // Medical category icon container
  static const double categoryIconPadding =
      8.0; // Space around icon within container
  static const double quickActionCardHeight = 88.0; // Quick action card height
  static const double searchIconSize = 20.0; // Search field icon size
  static const double doctorCardWidth =
      280.0; // Featured doctor card width on mobile
  static const double doctorCardWidthTablet =
      320.0; // Featured doctor card width on tablet

  // Status Indicators
  static const double statusDotSize = 8.0; // Online/available status dot
  static const double statusDotOffset = 4.0; // Offset from avatar corner
  static const double notificationBadgeSize = 8.0; // Notification badge

  // Touch Targets (iOS accessibility requirements)
  static const double touchTargetMinimum = 44.0; // Minimum touch target size
  static const double touchTargetSpacing =
      8.0; // Minimum spacing between touch targets

  // Screen Breakpoints
  static const double mobileBreakpoint = 600.0;
  static const double tabletBreakpoint = 900.0;
  static const double desktopBreakpoint = 1200.0;

  // Elevation
  static const double elevationSmall = 2.0;
  static const double elevationMedium = 4.0;
  static const double elevationLarge = 8.0;
  static const double elevationExtraLarge = 16.0;

  // Border Width
  static const double borderWidthThin = 0.5;
  static const double borderWidthMedium = 1.0;
  static const double borderWidthThick = 2.0;

  // Font Sizes
  static const double fontSizeCaption = 12.0;
  static const double fontSizeBodySmall = 14.0;
  static const double fontSizeBodyMedium = 16.0;
  static const double fontSizeBodyLarge = 18.0;
  static const double fontSizeHeadlineSmall = 20.0;
  static const double fontSizeHeadlineMedium = 24.0;
  static const double fontSizeHeadlineLarge = 28.0;
  static const double fontSizeDisplaySmall = 32.0;
  static const double fontSizeDisplayMedium = 36.0;
  static const double fontSizeDisplayLarge = 40.0;

  // Letter Spacing
  static const double letterSpacingTight = -0.5;
  static const double letterSpacingNormal = 0.0;
  static const double letterSpacingWide = 0.5;
  static const double letterSpacingExtraWide = 1.0;

  // Line Height
  static const double lineHeightTight = 1.2;
  static const double lineHeightNormal = 1.5;
  static const double lineHeightRelaxed = 1.8;

  // Animation Durations
  static const Duration animationDurationFast = Duration(milliseconds: 150);
  static const Duration animationDurationNormal = Duration(milliseconds: 300);
  static const Duration animationDurationSlow = Duration(milliseconds: 500);

  // Loading Indicator Size
  static const double loadingIndicatorSizeSmall = 16.0;
  static const double loadingIndicatorSizeMedium = 24.0;
  static const double loadingIndicatorSizeLarge = 32.0;

  // Dialog Width
  static const double dialogWidthSmall = 280.0;
  static const double dialogWidthMedium = 320.0;
  static const double dialogWidthLarge = 400.0;

  // Max Content Width (for desktop layouts)
  static const double maxContentWidth = 1200.0;
}
