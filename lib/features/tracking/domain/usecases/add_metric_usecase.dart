import 'package:dartz/dartz.dart';
import 'package:neurocare_app/core/errors/failures.dart';
import 'package:neurocare_app/core/usecases/usecase.dart';
import 'package:neurocare_app/features/tracking/domain/entities/health_metric_entity.dart';
import 'package:neurocare_app/features/tracking/domain/repositories/tracking_repository.dart';

class AddMetricUseCase implements UseCase<HealthMetric, HealthMetric> {
  final TrackingRepository repository;

  AddMetricUseCase(this.repository);

  @override
  Future<Either<Failure, HealthMetric>> call(HealthMetric metric) {
    return repository.addMetric(metric);
  }
}
