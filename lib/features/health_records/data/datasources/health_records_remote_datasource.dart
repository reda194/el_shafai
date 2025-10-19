import 'dart:io';
import 'package:dio/dio.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/network/api_client.dart';
import '../../../../core/constants/api_constants.dart';
import '../models/health_record_model.dart';

/// Remote data source for health records operations
abstract class HealthRecordsRemoteDataSource {
  /// Get all health records
  Future<List<HealthRecordModel>> getHealthRecords(HealthRecordFilters filters);

  /// Upload a health record
  Future<HealthRecordModel> uploadHealthRecord(
      UploadHealthRecordRequest request);

  /// Delete a health record
  Future<void> deleteHealthRecord(String recordId);

  /// Update a health record
  Future<HealthRecordModel> updateHealthRecord(
      String recordId, Map<String, dynamic> updates);

  /// Get a specific health record
  Future<HealthRecordModel> getHealthRecord(String recordId);
}

/// Implementation of health records remote data source
class HealthRecordsRemoteDataSourceImpl
    implements HealthRecordsRemoteDataSource {
  final ApiClient apiClient;

  HealthRecordsRemoteDataSourceImpl({required this.apiClient});

  @override
  Future<List<HealthRecordModel>> getHealthRecords(
      HealthRecordFilters filters) async {
    try {
      final response = await apiClient.get(
        ApiConstants.getHealthRecords,
        queryParameters: filters.toQueryParams(),
      );

      if (response.statusCode == ApiConstants.ok) {
        final responseData = HealthRecordResponse.fromJson(response.data);
        return responseData.records;
      } else {
        throw ServerException('Failed to fetch health records');
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.sendTimeout) {
        throw NetworkException('Connection timeout');
      } else if (e.type == DioExceptionType.connectionError) {
        throw NetworkException('No internet connection');
      } else if (e.response?.statusCode == 401) {
        throw AuthenticationException('Unauthorized access');
      } else if (e.response?.statusCode == 403) {
        throw AuthorizationException('Access forbidden');
      } else {
        throw ServerException(e.message ?? 'Server error');
      }
    } catch (e) {
      throw ServerException('Unexpected error: $e');
    }
  }

  @override
  Future<HealthRecordModel> uploadHealthRecord(
      UploadHealthRecordRequest request) async {
    try {
      final file = File(request.filePath);
      if (!await file.exists()) {
        throw ValidationException('File does not exist');
      }

      final response = await apiClient.uploadFile(
        ApiConstants.uploadHealthRecord,
        request.filePath,
        data: request.toFormData(),
      );

      if (response.statusCode == ApiConstants.created) {
        return HealthRecordModel.fromUploadResponse(response.data);
      } else {
        throw ServerException('Failed to upload health record');
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.sendTimeout) {
        throw NetworkException('Connection timeout during upload');
      } else if (e.type == DioExceptionType.connectionError) {
        throw NetworkException('No internet connection');
      } else if (e.response?.statusCode == 401) {
        throw AuthenticationException('Unauthorized access');
      } else if (e.response?.statusCode == 403) {
        throw AuthorizationException('Access forbidden');
      } else if (e.response?.statusCode == 413) {
        throw ValidationException('File too large');
      } else if (e.response?.statusCode == 415) {
        throw ValidationException('Unsupported file type');
      } else {
        throw ServerException(e.message ?? 'Upload failed');
      }
    } catch (e) {
      if (e is ValidationException) {
        rethrow;
      }
      throw ServerException('Unexpected error during upload: $e');
    }
  }

  @override
  Future<void> deleteHealthRecord(String recordId) async {
    try {
      final response = await apiClient.delete(
        '${ApiConstants.getHealthRecords}/$recordId',
      );

      if (response.statusCode != ApiConstants.noContent &&
          response.statusCode != ApiConstants.ok) {
        throw ServerException('Failed to delete health record');
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.sendTimeout) {
        throw NetworkException('Connection timeout');
      } else if (e.type == DioExceptionType.connectionError) {
        throw NetworkException('No internet connection');
      } else if (e.response?.statusCode == 401) {
        throw AuthenticationException('Unauthorized access');
      } else if (e.response?.statusCode == 403) {
        throw AuthorizationException('Access forbidden');
      } else if (e.response?.statusCode == 404) {
        throw NotFoundException('Health record not found');
      } else {
        throw ServerException(e.message ?? 'Delete failed');
      }
    } catch (e) {
      throw ServerException('Unexpected error: $e');
    }
  }

  @override
  Future<HealthRecordModel> updateHealthRecord(
      String recordId, Map<String, dynamic> updates) async {
    try {
      final response = await apiClient.patch(
        '${ApiConstants.getHealthRecords}/$recordId',
        data: updates,
      );

      if (response.statusCode == ApiConstants.ok) {
        return HealthRecordModel.fromJson(response.data);
      } else {
        throw ServerException('Failed to update health record');
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.sendTimeout) {
        throw NetworkException('Connection timeout');
      } else if (e.type == DioExceptionType.connectionError) {
        throw NetworkException('No internet connection');
      } else if (e.response?.statusCode == 401) {
        throw AuthenticationException('Unauthorized access');
      } else if (e.response?.statusCode == 403) {
        throw AuthorizationException('Access forbidden');
      } else if (e.response?.statusCode == 404) {
        throw NotFoundException('Health record not found');
      } else if (e.response?.statusCode == 400) {
        throw ValidationException('Invalid update data');
      } else {
        throw ServerException(e.message ?? 'Update failed');
      }
    } catch (e) {
      throw ServerException('Unexpected error: $e');
    }
  }

  @override
  Future<HealthRecordModel> getHealthRecord(String recordId) async {
    try {
      final response = await apiClient.get(
        '${ApiConstants.getHealthRecords}/$recordId',
      );

      if (response.statusCode == ApiConstants.ok) {
        return HealthRecordModel.fromJson(response.data);
      } else {
        throw ServerException('Failed to fetch health record');
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.sendTimeout) {
        throw NetworkException('Connection timeout');
      } else if (e.type == DioExceptionType.connectionError) {
        throw NetworkException('No internet connection');
      } else if (e.response?.statusCode == 401) {
        throw AuthenticationException('Unauthorized access');
      } else if (e.response?.statusCode == 403) {
        throw AuthorizationException('Access forbidden');
      } else if (e.response?.statusCode == 404) {
        throw NotFoundException('Health record not found');
      } else {
        throw ServerException(e.message ?? 'Fetch failed');
      }
    } catch (e) {
      throw ServerException('Unexpected error: $e');
    }
  }
}
