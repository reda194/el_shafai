import 'package:dartz/dartz.dart';
import 'package:neurocare_app/core/errors/failures.dart';
import 'package:neurocare_app/core/usecases/usecase.dart';
import 'package:neurocare_app/features/profile/domain/entities/user_profile.dart';
import 'package:neurocare_app/features/profile/domain/repositories/profile_repository.dart';

class GetUserProfileUseCase implements UseCase<UserProfile, NoParams> {
  final ProfileRepository repository;

  GetUserProfileUseCase(this.repository);

  @override
  Future<Either<Failure, UserProfile>> call(NoParams params) {
    return repository.getUserProfile();
  }
}
