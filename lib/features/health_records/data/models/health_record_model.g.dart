// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'health_record_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HealthRecordModel _$HealthRecordModelFromJson(Map<String, dynamic> json) =>
    HealthRecordModel(
      id: json['id'] as String,
      userId: json['userId'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      type: $enumDecode(_$HealthRecordTypeEnumMap, json['type']),
      fileUrl: json['fileUrl'] as String,
      fileName: json['fileName'] as String,
      fileType: json['fileType'] as String,
      fileSize: (json['fileSize'] as num).toInt(),
      uploadedAt: DateTime.parse(json['uploadedAt'] as String),
      recordedAt: json['recordedAt'] == null
          ? null
          : DateTime.parse(json['recordedAt'] as String),
      doctorName: json['doctorName'] as String?,
      hospitalName: json['hospitalName'] as String?,
      tags: (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList(),
      isFavorite: json['isFavorite'] as bool? ?? false,
      status:
          $enumDecodeNullable(_$HealthRecordStatusEnumMap, json['status']) ??
              HealthRecordStatus.active,
    );

Map<String, dynamic> _$HealthRecordModelToJson(HealthRecordModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'title': instance.title,
      'description': instance.description,
      'type': _$HealthRecordTypeEnumMap[instance.type]!,
      'fileUrl': instance.fileUrl,
      'fileName': instance.fileName,
      'fileType': instance.fileType,
      'fileSize': instance.fileSize,
      'uploadedAt': instance.uploadedAt.toIso8601String(),
      'recordedAt': instance.recordedAt?.toIso8601String(),
      'doctorName': instance.doctorName,
      'hospitalName': instance.hospitalName,
      'tags': instance.tags,
      'isFavorite': instance.isFavorite,
      'status': _$HealthRecordStatusEnumMap[instance.status]!,
    };

const _$HealthRecordTypeEnumMap = {
  HealthRecordType.prescription: 'prescription',
  HealthRecordType.labResult: 'labResult',
  HealthRecordType.imaging: 'imaging',
  HealthRecordType.medicalReport: 'medicalReport',
  HealthRecordType.vaccination: 'vaccination',
  HealthRecordType.allergy: 'allergy',
  HealthRecordType.surgery: 'surgery',
  HealthRecordType.dischargeSummary: 'dischargeSummary',
  HealthRecordType.insurance: 'insurance',
  HealthRecordType.other: 'other',
};

const _$HealthRecordStatusEnumMap = {
  HealthRecordStatus.active: 'active',
  HealthRecordStatus.archived: 'archived',
  HealthRecordStatus.deleted: 'deleted',
};

HealthRecordResponse _$HealthRecordResponseFromJson(
        Map<String, dynamic> json) =>
    HealthRecordResponse(
      records: (json['records'] as List<dynamic>)
          .map((e) => HealthRecordModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalCount: (json['totalCount'] as num).toInt(),
      page: (json['page'] as num).toInt(),
      limit: (json['limit'] as num).toInt(),
      hasNextPage: json['hasNextPage'] as bool,
    );

Map<String, dynamic> _$HealthRecordResponseToJson(
        HealthRecordResponse instance) =>
    <String, dynamic>{
      'records': instance.records,
      'totalCount': instance.totalCount,
      'page': instance.page,
      'limit': instance.limit,
      'hasNextPage': instance.hasNextPage,
    };
