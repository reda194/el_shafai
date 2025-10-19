import 'package:dartz/dartz.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/health_record_entity.dart';
import '../../domain/repositories/health_records_repository.dart';
import '../datasources/health_records_remote_datasource.dart';
import '../models/health_record_model.dart';

/// Implementation of HealthRecordsRepository
class HealthRecordsRepositoryImpl implements HealthRecordsRepository {
  final HealthRecordsRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  HealthRecordsRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<HealthRecordEntity>>> getHealthRecords({
    HealthRecordType? type,
    HealthRecordStatus? status,
    String? searchQuery,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    try {
      if (await networkInfo.isConnected) {
        final filters = HealthRecordFilters(
          type: type,
          status: status,
          searchQuery: searchQuery,
          startDate: startDate,
          endDate: endDate,
        );

        final models = await remoteDataSource.getHealthRecords(filters);
        final entities = models.map((model) => model.toEntity()).toList();
        return Right(entities);
      } else {
        return const Left(NetworkFailure('No internet connection'));
      }
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } on AuthenticationException catch (e) {
      return Left(AuthenticationFailure(e.message));
    } on AuthorizationException catch (e) {
      return Left(AuthorizationFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('Unexpected error: $e'));
    }
  }

  @override
  Future<Either<Failure, HealthRecordEntity>> uploadHealthRecord({
    required String title,
    required String description,
    required HealthRecordType type,
    required String filePath,
    DateTime? recordedAt,
    String? doctorName,
    String? hospitalName,
    List<String>? tags,
  }) async {
    try {
      if (await networkInfo.isConnected) {
        final request = UploadHealthRecordRequest(
          title: title,
          description: description,
          type: type.toString().split('.').last,
          filePath: filePath,
          recordedAt: recordedAt,
          doctorName: doctorName,
          hospitalName: hospitalName,
          tags: tags,
        );

        final model = await remoteDataSource.uploadHealthRecord(request);
        return Right(model.toEntity());
      } else {
        return const Left(NetworkFailure('No internet connection'));
      }
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } on ValidationException catch (e) {
      return Left(ValidationFailure(e.message));
    } on AuthenticationException catch (e) {
      return Left(AuthenticationFailure(e.message));
    } on AuthorizationException catch (e) {
      return Left(AuthorizationFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('Unexpected error: $e'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteHealthRecord(String recordId) async {
    try {
      if (await networkInfo.isConnected) {
        await remoteDataSource.deleteHealthRecord(recordId);
        return const Right(null);
      } else {
        return const Left(NetworkFailure('No internet connection'));
      }
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } on NotFoundException catch (e) {
      return Left(NotFoundFailure(e.message));
    } on AuthenticationException catch (e) {
      return Left(AuthenticationFailure(e.message));
    } on AuthorizationException catch (e) {
      return Left(AuthorizationFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('Unexpected error: $e'));
    }
  }

  @override
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
  }) async {
    try {
      if (await networkInfo.isConnected) {
        final updates = <String, dynamic>{};
        if (title != null) updates['title'] = title;
        if (description != null) updates['description'] = description;
        if (type != null) updates['type'] = type.toString().split('.').last;
        if (recordedAt != null) {
          updates['recorded_at'] = recordedAt.toIso8601String();
        }
        if (doctorName != null) updates['doctor_name'] = doctorName;
        if (hospitalName != null) updates['hospital_name'] = hospitalName;
        if (tags != null) updates['tags'] = tags;
        if (isFavorite != null) updates['is_favorite'] = isFavorite;

        final model =
            await remoteDataSource.updateHealthRecord(recordId, updates);
        return Right(model.toEntity());
      } else {
        return const Left(NetworkFailure('No internet connection'));
      }
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } on NotFoundException catch (e) {
      return Left(NotFoundFailure(e.message));
    } on ValidationException catch (e) {
      return Left(ValidationFailure(e.message));
    } on AuthenticationException catch (e) {
      return Left(AuthenticationFailure(e.message));
    } on AuthorizationException catch (e) {
      return Left(AuthorizationFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('Unexpected error: $e'));
    }
  }

  @override
  Future<Either<Failure, HealthRecordEntity>> getHealthRecord(
      String recordId) async {
    try {
      if (await networkInfo.isConnected) {
        final model = await remoteDataSource.getHealthRecord(recordId);
        return Right(model.toEntity());
      } else {
        return const Left(NetworkFailure('No internet connection'));
      }
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } on NotFoundException catch (e) {
      return Left(NotFoundFailure(e.message));
    } on AuthenticationException catch (e) {
      return Left(AuthenticationFailure(e.message));
    } on AuthorizationException catch (e) {
      return Left(AuthorizationFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('Unexpected error: $e'));
    }
  }

  @override
  Future<Either<Failure, HealthRecordEntity>> archiveHealthRecord(
      String recordId) async {
    return updateHealthRecord(
      recordId: recordId,
      // Note: This would typically be a separate endpoint for archiving
      // For now, we'll use update with status change
    );
  }

  @override
  Future<Either<Failure, HealthRecordEntity>> restoreHealthRecord(
      String recordId) async {
    return updateHealthRecord(
      recordId: recordId,
      // Note: This would typically be a separate endpoint for restoring
      // For now, we'll use update with status change
    );
  }

  @override
  Future<Either<Failure, HealthRecordEntity>> toggleFavorite(
      String recordId) async {
    // First get the current record to know the current favorite status
    final getResult = await getHealthRecord(recordId);
    return getResult.fold(
      (failure) => Left(failure),
      (record) async {
        final newFavoriteStatus = !record.isFavorite;
        return updateHealthRecord(
          recordId: recordId,
          isFavorite: newFavoriteStatus,
        );
      },
    );
  }

  @override
  Future<Either<Failure, List<HealthRecordEntity>>> searchHealthRecords(
      String query) async {
    return getHealthRecords(searchQuery: query);
  }

  @override
  Future<Either<Failure, List<HealthRecordEntity>>> getHealthRecordsByType(
      HealthRecordType type) async {
    return getHealthRecords(type: type);
  }

  @override
  Future<Either<Failure, List<HealthRecordEntity>>>
      getFavoriteHealthRecords() async {
    // This would typically filter by is_favorite = true on the server
    // For now, we'll get all and filter client-side
    final result = await getHealthRecords();
    return result.map(
        (records) => records.where((record) => record.isFavorite).toList());
  }

  @override
  Future<Either<Failure, List<HealthRecordEntity>>>
      getArchivedHealthRecords() async {
    return getHealthRecords(status: HealthRecordStatus.archived);
  }
}
