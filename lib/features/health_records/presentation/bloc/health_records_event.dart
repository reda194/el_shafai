import 'package:equatable/equatable.dart';
import '../../domain/entities/health_record_entity.dart';

/// Base class for all health records events
abstract class HealthRecordsEvent extends Equatable {
  const HealthRecordsEvent();

  @override
  List<Object?> get props => [];
}

/// Event to load health records with optional filters
class LoadHealthRecordsEvent extends HealthRecordsEvent {
  final HealthRecordType? type;
  final HealthRecordStatus? status;
  final String? searchQuery;
  final DateTime? startDate;
  final DateTime? endDate;

  const LoadHealthRecordsEvent({
    this.type,
    this.status,
    this.searchQuery,
    this.startDate,
    this.endDate,
  });

  @override
  List<Object?> get props => [type, status, searchQuery, startDate, endDate];
}

/// Event to load a specific health record by ID
class LoadHealthRecordEvent extends HealthRecordsEvent {
  final String recordId;

  const LoadHealthRecordEvent({required this.recordId});

  @override
  List<Object> get props => [recordId];
}

/// Event to upload a new health record
class UploadHealthRecordEvent extends HealthRecordsEvent {
  final String title;
  final String description;
  final HealthRecordType type;
  final String filePath;
  final DateTime? recordedAt;
  final String? doctorName;
  final String? hospitalName;
  final List<String>? tags;

  const UploadHealthRecordEvent({
    required this.title,
    required this.description,
    required this.type,
    required this.filePath,
    this.recordedAt,
    this.doctorName,
    this.hospitalName,
    this.tags,
  });

  @override
  List<Object?> get props => [
        title,
        description,
        type,
        filePath,
        recordedAt,
        doctorName,
        hospitalName,
        tags,
      ];
}

/// Event to delete a health record
class DeleteHealthRecordEvent extends HealthRecordsEvent {
  final String recordId;

  const DeleteHealthRecordEvent({required this.recordId});

  @override
  List<Object> get props => [recordId];
}

/// Event to update a health record
class UpdateHealthRecordEvent extends HealthRecordsEvent {
  final String recordId;
  final String? title;
  final String? description;
  final HealthRecordType? type;
  final DateTime? recordedAt;
  final String? doctorName;
  final String? hospitalName;
  final List<String>? tags;
  final bool? isFavorite;

  const UpdateHealthRecordEvent({
    required this.recordId,
    this.title,
    this.description,
    this.type,
    this.recordedAt,
    this.doctorName,
    this.hospitalName,
    this.tags,
    this.isFavorite,
  });

  @override
  List<Object?> get props => [
        recordId,
        title,
        description,
        type,
        recordedAt,
        doctorName,
        hospitalName,
        tags,
        isFavorite,
      ];
}

/// Event to toggle favorite status of a health record
class ToggleFavoriteEvent extends HealthRecordsEvent {
  final String recordId;

  const ToggleFavoriteEvent({required this.recordId});

  @override
  List<Object> get props => [recordId];
}

/// Event to archive a health record
class ArchiveHealthRecordEvent extends HealthRecordsEvent {
  final String recordId;

  const ArchiveHealthRecordEvent({required this.recordId});

  @override
  List<Object> get props => [recordId];
}

/// Event to restore an archived health record
class RestoreHealthRecordEvent extends HealthRecordsEvent {
  final String recordId;

  const RestoreHealthRecordEvent({required this.recordId});

  @override
  List<Object> get props => [recordId];
}

/// Event to search health records
class SearchHealthRecordsEvent extends HealthRecordsEvent {
  final String query;

  const SearchHealthRecordsEvent({required this.query});

  @override
  List<Object> get props => [query];
}

/// Event to filter health records by type
class FilterByTypeEvent extends HealthRecordsEvent {
  final HealthRecordType type;

  const FilterByTypeEvent({required this.type});

  @override
  List<Object> get props => [type];
}

/// Event to load favorite health records
class LoadFavoriteHealthRecordsEvent extends HealthRecordsEvent {
  const LoadFavoriteHealthRecordsEvent();
}

/// Event to load archived health records
class LoadArchivedHealthRecordsEvent extends HealthRecordsEvent {
  const LoadArchivedHealthRecordsEvent();
}

/// Event to clear any error state
class ClearErrorEvent extends HealthRecordsEvent {
  const ClearErrorEvent();
}
