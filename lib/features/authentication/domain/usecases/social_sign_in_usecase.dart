import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/auth_response_entity.dart';
import '../repositories/auth_repository.dart';

class SocialSignInUseCase
    implements UseCase<AuthResponseEntity, SocialSignInParams> {
  final AuthRepository repository;

  SocialSignInUseCase(this.repository);

  @override
  Future<Either<Failure, AuthResponseEntity>> call(
      SocialSignInParams params) async {
    switch (params.provider) {
      case SocialProvider.google:
        return await repository.signInWithGoogle();
      case SocialProvider.apple:
        return await repository.signInWithApple();
      case SocialProvider.facebook:
        return await repository.signInWithFacebook();
    }
  }
}

enum SocialProvider {
  google,
  apple,
  facebook,
}

class SocialSignInParams {
  final SocialProvider provider;

  const SocialSignInParams({required this.provider});
}
