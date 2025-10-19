import 'package:equatable/equatable.dart';
import 'package:neurocare_app/features/appointment/domain/entities/appointment_entity.dart';

abstract class AppointmentEvent extends Equatable {
  const AppointmentEvent();

  @override
  List<Object> get props => [];
}

class LoadAppointments extends AppointmentEvent {
  const LoadAppointments();
}

class LoadUpcomingAppointments extends AppointmentEvent {
  const LoadUpcomingAppointments();
}

class LoadPastAppointments extends AppointmentEvent {
  const LoadPastAppointments();
}

class LoadAppointmentDetails extends AppointmentEvent {
  final String appointmentId;

  const LoadAppointmentDetails(this.appointmentId);

  @override
  List<Object> get props => [appointmentId];
}

class BookAppointment extends AppointmentEvent {
  final String doctorId;
  final DateTime appointmentDate;
  final String timeSlot;
  final AppointmentType type;
  final String? notes;
  final bool? isVirtual;

  const BookAppointment({
    required this.doctorId,
    required this.appointmentDate,
    required this.timeSlot,
    required this.type,
    this.notes,
    this.isVirtual,
  });

  @override
  List<Object> get props => [
        doctorId,
        appointmentDate,
        timeSlot,
        type,
        notes ?? '',
        isVirtual ?? false,
      ];
}

class CancelAppointment extends AppointmentEvent {
  final String appointmentId;

  const CancelAppointment(this.appointmentId);

  @override
  List<Object> get props => [appointmentId];
}

class RescheduleAppointment extends AppointmentEvent {
  final String appointmentId;
  final DateTime newDate;
  final String newTimeSlot;

  const RescheduleAppointment({
    required this.appointmentId,
    required this.newDate,
    required this.newTimeSlot,
  });

  @override
  List<Object> get props => [appointmentId, newDate, newTimeSlot];
}

class UpdateAppointmentNotes extends AppointmentEvent {
  final String appointmentId;
  final String notes;

  const UpdateAppointmentNotes({
    required this.appointmentId,
    required this.notes,
  });

  @override
  List<Object> get props => [appointmentId, notes];
}

class LoadAvailableTimeSlots extends AppointmentEvent {
  final String doctorId;
  final DateTime date;

  const LoadAvailableTimeSlots({
    required this.doctorId,
    required this.date,
  });

  @override
  List<Object> get props => [doctorId, date];
}

class CheckTimeSlotAvailability extends AppointmentEvent {
  final String doctorId;
  final DateTime date;
  final String timeSlot;

  const CheckTimeSlotAvailability({
    required this.doctorId,
    required this.date,
    required this.timeSlot,
  });

  @override
  List<Object> get props => [doctorId, date, timeSlot];
}
