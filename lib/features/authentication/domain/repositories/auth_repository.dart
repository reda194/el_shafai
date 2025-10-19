import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/auth_response_entity.dart';
import '../entities/user_entity.dart';

abstract class AuthRepository {
  /// Sign in with email and password
  Future<Either<Failure, AuthResponseEntity>> signInWithEmailAndPassword({
    required String email,
    required String password,
  });

  /// Sign up with email and password
  Future<Either<Failure, AuthResponseEntity>> signUpWithEmailAndPassword({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required String phoneNumber,
  });

  /// Sign in with Google
  Future<Either<Failure, AuthResponseEntity>> signInWithGoogle();

  /// Sign in with Apple
  Future<Either<Failure, AuthResponseEntity>> signInWithApple();

  /// Sign in with Facebook
  Future<Either<Failure, AuthResponseEntity>> signInWithFacebook();

  /// Send password reset email
  Future<Either<Failure, void>> sendPasswordResetEmail(String email);

  /// Reset password with token
  Future<Either<Failure, void>> resetPassword({
    required String token,
    required String newPassword,
  });

  /// Verify email with token
  Future<Either<Failure, void>> verifyEmail(String token);

  /// Resend email verification
  Future<Either<Failure, void>> resendEmailVerification();

  /// Get current user
  Future<Either<Failure, UserEntity>> getCurrentUser();

  /// Update user profile
  Future<Either<Failure, UserEntity>> updateProfile({
    String? firstName,
    String? lastName,
    String? phoneNumber,
  });

  /// Change password
  Future<Either<Failure, void>> changePassword({
    required String currentPassword,
    required String newPassword,
  });

  /// Sign out
  Future<Either<Failure, void>> signOut();

  /// Check if user is authenticated
  Future<bool> isAuthenticated();

  /// Refresh access token
  Future<Either<Failure, AuthResponseEntity>> refreshToken();
}
