import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/auth_repository.dart';

class ResetPasswordUseCase implements UseCase<void, ResetPasswordParams> {
  final AuthRepository repository;

  ResetPasswordUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(ResetPasswordParams params) async {
    return await repository.resetPassword(
      token: params.token,
      newPassword: params.newPassword,
    );
  }
}

class ResetPasswordParams {
  final String token;
  final String newPassword;

  const ResetPasswordParams({
    required this.token,
    required this.newPassword,
  });
}
