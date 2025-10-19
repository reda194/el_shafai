import '../../domain/entities/auth_response_entity.dart';
import 'user_model.dart';

class AuthResponseModel extends AuthResponseEntity {
  const AuthResponseModel({
    required super.user,
    required super.accessToken,
    required super.refreshToken,
    required super.expiresAt,
    super.isNewUser = false,
  });

  factory AuthResponseModel.fromJson(Map<String, dynamic> json) {
    return AuthResponseModel(
      user: UserModel.fromJson(json['user'] as Map<String, dynamic>),
      accessToken: json['access_token'] as String,
      refreshToken: json['refresh_token'] as String,
      expiresAt: DateTime.parse(json['expires_at'] as String),
      isNewUser: json['is_new_user'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user': (user as UserModel).toJson(),
      'access_token': accessToken,
      'refresh_token': refreshToken,
      'expires_at': expiresAt.toIso8601String(),
      'is_new_user': isNewUser,
    };
  }

  factory AuthResponseModel.fromEntity(AuthResponseEntity entity) {
    return AuthResponseModel(
      user: UserModel.fromEntity(entity.user),
      accessToken: entity.accessToken,
      refreshToken: entity.refreshToken,
      expiresAt: entity.expiresAt,
      isNewUser: entity.isNewUser,
    );
  }
}
