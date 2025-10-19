import 'package:equatable/equatable.dart';
import 'package:neurocare_app/features/appointment/domain/entities/appointment_entity.dart';

abstract class AppointmentState extends Equatable {
  const AppointmentState();

  @override
  List<Object> get props => [];
}

class AppointmentInitial extends AppointmentState {
  const AppointmentInitial();
}

class AppointmentLoading extends AppointmentState {
  const AppointmentLoading();
}

class AppointmentsLoaded extends AppointmentState {
  final List<AppointmentEntity> appointments;

  const AppointmentsLoaded(this.appointments);

  @override
  List<Object> get props => [appointments];
}

class AppointmentDetailsLoaded extends AppointmentState {
  final AppointmentEntity appointment;

  const AppointmentDetailsLoaded(this.appointment);

  @override
  List<Object> get props => [appointment];
}

class AppointmentBooked extends AppointmentState {
  final AppointmentEntity appointment;

  const AppointmentBooked(this.appointment);

  @override
  List<Object> get props => [appointment];
}

class AppointmentCancelled extends AppointmentState {
  const AppointmentCancelled();
}

class AppointmentRescheduled extends AppointmentState {
  final AppointmentEntity appointment;

  const AppointmentRescheduled(this.appointment);

  @override
  List<Object> get props => [appointment];
}

class AppointmentNotesUpdated extends AppointmentState {
  final AppointmentEntity appointment;

  const AppointmentNotesUpdated(this.appointment);

  @override
  List<Object> get props => [appointment];
}

class AvailableTimeSlotsLoaded extends AppointmentState {
  final List<String> timeSlots;

  const AvailableTimeSlotsLoaded(this.timeSlots);

  @override
  List<Object> get props => [timeSlots];
}

class TimeSlotAvailabilityChecked extends AppointmentState {
  final bool isAvailable;

  const TimeSlotAvailabilityChecked(this.isAvailable);

  @override
  List<Object> get props => [isAvailable];
}

class AppointmentError extends AppointmentState {
  final String message;

  const AppointmentError(this.message);

  @override
  List<Object> get props => [message];
}
