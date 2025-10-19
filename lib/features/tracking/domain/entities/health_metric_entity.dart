import 'package:equatable/equatable.dart';

enum MetricType {
  weight,
  bloodPressure,
  heartRate,
  bloodSugar,
  temperature,
  sleep,
  steps,
  calories,
  waterIntake,
}

class HealthMetric extends Equatable {
  final String id;
  final String userId;
  final MetricType type;
  final double value;
  final String unit;
  final DateTime recordedAt;
  final String? notes;
  final Map<String, dynamic>? additionalData;

  const HealthMetric({
    required this.id,
    required this.userId,
    required this.type,
    required this.value,
    required this.unit,
    required this.recordedAt,
    this.notes,
    this.additionalData,
  });

  HealthMetric copyWith({
    String? id,
    String? userId,
    MetricType? type,
    double? value,
    String? unit,
    DateTime? recordedAt,
    String? notes,
    Map<String, dynamic>? additionalData,
  }) {
    return HealthMetric(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      type: type ?? this.type,
      value: value ?? this.value,
      unit: unit ?? this.unit,
      recordedAt: recordedAt ?? this.recordedAt,
      notes: notes ?? this.notes,
      additionalData: additionalData ?? this.additionalData,
    );
  }

  @override
  List<Object?> get props => [
        id,
        userId,
        type,
        value,
        unit,
        recordedAt,
        notes,
        additionalData,
      ];
}

class MetricSummary extends Equatable {
  final MetricType type;
  final double currentValue;
  final double averageValue;
  final double minValue;
  final double maxValue;
  final List<HealthMetric> recentMetrics;
  final String trend; // 'up', 'down', 'stable'

  const MetricSummary({
    required this.type,
    required this.currentValue,
    required this.averageValue,
    required this.minValue,
    required this.maxValue,
    required this.recentMetrics,
    required this.trend,
  });

  @override
  List<Object> get props => [
        type,
        currentValue,
        averageValue,
        minValue,
        maxValue,
        recentMetrics,
        trend,
      ];
}

class HealthGoal extends Equatable {
  final String id;
  final String userId;
  final MetricType metricType;
  final double targetValue;
  final String targetUnit;
  final DateTime targetDate;
  final DateTime createdAt;
  final bool isActive;

  const HealthGoal({
    required this.id,
    required this.userId,
    required this.metricType,
    required this.targetValue,
    required this.targetUnit,
    required this.targetDate,
    required this.createdAt,
    this.isActive = true,
  });

  @override
  List<Object> get props => [
        id,
        userId,
        metricType,
        targetValue,
        targetUnit,
        targetDate,
        createdAt,
        isActive,
      ];
}
