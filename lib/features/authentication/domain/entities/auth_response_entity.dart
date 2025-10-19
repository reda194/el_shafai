import 'package:equatable/equatable.dart';
import 'user_entity.dart';

class AuthResponseEntity extends Equatable {
  final UserEntity user;
  final String accessToken;
  final String refreshToken;
  final DateTime expiresAt;
  final bool isNewUser;

  const AuthResponseEntity({
    required this.user,
    required this.accessToken,
    required this.refreshToken,
    required this.expiresAt,
    this.isNewUser = false,
  });

  @override
  List<Object> get props =>
      [user, accessToken, refreshToken, expiresAt, isNewUser];
}
