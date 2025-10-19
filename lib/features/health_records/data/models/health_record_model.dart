import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/health_record_entity.dart';

part 'health_record_model.g.dart';

/// Health record model for API communication
@JsonSerializable()
class HealthRecordModel extends HealthRecordEntity {
  const HealthRecordModel({
    required super.id,
    required super.userId,
    required super.title,
    required super.description,
    required super.type,
    required super.fileUrl,
    required super.fileName,
    required super.fileType,
    required super.fileSize,
    required super.uploadedAt,
    super.recordedAt,
    super.doctorName,
    super.hospitalName,
    super.tags,
    super.isFavorite,
    super.status,
  });

  /// Create a model from JSON
  factory HealthRecordModel.fromJson(Map<String, dynamic> json) =>
      _$HealthRecordModelFromJson(json);

  /// Convert model to JSON
  Map<String, dynamic> toJson() => _$HealthRecordModelToJson(this);

  /// Convert model to entity
  HealthRecordEntity toEntity() {
    return HealthRecordEntity(
      id: id,
      userId: userId,
      title: title,
      description: description,
      type: type,
      fileUrl: fileUrl,
      fileName: fileName,
      fileType: fileType,
      fileSize: fileSize,
      uploadedAt: uploadedAt,
      recordedAt: recordedAt,
      doctorName: doctorName,
      hospitalName: hospitalName,
      tags: tags,
      isFavorite: isFavorite,
      status: status,
    );
  }

  /// Create model from entity
  factory HealthRecordModel.fromEntity(HealthRecordEntity entity) {
    return HealthRecordModel(
      id: entity.id,
      userId: entity.userId,
      title: entity.title,
      description: entity.description,
      type: entity.type,
      fileUrl: entity.fileUrl,
      fileName: entity.fileName,
      fileType: entity.fileType,
      fileSize: entity.fileSize,
      uploadedAt: entity.uploadedAt,
      recordedAt: entity.recordedAt,
      doctorName: entity.doctorName,
      hospitalName: entity.hospitalName,
      tags: entity.tags,
      isFavorite: entity.isFavorite,
      status: entity.status,
    );
  }

  /// Create model from upload response
  factory HealthRecordModel.fromUploadResponse(Map<String, dynamic> json) {
    return HealthRecordModel.fromJson(json);
  }
}

/// Upload request model
class UploadHealthRecordRequest {
  final String title;
  final String description;
  final String type;
  final String filePath;
  final DateTime? recordedAt;
  final String? doctorName;
  final String? hospitalName;
  final List<String>? tags;

  const UploadHealthRecordRequest({
    required this.title,
    required this.description,
    required this.type,
    required this.filePath,
    this.recordedAt,
    this.doctorName,
    this.hospitalName,
    this.tags,
  });

  /// Convert to form data for multipart upload
  Map<String, dynamic> toFormData() {
    return {
      'title': title,
      'description': description,
      'type': type,
      if (recordedAt != null) 'recorded_at': recordedAt!.toIso8601String(),
      if (doctorName != null) 'doctor_name': doctorName,
      if (hospitalName != null) 'hospital_name': hospitalName,
      if (tags != null && tags!.isNotEmpty) 'tags': tags!.join(','),
    };
  }
}

/// Health record filters for API requests
class HealthRecordFilters {
  final HealthRecordType? type;
  final HealthRecordStatus? status;
  final String? searchQuery;
  final DateTime? startDate;
  final DateTime? endDate;
  final int? page;
  final int? limit;

  const HealthRecordFilters({
    this.type,
    this.status,
    this.searchQuery,
    this.startDate,
    this.endDate,
    this.page = 1,
    this.limit = 20,
  });

  /// Convert to query parameters
  Map<String, dynamic> toQueryParams() {
    return {
      if (type != null) 'type': type.toString().split('.').last,
      if (status != null) 'status': status.toString().split('.').last,
      if (searchQuery != null && searchQuery!.isNotEmpty) 'search': searchQuery,
      if (startDate != null)
        'start_date': startDate!.toIso8601String().split('T').first,
      if (endDate != null)
        'end_date': endDate!.toIso8601String().split('T').first,
      if (page != null) 'page': page.toString(),
      if (limit != null) 'limit': limit.toString(),
    };
  }
}

/// Health record response wrapper
@JsonSerializable()
class HealthRecordResponse {
  final List<HealthRecordModel> records;
  final int totalCount;
  final int page;
  final int limit;
  final bool hasNextPage;

  const HealthRecordResponse({
    required this.records,
    required this.totalCount,
    required this.page,
    required this.limit,
    required this.hasNextPage,
  });

  factory HealthRecordResponse.fromJson(Map<String, dynamic> json) =>
      _$HealthRecordResponseFromJson(json);

  Map<String, dynamic> toJson() => _$HealthRecordResponseToJson(this);
}
