import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neurocare_app/core/usecases/usecase.dart';
import 'package:neurocare_app/features/tracking/domain/entities/health_metric_entity.dart';
import 'package:neurocare_app/features/tracking/domain/usecases/add_metric_usecase.dart';
import 'package:neurocare_app/features/tracking/domain/usecases/get_metric_summaries_usecase.dart';
import 'package:neurocare_app/features/tracking/domain/usecases/get_metrics_usecase.dart';

part 'tracking_event.dart';
part 'tracking_state.dart';

class TrackingBloc extends Bloc<TrackingEvent, TrackingState> {
  final AddMetricUseCase addMetric;
  final GetMetricsUseCase getMetrics;
  final GetMetricSummariesUseCase getMetricSummaries;

  TrackingBloc({
    required this.addMetric,
    required this.getMetrics,
    required this.getMetricSummaries,
  }) : super(TrackingInitial()) {
    on<AddHealthMetric>(_onAddHealthMetric);
    on<LoadMetrics>(_onLoadMetrics);
    on<LoadMetricSummaries>(_onLoadMetricSummaries);
  }

  Future<void> _onAddHealthMetric(
    AddHealthMetric event,
    Emitter<TrackingState> emit,
  ) async {
    emit(TrackingLoading());
    final result = await addMetric(event.metric);

    result.fold(
      (failure) => emit(TrackingError(failure.message)),
      (metric) => emit(MetricAdded(metric)),
    );
  }

  Future<void> _onLoadMetrics(
    LoadMetrics event,
    Emitter<TrackingState> emit,
  ) async {
    emit(TrackingLoading());
    final result = await getMetrics(GetMetricsParams(
      type: event.metricType,
      startDate: event.startDate,
      endDate: event.endDate,
      limit: event.limit,
    ));

    result.fold(
      (failure) => emit(TrackingError(failure.message)),
      (metrics) => emit(MetricsLoaded(metrics)),
    );
  }

  Future<void> _onLoadMetricSummaries(
    LoadMetricSummaries event,
    Emitter<TrackingState> emit,
  ) async {
    emit(TrackingLoading());
    final result = await getMetricSummaries(NoParams());

    result.fold(
      (failure) => emit(TrackingError(failure.message)),
      (summaries) => emit(MetricSummariesLoaded(summaries)),
    );
  }
}
