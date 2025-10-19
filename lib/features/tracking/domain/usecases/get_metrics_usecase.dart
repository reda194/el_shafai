import 'package:dartz/dartz.dart';
import 'package:neurocare_app/core/errors/failures.dart';
import 'package:neurocare_app/core/usecases/usecase.dart';
import 'package:neurocare_app/features/tracking/domain/entities/health_metric_entity.dart';
import 'package:neurocare_app/features/tracking/domain/repositories/tracking_repository.dart';

class GetMetricsUseCase
    implements UseCase<List<HealthMetric>, GetMetricsParams> {
  final TrackingRepository repository;

  GetMetricsUseCase(this.repository);

  @override
  Future<Either<Failure, List<HealthMetric>>> call(GetMetricsParams params) {
    return repository.getMetrics(
      type: params.type,
      startDate: params.startDate,
      endDate: params.endDate,
      limit: params.limit,
    );
  }
}

class GetMetricsParams {
  final MetricType type;
  final DateTime? startDate;
  final DateTime? endDate;
  final int limit;

  const GetMetricsParams({
    required this.type,
    this.startDate,
    this.endDate,
    this.limit = 50,
  });
}
