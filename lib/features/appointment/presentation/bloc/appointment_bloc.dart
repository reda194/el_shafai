import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neurocare_app/features/appointment/domain/usecases/book_appointment_usecase.dart';
import 'package:neurocare_app/features/appointment/domain/usecases/get_appointments_usecase.dart';
import 'package:neurocare_app/features/appointment/domain/usecases/get_available_time_slots_usecase.dart';
import 'package:neurocare_app/features/appointment/domain/usecases/get_upcoming_appointments_usecase.dart';
import 'package:neurocare_app/features/appointment/presentation/bloc/appointment_event.dart';
import 'package:neurocare_app/features/appointment/presentation/bloc/appointment_state.dart';

class AppointmentBloc extends Bloc<AppointmentEvent, AppointmentState> {
  final GetAppointmentsUseCase getAppointments;
  final GetUpcomingAppointmentsUseCase getUpcomingAppointments;
  final BookAppointmentUseCase bookAppointment;
  final GetAvailableTimeSlotsUseCase getAvailableTimeSlots;

  AppointmentBloc({
    required this.getAppointments,
    required this.getUpcomingAppointments,
    required this.bookAppointment,
    required this.getAvailableTimeSlots,
  }) : super(const AppointmentInitial()) {
    on<LoadAppointments>(_onLoadAppointments);
    on<LoadUpcomingAppointments>(_onLoadUpcomingAppointments);
    on<BookAppointment>(_onBookAppointment);
    on<LoadAvailableTimeSlots>(_onLoadAvailableTimeSlots);
  }

  Future<void> _onLoadAppointments(
    LoadAppointments event,
    Emitter<AppointmentState> emit,
  ) async {
    emit(const AppointmentLoading());
    final result = await getAppointments(const GetAppointmentsParams());
    result.fold(
      (failure) => emit(AppointmentError(failure.message)),
      (appointments) => emit(AppointmentsLoaded(appointments)),
    );
  }

  Future<void> _onLoadUpcomingAppointments(
    LoadUpcomingAppointments event,
    Emitter<AppointmentState> emit,
  ) async {
    emit(const AppointmentLoading());
    final result =
        await getUpcomingAppointments(const GetUpcomingAppointmentsParams());
    result.fold(
      (failure) => emit(AppointmentError(failure.message)),
      (appointments) => emit(AppointmentsLoaded(appointments)),
    );
  }

  Future<void> _onBookAppointment(
    BookAppointment event,
    Emitter<AppointmentState> emit,
  ) async {
    emit(const AppointmentLoading());
    final result = await bookAppointment(BookAppointmentParams(
      doctorId: event.doctorId,
      appointmentDate: event.appointmentDate,
      timeSlot: event.timeSlot,
      type: event.type,
      notes: event.notes,
      isVirtual: event.isVirtual,
    ));
    result.fold(
      (failure) => emit(AppointmentError(failure.message)),
      (appointment) => emit(AppointmentBooked(appointment)),
    );
  }

  Future<void> _onLoadAvailableTimeSlots(
    LoadAvailableTimeSlots event,
    Emitter<AppointmentState> emit,
  ) async {
    final result = await getAvailableTimeSlots(GetAvailableTimeSlotsParams(
      doctorId: event.doctorId,
      date: event.date,
    ));
    result.fold(
      (failure) => emit(AppointmentError(failure.message)),
      (timeSlots) => emit(AvailableTimeSlotsLoaded(timeSlots)),
    );
  }
}
