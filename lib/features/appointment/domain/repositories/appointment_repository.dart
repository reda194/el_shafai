import 'package:dartz/dartz.dart';
import 'package:neurocare_app/core/errors/failures.dart';
import 'package:neurocare_app/features/appointment/domain/entities/appointment_entity.dart';

abstract class AppointmentRepository {
  /// Get all appointments for the current user
  Future<Either<Failure, List<AppointmentEntity>>> getAppointments();

  /// Get upcoming appointments
  Future<Either<Failure, List<AppointmentEntity>>> getUpcomingAppointments();

  /// Get past appointments
  Future<Either<Failure, List<AppointmentEntity>>> getPastAppointments();

  /// Get appointment by ID
  Future<Either<Failure, AppointmentEntity>> getAppointmentById(
      String appointmentId);

  /// Book a new appointment
  Future<Either<Failure, AppointmentEntity>> bookAppointment({
    required String doctorId,
    required DateTime appointmentDate,
    required String timeSlot,
    required AppointmentType type,
    String? notes,
    bool? isVirtual,
  });

  /// Cancel an appointment
  Future<Either<Failure, void>> cancelAppointment(String appointmentId);

  /// Reschedule an appointment
  Future<Either<Failure, AppointmentEntity>> rescheduleAppointment({
    required String appointmentId,
    required DateTime newDate,
    required String newTimeSlot,
  });

  /// Update appointment notes
  Future<Either<Failure, AppointmentEntity>> updateAppointmentNotes({
    required String appointmentId,
    required String notes,
  });

  /// Get available time slots for a specific doctor and date
  Future<Either<Failure, List<String>>> getAvailableTimeSlots({
    required String doctorId,
    required DateTime date,
  });

  /// Check if a specific time slot is available
  Future<Either<Failure, bool>> isTimeSlotAvailable({
    required String doctorId,
    required DateTime date,
    required String timeSlot,
  });
}
