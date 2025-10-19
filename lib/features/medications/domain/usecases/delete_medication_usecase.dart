import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/medications_repository.dart';

class DeleteMedicationUseCase implements UseCase<void, DeleteMedicationParams> {
  final MedicationsRepository repository;

  DeleteMedicationUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(DeleteMedicationParams params) {
    return repository.deleteMedication(params.medicationId);
  }
}

class DeleteMedicationParams extends Equatable {
  final String medicationId;

  const DeleteMedicationParams({required this.medicationId});

  @override
  List<Object> get props => [medicationId];
}
