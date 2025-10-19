import 'package:dartz/dartz.dart';
import 'package:neurocare_app/core/errors/failures.dart';
import 'package:neurocare_app/core/usecases/usecase.dart';
import 'package:neurocare_app/features/profile/domain/entities/user_profile.dart';
import 'package:neurocare_app/features/profile/domain/repositories/profile_repository.dart';

class UpdateUserProfileUseCase implements UseCase<UserProfile, UserProfile> {
  final ProfileRepository repository;

  UpdateUserProfileUseCase(this.repository);

  @override
  Future<Either<Failure, UserProfile>> call(UserProfile params) {
    return repository.updateUserProfile(params);
  }
}
