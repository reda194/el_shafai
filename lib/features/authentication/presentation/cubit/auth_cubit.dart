import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:neurocare_app/core/services/storage_service.dart';
import 'package:neurocare_app/core/constants/storage_keys.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(const AuthInitial());

  final _storageService = StorageService();

  /// Sign in with Apple
  Future<void> signInWithApple() async {
    emit(const AuthLoading());
    try {
      // TODO: Implement actual Apple sign in
      await Future.delayed(const Duration(seconds: 2));

      // Save auth data
      await _storageService.saveAuthToken(
          'apple_demo_token_${DateTime.now().millisecondsSinceEpoch}');
      await _storageService.savePreference(StorageKeys.isLoggedIn, true);
      await _storageService.savePreference(
          StorageKeys.userEmail, 'apple_user@example.com');

      emit(const AuthSuccess());
    } catch (e) {
      emit(AuthFailure('فشل تسجيل الدخول بـ Apple: $e'));
    }
  }

  /// Sign in with Google
  Future<void> signInWithGoogle() async {
    emit(const AuthLoading());
    try {
      // TODO: Implement actual Google sign in
      await Future.delayed(const Duration(seconds: 2));

      // Save auth data
      await _storageService.saveAuthToken(
          'google_demo_token_${DateTime.now().millisecondsSinceEpoch}');
      await _storageService.savePreference(StorageKeys.isLoggedIn, true);
      await _storageService.savePreference(
          StorageKeys.userEmail, 'google_user@example.com');

      emit(const AuthSuccess());
    } catch (e) {
      emit(AuthFailure('فشل تسجيل الدخول بـ Google: $e'));
    }
  }

  /// Sign in with Email and Password
  Future<void> signInWithEmail(String email, String password) async {
    emit(const AuthLoading());
    try {
      // TODO: Implement actual email/password sign in
      await Future.delayed(const Duration(seconds: 2));

      // Basic validation
      if (email.isEmpty || password.isEmpty) {
        emit(const AuthFailure('يرجى ملء جميع الحقول'));
        return;
      }

      if (!email.contains('@')) {
        emit(const AuthFailure('البريد الإلكتروني غير صحيح'));
        return;
      }

      // Save auth data
      await _storageService.saveAuthToken(
          'email_demo_token_${DateTime.now().millisecondsSinceEpoch}');
      await _storageService.savePreference(StorageKeys.isLoggedIn, true);
      await _storageService.savePreference(StorageKeys.userEmail, email);

      emit(const AuthSuccess());
    } catch (e) {
      emit(AuthFailure('فشل تسجيل الدخول: $e'));
    }
  }

  /// Sign up with email and password
  Future<void> signUpWithEmail({
    required String firstName,
    required String lastName,
    required String email,
    required String phone,
    required String password,
  }) async {
    emit(const AuthLoading());
    try {
      // TODO: Implement actual sign up
      await Future.delayed(const Duration(seconds: 2));

      // Basic validation
      if (firstName.isEmpty ||
          lastName.isEmpty ||
          email.isEmpty ||
          phone.isEmpty ||
          password.isEmpty) {
        emit(const AuthFailure('يرجى ملء جميع الحقول'));
        return;
      }

      if (!email.contains('@')) {
        emit(const AuthFailure('البريد الإلكتروني غير صحيح'));
        return;
      }

      if (password.length < 8) {
        emit(const AuthFailure('كلمة المرور يجب أن تكون 8 أحرف على الأقل'));
        return;
      }

      // Save auth data
      await _storageService.saveAuthToken(
          'signup_demo_token_${DateTime.now().millisecondsSinceEpoch}');
      await _storageService.savePreference(StorageKeys.isLoggedIn, true);
      await _storageService.savePreference(StorageKeys.userEmail, email);
      await _storageService.savePreference(
          StorageKeys.userName, '$firstName $lastName');

      emit(const AuthSuccess());
    } catch (e) {
      emit(AuthFailure('فشل إنشاء الحساب: $e'));
    }
  }

  /// Forgot password - send reset email
  Future<void> forgotPassword(String email) async {
    emit(const AuthLoading());
    try {
      // TODO: Implement forgot password logic
      await Future.delayed(const Duration(seconds: 2));

      if (email.isEmpty || !email.contains('@')) {
        emit(const AuthFailure('يرجى إدخال بريد إلكتروني صحيح'));
        return;
      }

      // For demo purposes, always succeed
      emit(const AuthSuccess());
    } catch (e) {
      emit(AuthFailure('فشل إرسال رابط إعادة تعيين كلمة المرور: $e'));
    }
  }

  /// Reset password
  Future<void> resetPassword(String newPassword, String confirmPassword) async {
    emit(const AuthLoading());
    try {
      // TODO: Implement reset password logic
      await Future.delayed(const Duration(seconds: 2));

      if (newPassword.isEmpty || confirmPassword.isEmpty) {
        emit(const AuthFailure('يرجى ملء جميع الحقول'));
        return;
      }

      if (newPassword != confirmPassword) {
        emit(const AuthFailure('كلمة المرور غير متطابقة'));
        return;
      }

      if (newPassword.length < 8) {
        emit(const AuthFailure('كلمة المرور يجب أن تكون 8 أحرف على الأقل'));
        return;
      }

      emit(const AuthSuccess());
    } catch (e) {
      emit(AuthFailure('فشل إعادة تعيين كلمة المرور: $e'));
    }
  }

  /// Sign out
  Future<void> signOut() async {
    emit(const AuthLoading());
    try {
      await _storageService.removeAuthToken();
      await _storageService.savePreference(StorageKeys.isLoggedIn, false);
      await _storageService.removePreference(StorageKeys.userEmail);
      await _storageService.removePreference(StorageKeys.userName);

      emit(const AuthInitial());
    } catch (e) {
      emit(AuthFailure('فشل تسجيل الخروج: $e'));
    }
  }

  /// Reset state to initial
  void resetState() {
    emit(const AuthInitial());
  }
}
