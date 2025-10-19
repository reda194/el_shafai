import 'package:dartz/dartz.dart';
import 'package:neurocare_app/core/errors/failures.dart';
import 'package:neurocare_app/core/usecases/usecase.dart';
import 'package:neurocare_app/features/tracking/domain/entities/health_metric_entity.dart';
import 'package:neurocare_app/features/tracking/domain/repositories/tracking_repository.dart';

class GetMetricSummariesUseCase
    implements UseCase<List<MetricSummary>, NoParams> {
  final TrackingRepository repository;

  GetMetricSummariesUseCase(this.repository);

  @override
  Future<Either<Failure, List<MetricSummary>>> call(NoParams params) {
    return repository.getMetricSummaries();
  }
}
