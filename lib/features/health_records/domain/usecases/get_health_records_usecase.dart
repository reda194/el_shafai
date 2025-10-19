import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/health_record_entity.dart';
import '../repositories/health_records_repository.dart';

class GetHealthRecordsUseCase
    implements UseCase<List<HealthRecordEntity>, GetHealthRecordsParams> {
  final HealthRecordsRepository repository;

  GetHealthRecordsUseCase(this.repository);

  @override
  Future<Either<Failure, List<HealthRecordEntity>>> call(
      GetHealthRecordsParams params) {
    return repository.getHealthRecords(
      type: params.type,
      status: params.status,
      searchQuery: params.searchQuery,
      startDate: params.startDate,
      endDate: params.endDate,
    );
  }
}

class GetHealthRecordsParams extends Equatable {
  final HealthRecordType? type;
  final HealthRecordStatus? status;
  final String? searchQuery;
  final DateTime? startDate;
  final DateTime? endDate;

  const GetHealthRecordsParams({
    this.type,
    this.status,
    this.searchQuery,
    this.startDate,
    this.endDate,
  });

  @override
  List<Object?> get props => [type, status, searchQuery, startDate, endDate];
}
