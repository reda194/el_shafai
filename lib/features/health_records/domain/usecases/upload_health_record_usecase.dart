import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/health_record_entity.dart';
import '../repositories/health_records_repository.dart';

class UploadHealthRecordUseCase
    implements UseCase<HealthRecordEntity, UploadHealthRecordParams> {
  final HealthRecordsRepository repository;

  UploadHealthRecordUseCase(this.repository);

  @override
  Future<Either<Failure, HealthRecordEntity>> call(
      UploadHealthRecordParams params) {
    return repository.uploadHealthRecord(
      title: params.title,
      description: params.description,
      type: params.type,
      filePath: params.filePath,
      recordedAt: params.recordedAt,
      doctorName: params.doctorName,
      hospitalName: params.hospitalName,
      tags: params.tags,
    );
  }
}

class UploadHealthRecordParams extends Equatable {
  final String title;
  final String description;
  final HealthRecordType type;
  final String filePath;
  final DateTime? recordedAt;
  final String? doctorName;
  final String? hospitalName;
  final List<String>? tags;

  const UploadHealthRecordParams({
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
