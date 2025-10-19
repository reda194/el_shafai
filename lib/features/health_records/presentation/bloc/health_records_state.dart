import 'package:equatable/equatable.dart';
import 'package:neurocare_app/core/errors/failures.dart';
import '../../domain/entities/health_record_entity.dart';

/// Base class for all health records states
abstract class HealthRecordsState extends Equatable {
  const HealthRecordsState();

  @override
  List<Object?> get props => [];
}

/// Initial state when the bloc is first created
class HealthRecordsInitial extends HealthRecordsState {
  const HealthRecordsInitial();
}

/// State when health records are being loaded
class HealthRecordsLoading extends HealthRecordsState {
  const HealthRecordsLoading();
}

/// State when health records are successfully loaded
class HealthRecordsLoaded extends HealthRecordsState {
  final List<HealthRecordEntity> records;
  final bool hasReachedMax;
  final int currentPage;
  final HealthRecordType? currentFilter;
  final String? currentSearchQuery;

  const HealthRecordsLoaded({
    required this.records,
    this.hasReachedMax = false,
    this.currentPage = 1,
    this.currentFilter,
    this.currentSearchQuery,
  });

  @override
  List<Object?> get props => [
        records,
        hasReachedMax,
        currentPage,
        currentFilter,
        currentSearchQuery,
      ];

  HealthRecordsLoaded copyWith({
    List<HealthRecordEntity>? records,
    bool? hasReachedMax,
    int? currentPage,
    HealthRecordType? currentFilter,
    String? currentSearchQuery,
  }) {
    return HealthRecordsLoaded(
      records: records ?? this.records,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      currentPage: currentPage ?? this.currentPage,
      currentFilter: currentFilter ?? this.currentFilter,
      currentSearchQuery: currentSearchQuery ?? this.currentSearchQuery,
    );
  }
}

/// State when a single health record is loaded
class HealthRecordLoaded extends HealthRecordsState {
  final HealthRecordEntity record;

  const HealthRecordLoaded({required this.record});

  @override
  List<Object> get props => [record];
}

/// State when a health record operation is successful
class HealthRecordOperationSuccess extends HealthRecordsState {
  final String message;
  final HealthRecordEntity? record;

  const HealthRecordOperationSuccess({
    required this.message,
    this.record,
  });

  @override
  List<Object?> get props => [message, record];
}

/// State when an error occurs
class HealthRecordsError extends HealthRecordsState {
  final Failure failure;
  final String? message;

  const HealthRecordsError({
    required this.failure,
    this.message,
  });

  @override
  List<Object?> get props => [failure, message];
}

/// State when health records are empty
class HealthRecordsEmpty extends HealthRecordsState {
  final String message;

  const HealthRecordsEmpty({
    this.message = 'No health records found',
  });

  @override
  List<Object> get props => [message];
}

/// State when uploading a health record
class HealthRecordUploading extends HealthRecordsState {
  final double progress;

  const HealthRecordUploading({this.progress = 0.0});

  @override
  List<Object> get props => [progress];
}

/// State when deleting a health record
class HealthRecordDeleting extends HealthRecordsState {
  final String recordId;

  const HealthRecordDeleting({required this.recordId});

  @override
  List<Object> get props => [recordId];
}

/// State when updating a health record
class HealthRecordUpdating extends HealthRecordsState {
  final String recordId;

  const HealthRecordUpdating({required this.recordId});

  @override
  List<Object> get props => [recordId];
}

/// State when archiving a health record
class HealthRecordArchiving extends HealthRecordsState {
  final String recordId;

  const HealthRecordArchiving({required this.recordId});

  @override
  List<Object> get props => [recordId];
}

/// State when toggling favorite status
class HealthRecordTogglingFavorite extends HealthRecordsState {
  final String recordId;

  const HealthRecordTogglingFavorite({required this.recordId});

  @override
  List<Object> get props => [recordId];
}
