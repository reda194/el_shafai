import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/auth_response_entity.dart';
import '../repositories/auth_repository.dart';

class SignUpUseCase implements UseCase<AuthResponseEntity, SignUpParams> {
  final AuthRepository repository;

  SignUpUseCase(this.repository);

  @override
  Future<Either<Failure, AuthResponseEntity>> call(SignUpParams params) async {
    return await repository.signUpWithEmailAndPassword(
      email: params.email,
      password: params.password,
      firstName: params.firstName,
      lastName: params.lastName,
      phoneNumber: params.phoneNumber,
    );
  }
}

class SignUpParams {
  final String email;
  final String password;
  final String firstName;
  final String lastName;
  final String phoneNumber;

  const SignUpParams({
    required this.email,
    required this.password,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
  });
}
