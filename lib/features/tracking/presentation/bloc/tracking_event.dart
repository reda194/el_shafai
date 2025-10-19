part of 'tracking_bloc.dart';

abstract class TrackingEvent {}

class AddHealthMetric extends TrackingEvent {
  final HealthMetric metric;

  AddHealthMetric(this.metric);
}

class LoadMetrics extends TrackingEvent {
  final MetricType metricType;
  final DateTime? startDate;
  final DateTime? endDate;
  final int limit;

  LoadMetrics({
    required this.metricType,
    this.startDate,
    this.endDate,
    this.limit = 50,
  });
}

class LoadMetricSummaries extends TrackingEvent {}
