import 'package:dartz/dartz.dart';
import 'package:neurocare_app/core/errors/failures.dart';
import 'package:neurocare_app/features/tracking/domain/entities/health_metric_entity.dart';

abstract class TrackingRepository {
  /// Add a new health metric
  Future<Either<Failure, HealthMetric>> addMetric(HealthMetric metric);

  /// Get metrics for a specific type and date range
  Future<Either<Failure, List<HealthMetric>>> getMetrics({
    required MetricType type,
    DateTime? startDate,
    DateTime? endDate,
    int limit = 50,
  });

  /// Get all metric types with their latest values
  Future<Either<Failure, List<MetricSummary>>> getMetricSummaries();

  /// Get metric summary for a specific type
  Future<Either<Failure, MetricSummary>> getMetricSummary(MetricType type);

  /// Update an existing metric
  Future<Either<Failure, HealthMetric>> updateMetric(HealthMetric metric);

  /// Delete a metric
  Future<Either<Failure, void>> deleteMetric(String metricId);

  /// Set a health goal
  Future<Either<Failure, HealthGoal>> setHealthGoal(HealthGoal goal);

  /// Get active health goals
  Future<Either<Failure, List<HealthGoal>>> getActiveGoals();

  /// Update goal progress
  Future<Either<Failure, HealthGoal>> updateGoalProgress(
      String goalId, double progress);
}
