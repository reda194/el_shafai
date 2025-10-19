import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/medication_entity.dart';

/// Repository interface for medications operations
abstract class MedicationsRepository {
  /// Get all medications for the current user
  Future<Either<Failure, List<MedicationEntity>>> getMedications({
    MedicationStatus? status,
    String? searchQuery,
  });

  /// Add a new medication
  Future<Either<Failure, MedicationEntity>> addMedication({
    required String name,
    required String genericName,
    required String description,
    required MedicationForm form,
    required MedicationStrength strength,
    required DosageUnit dosageUnit,
    required double dosageAmount,
    required MedicationFrequency frequency,
    required List<TimeOfDay> reminderTimes,
    required DateTime startDate,
    DateTime? endDate,
    String? prescribingDoctor,
    String? pharmacy,
    String? instructions,
    List<String>? sideEffects,
    List<String>? interactions,
    bool? requiresPrescription,
  });

  /// Update an existing medication
  Future<Either<Failure, MedicationEntity>> updateMedication({
    required String medicationId,
    String? name,
    String? genericName,
    String? description,
    MedicationForm? form,
    MedicationStrength? strength,
    DosageUnit? dosageUnit,
    double? dosageAmount,
    MedicationFrequency? frequency,
    List<TimeOfDay>? reminderTimes,
    DateTime? startDate,
    DateTime? endDate,
    String? prescribingDoctor,
    String? pharmacy,
    String? instructions,
    List<String>? sideEffects,
    List<String>? interactions,
    bool? requiresPrescription,
    MedicationStatus? status,
  });

  /// Delete a medication
  Future<Either<Failure, void>> deleteMedication(String medicationId);

  /// Get a specific medication by ID
  Future<Either<Failure, MedicationEntity>> getMedication(String medicationId);

  /// Pause a medication
  Future<Either<Failure, MedicationEntity>> pauseMedication(
      String medicationId);

  /// Resume a paused medication
  Future<Either<Failure, MedicationEntity>> resumeMedication(
      String medicationId);

  /// Mark medication as completed
  Future<Either<Failure, MedicationEntity>> completeMedication(
      String medicationId);

  /// Search medications
  Future<Either<Failure, List<MedicationEntity>>> searchMedications(
      String query);

  /// Get medications by status
  Future<Either<Failure, List<MedicationEntity>>> getMedicationsByStatus(
      MedicationStatus status);

  /// Get medications due for reminder
  Future<Either<Failure, List<MedicationEntity>>>
      getMedicationsDueForReminder();

  /// Get medications that need refill
  Future<Either<Failure, List<MedicationEntity>>> getMedicationsNeedingRefill();
}
