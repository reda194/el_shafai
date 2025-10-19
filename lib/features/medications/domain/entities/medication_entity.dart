import 'package:equatable/equatable.dart';

/// Medication entity representing a prescribed medication
class MedicationEntity extends Equatable {
  final String id;
  final String userId;
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
  final bool requiresPrescription;
  final MedicationStatus status;
  final DateTime createdAt;
  final DateTime updatedAt;

  const MedicationEntity({
    required this.id,
    required this.userId,
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
    this.requiresPrescription = false,
    this.status = MedicationStatus.active,
    required this.createdAt,
    required this.updatedAt,
  });

  /// Create a copy of this entity with modified fields
  MedicationEntity copyWith({
    String? id,
    String? userId,
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
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return MedicationEntity(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      name: name ?? this.name,
      genericName: genericName ?? this.genericName,
      description: description ?? this.description,
      form: form ?? this.form,
      strength: strength ?? this.strength,
      dosageUnit: dosageUnit ?? this.dosageUnit,
      dosageAmount: dosageAmount ?? this.dosageAmount,
      frequency: frequency ?? this.frequency,
      reminderTimes: reminderTimes ?? this.reminderTimes,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      prescribingDoctor: prescribingDoctor ?? this.prescribingDoctor,
      pharmacy: pharmacy ?? this.pharmacy,
      instructions: instructions ?? this.instructions,
      sideEffects: sideEffects ?? this.sideEffects,
      interactions: interactions ?? this.interactions,
      requiresPrescription: requiresPrescription ?? this.requiresPrescription,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  /// Check if medication is currently active
  bool get isActive => status == MedicationStatus.active;

  /// Check if medication is completed
  bool get isCompleted => status == MedicationStatus.completed;

  /// Check if medication is paused
  bool get isPaused => status == MedicationStatus.paused;

  /// Check if medication has ended
  bool get hasEnded {
    if (endDate == null) return false;
    return DateTime.now().isAfter(endDate!);
  }

  /// Get formatted dosage string
  String get formattedDosage {
    return '${dosageAmount.toStringAsFixed(dosageAmount % 1 == 0 ? 0 : 1)} ${dosageUnit.displayName}';
  }

  /// Get formatted frequency string
  String get formattedFrequency {
    switch (frequency) {
      case MedicationFrequency.onceDaily:
        return 'Once daily';
      case MedicationFrequency.twiceDaily:
        return 'Twice daily';
      case MedicationFrequency.thriceDaily:
        return 'Thrice daily';
      case MedicationFrequency.fourTimesDaily:
        return 'Four times daily';
      case MedicationFrequency.asNeeded:
        return 'As needed';
      case MedicationFrequency.custom:
        return '${reminderTimes.length} times daily';
    }
  }

  /// Get next reminder time
  TimeOfDay? getNextReminder() {
    if (reminderTimes.isEmpty || !isActive || hasEnded) return null;

    final now = DateTime.now();
    final currentTime = TimeOfDay(hour: now.hour, minute: now.minute);

    // Find the next reminder time today
    for (final reminderTime in reminderTimes) {
      if (reminderTime.hour > currentTime.hour ||
          (reminderTime.hour == currentTime.hour &&
              reminderTime.minute > currentTime.minute)) {
        return reminderTime;
      }
    }

    // If no more reminders today, return the first one for tomorrow
    return reminderTimes.first;
  }

  /// Get all reminder times for today
  List<TimeOfDay> getTodaysReminders() {
    if (!isActive || hasEnded) return [];
    return reminderTimes;
  }

  @override
  List<Object?> get props => [
        id,
        userId,
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
        status,
        createdAt,
        updatedAt,
      ];
}

/// Medication form (tablet, capsule, liquid, etc.)
enum MedicationForm {
  tablet,
  capsule,
  liquid,
  injection,
  topical,
  inhaler,
  suppository,
  patch,
  other,
}

/// Medication strength representation
class MedicationStrength {
  final double value;
  final DosageUnit unit;

  const MedicationStrength({
    required this.value,
    required this.unit,
  });

  String get formattedStrength {
    return '${value.toStringAsFixed(value % 1 == 0 ? 0 : 1)} ${unit.displayName}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is MedicationStrength &&
        other.value == value &&
        other.unit == unit;
  }

  @override
  int get hashCode => value.hashCode ^ unit.hashCode;

  @override
  String toString() => formattedStrength;
}

/// Dosage unit
enum DosageUnit {
  mg,
  mcg,
  g,
  ml,
  l,
  iu,
  units,
  percentage,
  other,
}

/// Medication frequency
enum MedicationFrequency {
  onceDaily,
  twiceDaily,
  thriceDaily,
  fourTimesDaily,
  asNeeded,
  custom,
}

/// Medication status
enum MedicationStatus {
  active,
  paused,
  completed,
  discontinued,
}

/// Time of day for reminders
class TimeOfDay {
  final int hour;
  final int minute;

  const TimeOfDay({
    required this.hour,
    required this.minute,
  });

  /// Create TimeOfDay from DateTime
  factory TimeOfDay.fromDateTime(DateTime dateTime) {
    return TimeOfDay(
      hour: dateTime.hour,
      minute: dateTime.minute,
    );
  }

  /// Convert to formatted string (HH:MM)
  String get formattedTime {
    final hourStr = hour.toString().padLeft(2, '0');
    final minuteStr = minute.toString().padLeft(2, '0');
    return '$hourStr:$minuteStr';
  }

  /// Convert to 12-hour format
  String get formattedTime12Hour {
    final period = hour >= 12 ? 'PM' : 'AM';
    final displayHour = hour == 0 ? 12 : (hour > 12 ? hour - 12 : hour);
    final minuteStr = minute.toString().padLeft(2, '0');
    return '$displayHour:$minuteStr $period';
  }

  /// Compare with another TimeOfDay
  bool isBefore(TimeOfDay other) {
    if (hour != other.hour) return hour < other.hour;
    return minute < other.minute;
  }

  bool isAfter(TimeOfDay other) {
    if (hour != other.hour) return hour > other.hour;
    return minute > other.minute;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is TimeOfDay && other.hour == hour && other.minute == minute;
  }

  @override
  int get hashCode => hour.hashCode ^ minute.hashCode;

  @override
  String toString() => formattedTime;
}

/// Extension methods for enums
extension MedicationFormExtension on MedicationForm {
  String get displayName {
    switch (this) {
      case MedicationForm.tablet:
        return 'Tablet';
      case MedicationForm.capsule:
        return 'Capsule';
      case MedicationForm.liquid:
        return 'Liquid';
      case MedicationForm.injection:
        return 'Injection';
      case MedicationForm.topical:
        return 'Topical';
      case MedicationForm.inhaler:
        return 'Inhaler';
      case MedicationForm.suppository:
        return 'Suppository';
      case MedicationForm.patch:
        return 'Patch';
      case MedicationForm.other:
        return 'Other';
    }
  }
}

extension DosageUnitExtension on DosageUnit {
  String get displayName {
    switch (this) {
      case DosageUnit.mg:
        return 'mg';
      case DosageUnit.mcg:
        return 'mcg';
      case DosageUnit.g:
        return 'g';
      case DosageUnit.ml:
        return 'ml';
      case DosageUnit.l:
        return 'L';
      case DosageUnit.iu:
        return 'IU';
      case DosageUnit.units:
        return 'units';
      case DosageUnit.percentage:
        return '%';
      case DosageUnit.other:
        return '';
    }
  }
}

extension MedicationFrequencyExtension on MedicationFrequency {
  String get displayName {
    switch (this) {
      case MedicationFrequency.onceDaily:
        return 'Once daily';
      case MedicationFrequency.twiceDaily:
        return 'Twice daily';
      case MedicationFrequency.thriceDaily:
        return 'Thrice daily';
      case MedicationFrequency.fourTimesDaily:
        return 'Four times daily';
      case MedicationFrequency.asNeeded:
        return 'As needed';
      case MedicationFrequency.custom:
        return 'Custom';
    }
  }

  int get timesPerDay {
    switch (this) {
      case MedicationFrequency.onceDaily:
        return 1;
      case MedicationFrequency.twiceDaily:
        return 2;
      case MedicationFrequency.thriceDaily:
        return 3;
      case MedicationFrequency.fourTimesDaily:
        return 4;
      case MedicationFrequency.asNeeded:
        return 0;
      case MedicationFrequency.custom:
        return 0; // Determined by reminderTimes
    }
  }
}

extension MedicationStatusExtension on MedicationStatus {
  String get displayName {
    switch (this) {
      case MedicationStatus.active:
        return 'Active';
      case MedicationStatus.paused:
        return 'Paused';
      case MedicationStatus.completed:
        return 'Completed';
      case MedicationStatus.discontinued:
        return 'Discontinued';
    }
  }

  bool get isActive => this == MedicationStatus.active;
  bool get isInactive => !isActive;
}
