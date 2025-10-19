import 'package:dartz/dartz.dart';
import 'package:neurocare_app/core/errors/failures.dart';
import 'package:neurocare_app/core/usecases/usecase.dart';
import 'package:neurocare_app/features/call/domain/entities/call_entity.dart';
import 'package:neurocare_app/features/call/domain/repositories/call_repository.dart';

class GetCallHistoryUseCase implements UseCase<List<CallEntity>, NoParams> {
  final CallRepository repository;

  GetCallHistoryUseCase(this.repository);

  @override
  Future<Either<Failure, List<CallEntity>>> call(NoParams params) {
    return repository.getCallHistory();
  }
}
