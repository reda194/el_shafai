import 'package:neurocare_app/features/tracking/domain/entities/health_metric_entity.dart';

class HealthMetricModel extends HealthMetric {
  const HealthMetricModel({
    required super.id,
    required super.userId,
    required super.type,
    required super.value,
    required super.unit,
    required super.recordedAt,
    super.notes,
    super.additionalData,
  });

  factory HealthMetricModel.fromJson(Map<String, dynamic> json) {
    return HealthMetricModel(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      type: MetricType.values.firstWhere(
        (type) => type.toString() == json['type'],
      ),
      value: (json['value'] as num).toDouble(),
      unit: json['unit'] as String,
      recordedAt: DateTime.parse(json['recorded_at'] as String),
      notes: json['notes'] as String?,
      additionalData: json['additional_data'] as Map<String, dynamic>?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'type': type.toString(),
      'value': value,
      'unit': unit,
      'recorded_at': recordedAt.toIso8601String(),
      'notes': notes,
      'additional_data': additionalData,
    };
  }

  factory HealthMetricModel.fromEntity(HealthMetric entity) {
    return HealthMetricModel(
      id: entity.id,
      userId: entity.userId,
      type: entity.type,
      value: entity.value,
      unit: entity.unit,
      recordedAt: entity.recordedAt,
      notes: entity.notes,
      additionalData: entity.additionalData,
    );
  }
}

class MetricSummaryModel extends MetricSummary {
  const MetricSummaryModel({
    required super.type,
    required super.currentValue,
    required super.averageValue,
    required super.minValue,
    required super.maxValue,
    required super.recentMetrics,
    required super.trend,
  });

  factory MetricSummaryModel.fromJson(Map<String, dynamic> json) {
    return MetricSummaryModel(
      type: MetricType.values.firstWhere(
        (type) => type.toString() == json['type'],
      ),
      currentValue: (json['current_value'] as num).toDouble(),
      averageValue: (json['average_value'] as num).toDouble(),
      minValue: (json['min_value'] as num).toDouble(),
      maxValue: (json['max_value'] as num).toDouble(),
      recentMetrics: (json['recent_metrics'] as List<dynamic>)
          .map((metric) =>
              HealthMetricModel.fromJson(metric as Map<String, dynamic>))
          .toList(),
      trend: json['trend'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type.toString(),
      'current_value': currentValue,
      'average_value': averageValue,
      'min_value': minValue,
      'max_value': maxValue,
      'recent_metrics': recentMetrics
          .map((metric) => HealthMetricModel.fromEntity(metric).toJson())
          .toList(),
      'trend': trend,
    };
  }
}

class HealthGoalModel extends HealthGoal {
  const HealthGoalModel({
    required super.id,
    required super.userId,
    required super.metricType,
    required super.targetValue,
    required super.targetUnit,
    required super.targetDate,
    required super.createdAt,
    super.isActive,
  });

  factory HealthGoalModel.fromJson(Map<String, dynamic> json) {
    return HealthGoalModel(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      metricType: MetricType.values.firstWhere(
        (type) => type.toString() == json['metric_type'],
      ),
      targetValue: (json['target_value'] as num).toDouble(),
      targetUnit: json['target_unit'] as String,
      targetDate: DateTime.parse(json['target_date'] as String),
      createdAt: DateTime.parse(json['created_at'] as String),
      isActive: json['is_active'] as bool? ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'metric_type': metricType.toString(),
      'target_value': targetValue,
      'target_unit': targetUnit,
      'target_date': targetDate.toIso8601String(),
      'created_at': createdAt.toIso8601String(),
      'is_active': isActive,
    };
  }
}
