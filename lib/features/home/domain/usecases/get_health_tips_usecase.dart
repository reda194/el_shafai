import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/health_tip.dart';
import '../repositories/home_repository.dart';

class GetHealthTipsUseCase
    implements UseCase<List<HealthTip>, GetHealthTipsParams> {
  final HomeRepository repository;

  GetHealthTipsUseCase(this.repository);

  @override
  Future<Either<Failure, List<HealthTip>>> call(
      GetHealthTipsParams params) async {
    return await repository.getHealthTips(
      limit: params.limit,
      offset: params.offset,
    );
  }
}

class GetHealthTipsParams {
  final int limit;
  final int offset;

  const GetHealthTipsParams({
    this.limit = 10,
    this.offset = 0,
  });
}
