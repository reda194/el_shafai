import 'dart:convert';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Storage service for handling local data persistence using Hive and SharedPreferences
class StorageService {
  static final StorageService _instance = StorageService._internal();
  factory StorageService() => _instance;
  StorageService._internal();

  static const String _userBox = 'user_box';
  static const String _appBox = 'app_box';
  static const String _cacheBox = 'cache_box';

  late Box _userBoxInstance;
  late Box _appBoxInstance;
  late Box _cacheBoxInstance;
  late SharedPreferences _sharedPreferences;

  /// Initialize storage service
  Future<void> initialize() async {
    // Initialize Hive boxes
    _userBoxInstance = await Hive.openBox(_userBox);
    _appBoxInstance = await Hive.openBox(_appBox);
    _cacheBoxInstance = await Hive.openBox(_cacheBox);

    // Initialize SharedPreferences
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  // ============ USER DATA METHODS ============

  /// Save user data
  Future<void> saveUserData(String key, dynamic value) async {
    await _userBoxInstance.put(key, value);
  }

  /// Get user data
  T? getUserData<T>(String key) {
    return _userBoxInstance.get(key) as T?;
  }

  /// Remove user data
  Future<void> removeUserData(String key) async {
    await _userBoxInstance.delete(key);
  }

  /// Clear all user data
  Future<void> clearUserData() async {
    await _userBoxInstance.clear();
  }

  /// Check if user data exists
  bool hasUserData(String key) {
    return _userBoxInstance.containsKey(key);
  }

  // ============ APP DATA METHODS ============

  /// Save app data
  Future<void> saveAppData(String key, dynamic value) async {
    await _appBoxInstance.put(key, value);
  }

  /// Get app data
  T? getAppData<T>(String key) {
    return _appBoxInstance.get(key) as T?;
  }

  /// Remove app data
  Future<void> removeAppData(String key) async {
    await _appBoxInstance.delete(key);
  }

  /// Clear all app data
  Future<void> clearAppData() async {
    await _appBoxInstance.clear();
  }

  // ============ CACHE METHODS ============

  /// Save cached data with expiration
  Future<void> saveCacheData(String key, dynamic value,
      {Duration? expiry}) async {
    final cacheData = {
      'data': value,
      'timestamp': DateTime.now().millisecondsSinceEpoch,
      'expiry': expiry?.inMilliseconds,
    };
    await _cacheBoxInstance.put(key, cacheData);
  }

  /// Get cached data (checks expiration)
  T? getCacheData<T>(String key) {
    final cacheData = _cacheBoxInstance.get(key);
    if (cacheData == null) return null;

    final timestamp = cacheData['timestamp'] as int?;
    final expiry = cacheData['expiry'] as int?;

    if (timestamp == null) return null;

    // Check if data has expired
    if (expiry != null) {
      final now = DateTime.now().millisecondsSinceEpoch;
      if (now - timestamp > expiry) {
        // Data expired, remove it
        _cacheBoxInstance.delete(key);
        return null;
      }
    }

    return cacheData['data'] as T?;
  }

  /// Clear expired cache data
  Future<void> clearExpiredCache() async {
    final keys = _cacheBoxInstance.keys.toList();
    final now = DateTime.now().millisecondsSinceEpoch;

    for (final key in keys) {
      final cacheData = _cacheBoxInstance.get(key);
      if (cacheData != null) {
        final expiry = cacheData['expiry'] as int?;
        if (expiry != null) {
          final timestamp = cacheData['timestamp'] as int? ?? 0;
          if (now - timestamp > expiry) {
            await _cacheBoxInstance.delete(key);
          }
        }
      }
    }
  }

  /// Clear all cache data
  Future<void> clearCacheData() async {
    await _cacheBoxInstance.clear();
  }

  // ============ SHARED PREFERENCES METHODS ============

  /// Save data to SharedPreferences
  Future<void> savePreference(String key, dynamic value) async {
    if (value is String) {
      await _sharedPreferences.setString(key, value);
    } else if (value is int) {
      await _sharedPreferences.setInt(key, value);
    } else if (value is double) {
      await _sharedPreferences.setDouble(key, value);
    } else if (value is bool) {
      await _sharedPreferences.setBool(key, value);
    } else if (value is List<String>) {
      await _sharedPreferences.setStringList(key, value);
    } else {
      // For complex objects, encode as JSON
      await _sharedPreferences.setString(key, jsonEncode(value));
    }
  }

  /// Get data from SharedPreferences
  T? getPreference<T>(String key) {
    if (!_sharedPreferences.containsKey(key)) return null;

    if (T == String) {
      return _sharedPreferences.getString(key) as T?;
    } else if (T == int) {
      return _sharedPreferences.getInt(key) as T?;
    } else if (T == double) {
      return _sharedPreferences.getDouble(key) as T?;
    } else if (T == bool) {
      return _sharedPreferences.getBool(key) as T?;
    } else if (T == List<String>) {
      return _sharedPreferences.getStringList(key) as T?;
    } else {
      // Try to decode as JSON
      final jsonString = _sharedPreferences.getString(key);
      if (jsonString != null) {
        try {
          return jsonDecode(jsonString) as T?;
        } catch (e) {
          return null;
        }
      }
    }
    return null;
  }

  /// Remove preference
  Future<void> removePreference(String key) async {
    await _sharedPreferences.remove(key);
  }

  /// Clear all preferences
  Future<void> clearPreferences() async {
    await _sharedPreferences.clear();
  }

  // ============ AUTHENTICATION METHODS ============

  /// Save authentication token
  Future<void> saveAuthToken(String token) async {
    await savePreference('auth_token', token);
  }

  /// Get authentication token
  String? getAuthToken() {
    return getPreference<String>('auth_token');
  }

  /// Remove authentication token
  Future<void> removeAuthToken() async {
    await removePreference('auth_token');
  }

  /// Check if user is authenticated
  bool isAuthenticated() {
    return getAuthToken() != null;
  }

  // ============ THEME METHODS ============

  /// Save theme preference
  Future<void> saveThemeMode(String themeMode) async {
    await savePreference('theme_mode', themeMode);
  }

  /// Get theme preference
  String? getThemeMode() {
    return getPreference<String>('theme_mode');
  }

  // ============ LANGUAGE METHODS ============

  /// Save language preference
  Future<void> saveLanguage(String languageCode) async {
    await savePreference('language_code', languageCode);
  }

  /// Get language preference
  String? getLanguage() {
    return getPreference<String>('language_code');
  }

  // ============ UTILITY METHODS ============

  /// Clear all data (use with caution)
  Future<void> clearAllData() async {
    await clearUserData();
    await clearAppData();
    await clearCacheData();
    await clearPreferences();
  }

  /// Get storage usage information
  Future<Map<String, int>> getStorageInfo() async {
    return {
      'user_data': _userBoxInstance.length,
      'app_data': _appBoxInstance.length,
      'cache_data': _cacheBoxInstance.length,
      'preferences': _sharedPreferences.getKeys().length,
    };
  }

  /// Close all boxes (call when app is terminating)
  Future<void> close() async {
    await _userBoxInstance.close();
    await _appBoxInstance.close();
    await _cacheBoxInstance.close();
  }
}
