import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/health_record_entity.dart';

/// Repository interface for health records operations
abstract class HealthRecordsRepository {
  /// Get all health records for the current user
  Future<Either<Failure, List<HealthRecordEntity>>> getHealthRecords({
    HealthRecordType? type,
    HealthRecordStatus? status,
    String? searchQuery,
    DateTime? startDate,
    DateTime? endDate,
  });

  /// Upload a new health record
  Future<Either<Failure, HealthRecordEntity>> uploadHealthRecord({
    required String title,
    required String description,
    required HealthRecordType type,
    required String filePath,
    DateTime? recordedAt,
    String? doctorName,
    String? hospitalName,
    List<String>? tags,
  });

  /// Delete a health record
  Future<Either<Failure, void>> deleteHealthRecord(String recordId);

  /// Update a health record
  Future<Either<Failure, HealthRecordEntity>> updateHealthRecord({
    required String recordId,
    String? title,
    String? description,
    HealthRecordType? type,
    DateTime? recordedAt,
    String? doctorName,
    String? hospitalName,
    List<String>? tags,
    bool? isFavorite,
  });

  /// Get a specific health record by ID
  Future<Either<Failure, HealthRecordEntity>> getHealthRecord(String recordId);

  /// Archive a health record
  Future<Either<Failure, HealthRecordEntity>> archiveHealthRecord(
      String recordId);

  /// Restore an archived health record
  Future<Either<Failure, HealthRecordEntity>> restoreHealthRecord(
      String recordId);

  /// Toggle favorite status of a health record
  Future<Either<Failure, HealthRecordEntity>> toggleFavorite(String recordId);

  /// Search health records
  Future<Either<Failure, List<HealthRecordEntity>>> searchHealthRecords(
      String query);

  /// Get health records by type
  Future<Either<Failure, List<HealthRecordEntity>>> getHealthRecordsByType(
      HealthRecordType type);

  /// Get favorite health records
  Future<Either<Failure, List<HealthRecordEntity>>> getFavoriteHealthRecords();

  /// Get archived health records
  Future<Either<Failure, List<HealthRecordEntity>>> getArchivedHealthRecords();
}
