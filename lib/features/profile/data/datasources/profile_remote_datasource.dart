import 'dart:io';
import 'package:dio/dio.dart';
import 'package:neurocare_app/features/profile/domain/entities/user_profile.dart';

abstract class ProfileRemoteDataSource {
  Future<UserProfile> getUserProfile();
  Future<UserProfile> updateUserProfile(UserProfile profile);
  Future<void> deleteUserProfile();
  Future<String> uploadProfileImage(File imageFile);
}

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  final Dio dio;

  ProfileRemoteDataSourceImpl({required this.dio});

  @override
  Future<UserProfile> getUserProfile() async {
    // TODO: Implement API call to get user profile
    // For now, return mock data
    await Future.delayed(const Duration(seconds: 1));
    return UserProfile(
      id: '1',
      fullName: 'محمد أحمد',
      email: 'mohamed@example.com',
      phoneNumber: '+966501234567',
      dateOfBirth: '1990-01-01',
      gender: 'ذكر',
      address: 'الرياض، المملكة العربية السعودية',
      emergencyContactName: 'أحمد محمد',
      emergencyContactPhone: '+966507654321',
      profileImageUrl: null,
      createdAt: DateTime.now().subtract(const Duration(days: 365)),
      updatedAt: DateTime.now(),
    );
  }

  @override
  Future<UserProfile> updateUserProfile(UserProfile profile) async {
    // TODO: Implement API call to update user profile
    await Future.delayed(const Duration(seconds: 1));
    return profile;
  }

  @override
  Future<void> deleteUserProfile() async {
    // TODO: Implement API call to delete user profile
    await Future.delayed(const Duration(seconds: 1));
  }

  @override
  Future<String> uploadProfileImage(File imageFile) async {
    // TODO: Implement API call to upload profile image
    await Future.delayed(const Duration(seconds: 2));
    return 'https://example.com/profile-images/user-1.jpg';
  }
}
