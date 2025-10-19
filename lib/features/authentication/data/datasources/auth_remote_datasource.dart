import '../../../../core/network/api_client.dart';
import '../models/auth_response_model.dart';
import '../models/user_model.dart';

abstract class AuthRemoteDataSource {
  /// Sign in with email and password
  Future<AuthResponseModel> signInWithEmailAndPassword({
    required String email,
    required String password,
  });

  /// Sign up with email and password
  Future<AuthResponseModel> signUpWithEmailAndPassword({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required String phoneNumber,
  });

  /// Sign in with Google
  Future<AuthResponseModel> signInWithGoogle();

  /// Sign in with Apple
  Future<AuthResponseModel> signInWithApple();

  /// Sign in with Facebook
  Future<AuthResponseModel> signInWithFacebook();

  /// Send password reset email
  Future<void> sendPasswordResetEmail(String email);

  /// Reset password with token
  Future<void> resetPassword({
    required String token,
    required String newPassword,
  });

  /// Verify email with token
  Future<void> verifyEmail(String token);

  /// Resend email verification
  Future<void> resendEmailVerification();

  /// Get current user profile
  Future<UserModel> getCurrentUser();

  /// Update user profile
  Future<UserModel> updateProfile({
    String? firstName,
    String? lastName,
    String? phoneNumber,
  });

  /// Change password
  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
  });

  /// Sign out
  Future<void> signOut();

  /// Refresh access token
  Future<AuthResponseModel> refreshToken();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiClient apiClient;

  AuthRemoteDataSourceImpl({required this.apiClient});

  @override
  Future<AuthResponseModel> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    final response = await apiClient.post(
      '/auth/login',
      data: {
        'email': email,
        'password': password,
      },
    );
    return AuthResponseModel.fromJson(response.data);
  }

  @override
  Future<AuthResponseModel> signUpWithEmailAndPassword({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required String phoneNumber,
  }) async {
    final response = await apiClient.post(
      '/auth/register',
      data: {
        'email': email,
        'password': password,
        'first_name': firstName,
        'last_name': lastName,
        'phone_number': phoneNumber,
      },
    );
    return AuthResponseModel.fromJson(response.data);
  }

  @override
  Future<AuthResponseModel> signInWithGoogle() async {
    final response = await apiClient.post('/auth/google');
    return AuthResponseModel.fromJson(response.data);
  }

  @override
  Future<AuthResponseModel> signInWithApple() async {
    final response = await apiClient.post('/auth/apple');
    return AuthResponseModel.fromJson(response.data);
  }

  @override
  Future<AuthResponseModel> signInWithFacebook() async {
    final response = await apiClient.post('/auth/facebook');
    return AuthResponseModel.fromJson(response.data);
  }

  @override
  Future<void> sendPasswordResetEmail(String email) async {
    await apiClient.post(
      '/auth/forgot-password',
      data: {'email': email},
    );
  }

  @override
  Future<void> resetPassword({
    required String token,
    required String newPassword,
  }) async {
    await apiClient.post(
      '/auth/reset-password',
      data: {
        'token': token,
        'password': newPassword,
      },
    );
  }

  @override
  Future<void> verifyEmail(String token) async {
    await apiClient.post(
      '/auth/verify-email',
      data: {'token': token},
    );
  }

  @override
  Future<void> resendEmailVerification() async {
    await apiClient.post('/auth/resend-verification');
  }

  @override
  Future<UserModel> getCurrentUser() async {
    final response = await apiClient.get('/auth/me');
    return UserModel.fromJson(response.data);
  }

  @override
  Future<UserModel> updateProfile({
    String? firstName,
    String? lastName,
    String? phoneNumber,
  }) async {
    final response = await apiClient.put(
      '/auth/profile',
      data: {
        if (firstName != null) 'first_name': firstName,
        if (lastName != null) 'last_name': lastName,
        if (phoneNumber != null) 'phone_number': phoneNumber,
      },
    );
    return UserModel.fromJson(response.data);
  }

  @override
  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    await apiClient.put(
      '/auth/change-password',
      data: {
        'current_password': currentPassword,
        'new_password': newPassword,
      },
    );
  }

  @override
  Future<void> signOut() async {
    await apiClient.post('/auth/logout');
  }

  @override
  Future<AuthResponseModel> refreshToken() async {
    final response = await apiClient.post('/auth/refresh');
    return AuthResponseModel.fromJson(response.data);
  }
}
