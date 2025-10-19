import 'package:dartz/dartz.dart';
import 'package:neurocare_app/core/errors/failures.dart';
import 'package:neurocare_app/core/usecases/usecase.dart';
import 'package:neurocare_app/features/call/domain/entities/call_entity.dart';
import 'package:neurocare_app/features/call/domain/repositories/call_repository.dart';

class EndCallUseCase implements UseCase<CallEntity, String> {
  final CallRepository repository;

  EndCallUseCase(this.repository);

  @override
  Future<Either<Failure, CallEntity>> call(String callId) {
    return repository.endCall(callId);
  }
}
