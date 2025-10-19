import 'package:neurocare_app/features/tracking/data/models/health_metric_model.dart';
import 'package:neurocare_app/features/tracking/domain/entities/health_metric_entity.dart';

abstract class TrackingRemoteDataSource {
  /// Add a new health metric
  Future<HealthMetricModel> addMetric(HealthMetricModel metric);

  /// Get metrics for a specific type and date range
  Future<List<HealthMetricModel>> getMetrics({
    required MetricType type,
    DateTime? startDate,
    DateTime? endDate,
    int limit = 50,
  });

  /// Get all metric types with their latest values
  Future<List<MetricSummaryModel>> getMetricSummaries();

  /// Get metric summary for a specific type
  Future<MetricSummaryModel> getMetricSummary(MetricType type);

  /// Update an existing metric
  Future<HealthMetricModel> updateMetric(HealthMetricModel metric);

  /// Delete a metric
  Future<void> deleteMetric(String metricId);

  /// Set a health goal
  Future<HealthGoalModel> setHealthGoal(HealthGoalModel goal);

  /// Get active health goals
  Future<List<HealthGoalModel>> getActiveGoals();

  /// Update goal progress
  Future<HealthGoalModel> updateGoalProgress(String goalId, double progress);
}
