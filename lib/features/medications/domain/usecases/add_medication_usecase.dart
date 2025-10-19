import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/medication_entity.dart';
import '../repositories/medications_repository.dart';

class AddMedicationUseCase
    implements UseCase<MedicationEntity, AddMedicationParams> {
  final MedicationsRepository repository;

  AddMedicationUseCase(this.repository);

  @override
  Future<Either<Failure, MedicationEntity>> call(AddMedicationParams params) {
    return repository.addMedication(
      name: params.name,
      genericName: params.genericName,
      description: params.description,
      form: params.form,
      strength: params.strength,
      dosageUnit: params.dosageUnit,
      dosageAmount: params.dosageAmount,
      frequency: params.frequency,
      reminderTimes: params.reminderTimes,
      startDate: params.startDate,
      endDate: params.endDate,
      prescribingDoctor: params.prescribingDoctor,
      pharmacy: params.pharmacy,
      instructions: params.instructions,
      sideEffects: params.sideEffects,
      interactions: params.interactions,
      requiresPrescription: params.requiresPrescription,
    );
  }
}

class AddMedicationParams extends Equatable {
  final String name;
  final String genericName;
  final String description;
  final MedicationForm form;
  final MedicationStrength strength;
  final DosageUnit dosageUnit;
  final double dosageAmount;
  final MedicationFrequency frequency;
  final List<TimeOfDay> reminderTimes;
  final DateTime startDate;
  final DateTime? endDate;
  final String? prescribingDoctor;
  final String? pharmacy;
  final String? instructions;
  final List<String>? sideEffects;
  final List<String>? interactions;
  final bool? requiresPrescription;

  const AddMedicationParams({
    required this.name,
    required this.genericName,
    required this.description,
    required this.form,
    required this.strength,
    required this.dosageUnit,
    required this.dosageAmount,
    required this.frequency,
    required this.reminderTimes,
    required this.startDate,
    this.endDate,
    this.prescribingDoctor,
    this.pharmacy,
    this.instructions,
    this.sideEffects,
    this.interactions,
    this.requiresPrescription,
  });

  @override
  List<Object?> get props => [
        name,
        genericName,
        description,
        form,
        strength,
        dosageUnit,
        dosageAmount,
        frequency,
        reminderTimes,
        startDate,
        endDate,
        prescribingDoctor,
        pharmacy,
        instructions,
        sideEffects,
        interactions,
        requiresPrescription,
      ];
}
