import 'package:dartz/dartz.dart';
import 'package:neurocare_app/core/errors/failures.dart';
import 'package:neurocare_app/core/usecases/usecase.dart';
import 'package:neurocare_app/features/call/domain/entities/call_entity.dart';
import 'package:neurocare_app/features/call/domain/repositories/call_repository.dart';

class StartCallUseCase implements UseCase<CallEntity, StartCallParams> {
  final CallRepository repository;

  StartCallUseCase(this.repository);

  @override
  Future<Either<Failure, CallEntity>> call(StartCallParams params) {
    return repository.startCall(
      receiverId: params.receiverId,
      callType: params.callType,
    );
  }
}

class StartCallParams {
  final String receiverId;
  final CallType callType;

  const StartCallParams({
    required this.receiverId,
    required this.callType,
  });
}
