class AppConfig {
  static const String appName = 'NeuroCare';
  static const String appVersion = '1.0.0';

  // API Configuration
  static const String baseUrl = 'https://api.neurocare.com';
  static const Duration apiTimeout = Duration(seconds: 30);

  // Local Storage
  static const String userBox = 'user_box';
  static const String settingsBox = 'settings_box';

  // Feature Flags
  static const bool enableBiometricAuth = true;
  static const bool enablePushNotifications = true;
  static const bool enableLocationServices = true;
}
