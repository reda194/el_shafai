import 'package:dartz/dartz.dart';
import 'package:neurocare_app/core/errors/failures.dart';
import 'package:neurocare_app/features/profile/domain/entities/user_profile.dart';

abstract class ProfileRepository {
  Future<Either<Failure, UserProfile>> getUserProfile();
  Future<Either<Failure, UserProfile>> updateUserProfile(UserProfile profile);
  Future<Either<Failure, void>> deleteUserProfile();
  Future<Either<Failure, String>> uploadProfileImage(String imagePath);
}
