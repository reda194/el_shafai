import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:neurocare_app/core/errors/failures.dart';
import 'package:neurocare_app/core/usecases/usecase.dart';
import 'package:neurocare_app/features/appointment/domain/entities/appointment_entity.dart';
import 'package:neurocare_app/features/appointment/domain/repositories/appointment_repository.dart';

class BookAppointmentUseCase
    implements UseCase<AppointmentEntity, BookAppointmentParams> {
  final AppointmentRepository repository;

  BookAppointmentUseCase(this.repository);

  @override
  Future<Either<Failure, AppointmentEntity>> call(
      BookAppointmentParams params) {
    return repository.bookAppointment(
      doctorId: params.doctorId,
      appointmentDate: params.appointmentDate,
      timeSlot: params.timeSlot,
      type: params.type,
      notes: params.notes,
      isVirtual: params.isVirtual,
    );
  }
}

class BookAppointmentParams extends Equatable {
  final String doctorId;
  final DateTime appointmentDate;
  final String timeSlot;
  final AppointmentType type;
  final String? notes;
  final bool? isVirtual;

  const BookAppointmentParams({
    required this.doctorId,
    required this.appointmentDate,
    required this.timeSlot,
    required this.type,
    this.notes,
    this.isVirtual,
  });

  @override
  List<Object?> get props =>
      [doctorId, appointmentDate, timeSlot, type, notes, isVirtual];
}
