/// Storage keys constants for the entire application
/// Used with SharedPreferences and Hive for data persistence
class StorageKeys {
  // Private constructor to prevent instantiation
  StorageKeys._();

  // ============ ONBOARDING KEYS ============

  /// Has user completed the onboarding flow?
  /// Type: bool
  /// Default: false
  static const String hasCompletedOnboarding = 'has_completed_onboarding';

  /// Onboarding version (to show new onboarding when updated)
  /// Type: String
  /// Example: '1.0.0'
  static const String onboardingVersion = 'onboarding_version';

  // ============ AUTHENTICATION KEYS ============

  /// Authentication token
  /// Type: String
  /// Example: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...'
  static const String authToken = 'auth_token';

  /// Refresh token for renewing auth token
  /// Type: String
  static const String refreshToken = 'refresh_token';

  /// Token expiration timestamp
  /// Type: int (milliseconds since epoch)
  static const String tokenExpiration = 'token_expiration';

  /// Is user currently logged in?
  /// Type: bool
  /// Default: false
  static const String isLoggedIn = 'is_logged_in';

  /// Remember me option
  /// Type: bool
  /// Default: false
  static const String rememberMe = 'remember_me';

  /// Last login timestamp
  /// Type: int (milliseconds since epoch)
  static const String lastLoginTimestamp = 'last_login_timestamp';

  // ============ USER DATA KEYS ============

  /// User ID
  /// Type: String
  static const String userId = 'user_id';

  /// User profile data (full object)
  /// Type: JSON String
  static const String userData = 'user_data';

  /// User email
  /// Type: String
  static const String userEmail = 'user_email';

  /// User full name
  /// Type: String
  static const String userName = 'user_name';

  /// User phone number
  /// Type: String
  static const String userPhone = 'user_phone';

  /// User profile picture URL
  /// Type: String
  static const String userProfilePicture = 'user_profile_picture';

  /// User type (patient, doctor, admin)
  /// Type: String
  static const String userType = 'user_type';

  // ============ APP PREFERENCES KEYS ============

  /// Theme mode (light, dark, system)
  /// Type: String
  /// Default: 'system'
  static const String themeMode = 'theme_mode';

  /// Language code (ar, en)
  /// Type: String
  /// Default: 'ar'
  static const String languageCode = 'language_code';

  /// Notifications enabled
  /// Type: bool
  /// Default: true
  static const String notificationsEnabled = 'notifications_enabled';

  /// Push notifications enabled
  /// Type: bool
  /// Default: true
  static const String pushNotificationsEnabled = 'push_notifications_enabled';

  /// Email notifications enabled
  /// Type: bool
  /// Default: true
  static const String emailNotificationsEnabled = 'email_notifications_enabled';

  /// SMS notifications enabled
  /// Type: bool
  /// Default: false
  static const String smsNotificationsEnabled = 'sms_notifications_enabled';

  /// Sound enabled
  /// Type: bool
  /// Default: true
  static const String soundEnabled = 'sound_enabled';

  /// Vibration enabled
  /// Type: bool
  /// Default: true
  static const String vibrationEnabled = 'vibration_enabled';

  // ============ NAVIGATION KEYS ============

  /// Last visited screen
  /// Type: String
  static const String lastScreen = 'last_screen';

  /// Last bottom navigation index
  /// Type: int
  /// Default: 0
  static const String lastBottomNavIndex = 'last_bottom_nav_index';

  // ============ CACHE KEYS ============

  /// Doctors list cache
  /// Type: JSON String
  static const String doctorsCache = 'doctors_cache';

  /// Doctors cache timestamp
  /// Type: int (milliseconds since epoch)
  static const String doctorsCacheTimestamp = 'doctors_cache_timestamp';

  /// Appointments cache
  /// Type: JSON String
  static const String appointmentsCache = 'appointments_cache';

  /// Appointments cache timestamp
  /// Type: int (milliseconds since epoch)
  static const String appointmentsCacheTimestamp =
      'appointments_cache_timestamp';

  /// Medical categories cache
  /// Type: JSON String
  static const String medicalCategoriesCache = 'medical_categories_cache';

  /// Chat rooms cache
  /// Type: JSON String
  static const String chatRoomsCache = 'chat_rooms_cache';

  /// Health records cache
  /// Type: JSON String
  static const String healthRecordsCache = 'health_records_cache';

  // ============ SEARCH HISTORY KEYS ============

  /// Recent doctor searches
  /// Type: List<String> (JSON)
  static const String recentDoctorSearches = 'recent_doctor_searches';

  /// Recent location searches
  /// Type: List<String> (JSON)
  static const String recentLocationSearches = 'recent_location_searches';

  // ============ FILTER PREFERENCES KEYS ============

  /// Last selected specialty filter
  /// Type: String
  static const String lastSpecialtyFilter = 'last_specialty_filter';

  /// Last selected location filter
  /// Type: String
  static const String lastLocationFilter = 'last_location_filter';

  /// Last selected price range filter
  /// Type: JSON String (PriceRange object)
  static const String lastPriceRangeFilter = 'last_price_range_filter';

  /// Last selected rating filter
  /// Type: double
  static const String lastRatingFilter = 'last_rating_filter';

  // ============ BIOMETRIC KEYS ============

  /// Biometric authentication enabled
  /// Type: bool
  /// Default: false
  static const String biometricEnabled = 'biometric_enabled';

  /// Biometric type (fingerprint, face, none)
  /// Type: String
  static const String biometricType = 'biometric_type';

  // ============ ANALYTICS KEYS ============

  /// User has consented to analytics
  /// Type: bool
  /// Default: false
  static const String analyticsConsent = 'analytics_consent';

  /// App install timestamp
  /// Type: int (milliseconds since epoch)
  static const String appInstallTimestamp = 'app_install_timestamp';

  /// App launch count
  /// Type: int
  static const String appLaunchCount = 'app_launch_count';

  /// Last app version
  /// Type: String
  /// Example: '1.0.0'
  static const String lastAppVersion = 'last_app_version';

  // ============ FEATURE FLAGS KEYS ============

  /// Video call feature enabled
  /// Type: bool
  /// Default: true
  static const String videoCallEnabled = 'video_call_enabled';

  /// Audio call feature enabled
  /// Type: bool
  /// Default: true
  static const String audioCallEnabled = 'audio_call_enabled';

  /// Chat feature enabled
  /// Type: bool
  /// Default: true
  static const String chatEnabled = 'chat_enabled';

  /// Payment feature enabled
  /// Type: bool
  /// Default: true
  static const String paymentEnabled = 'payment_enabled';

  // ============ UTILITY METHODS ============

  /// Get all authentication related keys
  static List<String> get authKeys => [
        authToken,
        refreshToken,
        tokenExpiration,
        isLoggedIn,
        rememberMe,
        lastLoginTimestamp,
      ];

  /// Get all user data related keys
  static List<String> get userDataKeys => [
        userId,
        userData,
        userEmail,
        userName,
        userPhone,
        userProfilePicture,
        userType,
      ];

  /// Get all cache related keys
  static List<String> get cacheKeys => [
        doctorsCache,
        doctorsCacheTimestamp,
        appointmentsCache,
        appointmentsCacheTimestamp,
        medicalCategoriesCache,
        chatRoomsCache,
        healthRecordsCache,
      ];

  /// Get all preference related keys
  static List<String> get preferenceKeys => [
        themeMode,
        languageCode,
        notificationsEnabled,
        pushNotificationsEnabled,
        emailNotificationsEnabled,
        smsNotificationsEnabled,
        soundEnabled,
        vibrationEnabled,
      ];
}
