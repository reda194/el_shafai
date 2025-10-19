import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/medication_entity.dart';
import '../repositories/medications_repository.dart';

class GetMedicationsUseCase
    implements UseCase<List<MedicationEntity>, GetMedicationsParams> {
  final MedicationsRepository repository;

  GetMedicationsUseCase(this.repository);

  @override
  Future<Either<Failure, List<MedicationEntity>>> call(
      GetMedicationsParams params) {
    return repository.getMedications(
      status: params.status,
      searchQuery: params.searchQuery,
    );
  }
}

class GetMedicationsParams extends Equatable {
  final MedicationStatus? status;
  final String? searchQuery;

  const GetMedicationsParams({
    this.status,
    this.searchQuery,
  });

  @override
  List<Object?> get props => [status, searchQuery];
}
