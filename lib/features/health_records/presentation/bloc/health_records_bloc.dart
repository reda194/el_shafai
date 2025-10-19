import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neurocare_app/core/errors/failures.dart';
import '../../domain/entities/health_record_entity.dart';
import '../../domain/usecases/delete_health_record_usecase.dart';
import '../../domain/usecases/get_health_records_usecase.dart';
import '../../domain/usecases/upload_health_record_usecase.dart';
import 'health_records_event.dart';
import 'health_records_state.dart';

/// BLoC for managing health records state
class HealthRecordsBloc extends Bloc<HealthRecordsEvent, HealthRecordsState> {
  final GetHealthRecordsUseCase getHealthRecordsUseCase;
  final UploadHealthRecordUseCase uploadHealthRecordUseCase;
  final DeleteHealthRecordUseCase deleteHealthRecordUseCase;

  HealthRecordsBloc({
    required this.getHealthRecordsUseCase,
    required this.uploadHealthRecordUseCase,
    required this.deleteHealthRecordUseCase,
  }) : super(const HealthRecordsInitial()) {
    on<LoadHealthRecordsEvent>(_onLoadHealthRecords);
    on<LoadHealthRecordEvent>(_onLoadHealthRecord);
    on<UploadHealthRecordEvent>(_onUploadHealthRecord);
    on<DeleteHealthRecordEvent>(_onDeleteHealthRecord);
    on<UpdateHealthRecordEvent>(_onUpdateHealthRecord);
    on<ToggleFavoriteEvent>(_onToggleFavorite);
    on<ArchiveHealthRecordEvent>(_onArchiveHealthRecord);
    on<RestoreHealthRecordEvent>(_onRestoreHealthRecord);
    on<SearchHealthRecordsEvent>(_onSearchHealthRecords);
    on<FilterByTypeEvent>(_onFilterByType);
    on<LoadFavoriteHealthRecordsEvent>(_onLoadFavoriteHealthRecords);
    on<LoadArchivedHealthRecordsEvent>(_onLoadArchivedHealthRecords);
    on<ClearErrorEvent>(_onClearError);
  }

  Future<void> _onLoadHealthRecords(
    LoadHealthRecordsEvent event,
    Emitter<HealthRecordsState> emit,
  ) async {
    emit(const HealthRecordsLoading());

    final result = await getHealthRecordsUseCase(
      GetHealthRecordsParams(
        type: event.type,
        status: event.status,
        searchQuery: event.searchQuery,
        startDate: event.startDate,
        endDate: event.endDate,
      ),
    );

    result.fold(
      (failure) => emit(HealthRecordsError(failure: failure)),
      (records) {
        if (records.isEmpty) {
          emit(const HealthRecordsEmpty());
        } else {
          emit(HealthRecordsLoaded(
            records: records,
            currentFilter: event.type,
            currentSearchQuery: event.searchQuery,
          ));
        }
      },
    );
  }

  Future<void> _onLoadHealthRecord(
    LoadHealthRecordEvent event,
    Emitter<HealthRecordsState> emit,
  ) async {
    emit(const HealthRecordsLoading());

    // Note: We would need a GetHealthRecordUseCase for this
    // For now, we'll emit an error
    emit(const HealthRecordsError(
      failure: ServerFailure('Get single record not implemented yet'),
    ));
  }

  Future<void> _onUploadHealthRecord(
    UploadHealthRecordEvent event,
    Emitter<HealthRecordsState> emit,
  ) async {
    emit(const HealthRecordUploading());

    final result = await uploadHealthRecordUseCase(
      UploadHealthRecordParams(
        title: event.title,
        description: event.description,
        type: event.type,
        filePath: event.filePath,
        recordedAt: event.recordedAt,
        doctorName: event.doctorName,
        hospitalName: event.hospitalName,
        tags: event.tags,
      ),
    );

    result.fold(
      (failure) => emit(HealthRecordsError(failure: failure)),
      (record) {
        emit(HealthRecordOperationSuccess(
          message: 'Health record uploaded successfully',
          record: record,
        ));

        // Reload the records list
        add(const LoadHealthRecordsEvent());
      },
    );
  }

  Future<void> _onDeleteHealthRecord(
    DeleteHealthRecordEvent event,
    Emitter<HealthRecordsState> emit,
  ) async {
    emit(HealthRecordDeleting(recordId: event.recordId));

    final result = await deleteHealthRecordUseCase(
      DeleteHealthRecordParams(recordId: event.recordId),
    );

    result.fold(
      (failure) => emit(HealthRecordsError(failure: failure)),
      (_) {
        emit(const HealthRecordOperationSuccess(
          message: 'Health record deleted successfully',
        ));

        // Reload the records list
        add(const LoadHealthRecordsEvent());
      },
    );
  }

  Future<void> _onUpdateHealthRecord(
    UpdateHealthRecordEvent event,
    Emitter<HealthRecordsState> emit,
  ) async {
    emit(HealthRecordUpdating(recordId: event.recordId));

    // Note: We would need an UpdateHealthRecordUseCase for this
    // For now, we'll emit an error
    emit(const HealthRecordsError(
      failure: ServerFailure('Update record not implemented yet'),
    ));
  }

  Future<void> _onToggleFavorite(
    ToggleFavoriteEvent event,
    Emitter<HealthRecordsState> emit,
  ) async {
    emit(HealthRecordTogglingFavorite(recordId: event.recordId));

    // Note: We would need a ToggleFavoriteUseCase for this
    // For now, we'll emit an error
    emit(const HealthRecordsError(
      failure: ServerFailure('Toggle favorite not implemented yet'),
    ));
  }

  Future<void> _onArchiveHealthRecord(
    ArchiveHealthRecordEvent event,
    Emitter<HealthRecordsState> emit,
  ) async {
    emit(HealthRecordArchiving(recordId: event.recordId));

    // Note: We would need an ArchiveHealthRecordUseCase for this
    // For now, we'll emit an error
    emit(const HealthRecordsError(
      failure: ServerFailure('Archive record not implemented yet'),
    ));
  }

  Future<void> _onRestoreHealthRecord(
    RestoreHealthRecordEvent event,
    Emitter<HealthRecordsState> emit,
  ) async {
    emit(const HealthRecordsLoading());

    // Note: We would need a RestoreHealthRecordUseCase for this
    // For now, we'll emit an error
    emit(const HealthRecordsError(
      failure: ServerFailure('Restore record not implemented yet'),
    ));
  }

  Future<void> _onSearchHealthRecords(
    SearchHealthRecordsEvent event,
    Emitter<HealthRecordsState> emit,
  ) async {
    emit(const HealthRecordsLoading());

    final result = await getHealthRecordsUseCase(
      GetHealthRecordsParams(searchQuery: event.query),
    );

    result.fold(
      (failure) => emit(HealthRecordsError(failure: failure)),
      (records) {
        if (records.isEmpty) {
          emit(HealthRecordsEmpty(
              message: 'No records found for "${event.query}"'));
        } else {
          emit(HealthRecordsLoaded(
            records: records,
            currentSearchQuery: event.query,
          ));
        }
      },
    );
  }

  Future<void> _onFilterByType(
    FilterByTypeEvent event,
    Emitter<HealthRecordsState> emit,
  ) async {
    emit(const HealthRecordsLoading());

    final result = await getHealthRecordsUseCase(
      GetHealthRecordsParams(type: event.type),
    );

    result.fold(
      (failure) => emit(HealthRecordsError(failure: failure)),
      (records) {
        if (records.isEmpty) {
          emit(HealthRecordsEmpty(
              message:
                  'No ${event.type.displayName.toLowerCase()} records found'));
        } else {
          emit(HealthRecordsLoaded(
            records: records,
            currentFilter: event.type,
          ));
        }
      },
    );
  }

  Future<void> _onLoadFavoriteHealthRecords(
    LoadFavoriteHealthRecordsEvent event,
    Emitter<HealthRecordsState> emit,
  ) async {
    emit(const HealthRecordsLoading());

    // Note: We would need a GetFavoriteHealthRecordsUseCase for this
    // For now, we'll emit an error
    emit(const HealthRecordsError(
      failure: ServerFailure('Get favorite records not implemented yet'),
    ));
  }

  Future<void> _onLoadArchivedHealthRecords(
    LoadArchivedHealthRecordsEvent event,
    Emitter<HealthRecordsState> emit,
  ) async {
    emit(const HealthRecordsLoading());

    final result = await getHealthRecordsUseCase(
      const GetHealthRecordsParams(status: HealthRecordStatus.archived),
    );

    result.fold(
      (failure) => emit(HealthRecordsError(failure: failure)),
      (records) {
        if (records.isEmpty) {
          emit(const HealthRecordsEmpty(message: 'No archived records found'));
        } else {
          emit(HealthRecordsLoaded(
            records: records,
            currentFilter: null,
          ));
        }
      },
    );
  }

  void _onClearError(
    ClearErrorEvent event,
    Emitter<HealthRecordsState> emit,
  ) {
    // Return to initial state or last loaded state
    emit(const HealthRecordsInitial());
  }
}
