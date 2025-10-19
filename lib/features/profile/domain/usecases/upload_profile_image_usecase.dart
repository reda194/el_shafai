import 'package:dartz/dartz.dart';
import 'package:neurocare_app/core/errors/failures.dart';
import 'package:neurocare_app/core/usecases/usecase.dart';
import 'package:neurocare_app/features/profile/domain/repositories/profile_repository.dart';

class UploadProfileImageUseCase implements UseCase<String, String> {
  final ProfileRepository repository;

  UploadProfileImageUseCase(this.repository);

  @override
  Future<Either<Failure, String>> call(String params) {
    return repository.uploadProfileImage(params);
  }
}
