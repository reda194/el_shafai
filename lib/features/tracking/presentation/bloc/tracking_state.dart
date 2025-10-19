part of 'tracking_bloc.dart';

abstract class TrackingState {}

class TrackingInitial extends TrackingState {}

class TrackingLoading extends TrackingState {}

class MetricAdded extends TrackingState {
  final HealthMetric metric;

  MetricAdded(this.metric);
}

class MetricsLoaded extends TrackingState {
  final List<HealthMetric> metrics;

  MetricsLoaded(this.metrics);
}

class MetricSummariesLoaded extends TrackingState {
  final List<MetricSummary> summaries;

  MetricSummariesLoaded(this.summaries);
}

class TrackingError extends TrackingState {
  final String message;

  TrackingError(this.message);
}
