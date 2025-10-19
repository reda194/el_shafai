import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String id;
  final String email;
  final String? firstName;
  final String? lastName;
  final String? phoneNumber;
  final String? avatarUrl;
  final bool isEmailVerified;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const UserEntity({
    required this.id,
    required this.email,
    this.firstName,
    this.lastName,
    this.phoneNumber,
    this.avatarUrl,
    this.isEmailVerified = false,
    this.createdAt,
    this.updatedAt,
  });

  String get fullName => [firstName, lastName]
      .where((name) => name != null && name.isNotEmpty)
      .join(' ');

  @override
  List<Object?> get props => [
        id,
        email,
        firstName,
        lastName,
        phoneNumber,
        avatarUrl,
        isEmailVerified,
        createdAt,
        updatedAt,
      ];
}
