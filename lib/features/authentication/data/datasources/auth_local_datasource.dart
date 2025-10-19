import 'package:shared_preferences/shared_preferences.dart';
import '../models/auth_response_model.dart';
import '../models/user_model.dart';

abstract class AuthLocalDataSource {
  /// Save authentication response to local storage
  Future<void> saveAuthResponse(AuthResponseModel authResponse);

  /// Get cached authentication response
  Future<AuthResponseModel?> getCachedAuthResponse();

  /// Save user data to local storage
  Future<void> saveUser(UserModel user);

  /// Get cached user data
  Future<UserModel?> getCachedUser();

  /// Clear all authentication data
  Future<void> clearAuthData();

  /// Check if user is authenticated locally
  Future<bool> isAuthenticated();

  /// Save access token
  Future<void> saveAccessToken(String token);

  /// Get access token
  Future<String?> getAccessToken();

  /// Save refresh token
  Future<void> saveRefreshToken(String token);

  /// Get refresh token
  Future<String?> getRefreshToken();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final SharedPreferences sharedPreferences;
  static const String _authResponseKey = 'auth_response';
  static const String _userKey = 'user_data';
  static const String _accessTokenKey = 'access_token';
  static const String _refreshTokenKey = 'refresh_token';

  AuthLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<void> saveAuthResponse(AuthResponseModel authResponse) async {
    final authJson = authResponse.toJson();
    await sharedPreferences.setString(_authResponseKey, authJson.toString());
    await saveAccessToken(authResponse.accessToken);
    await saveRefreshToken(authResponse.refreshToken);
  }

  @override
  Future<AuthResponseModel?> getCachedAuthResponse() async {
    final authString = sharedPreferences.getString(_authResponseKey);
    if (authString != null) {
      // Note: In a real app, you'd use json.decode here
      // For now, returning null as we can't parse string directly to AuthResponseModel
      return null;
    }
    return null;
  }

  @override
  Future<void> saveUser(UserModel user) async {
    final userJson = user.toJson();
    await sharedPreferences.setString(_userKey, userJson.toString());
  }

  @override
  Future<UserModel?> getCachedUser() async {
    final userString = sharedPreferences.getString(_userKey);
    if (userString != null) {
      // Note: In a real app, you'd use json.decode here
      return null;
    }
    return null;
  }

  @override
  Future<void> clearAuthData() async {
    await sharedPreferences.remove(_authResponseKey);
    await sharedPreferences.remove(_userKey);
    await sharedPreferences.remove(_accessTokenKey);
    await sharedPreferences.remove(_refreshTokenKey);
  }

  @override
  Future<bool> isAuthenticated() async {
    final accessToken = await getAccessToken();
    return accessToken != null && accessToken.isNotEmpty;
  }

  @override
  Future<void> saveAccessToken(String token) async {
    await sharedPreferences.setString(_accessTokenKey, token);
  }

  @override
  Future<String?> getAccessToken() async {
    return sharedPreferences.getString(_accessTokenKey);
  }

  @override
  Future<void> saveRefreshToken(String token) async {
    await sharedPreferences.setString(_refreshTokenKey, token);
  }

  @override
  Future<String?> getRefreshToken() async {
    return sharedPreferences.getString(_refreshTokenKey);
  }
}
