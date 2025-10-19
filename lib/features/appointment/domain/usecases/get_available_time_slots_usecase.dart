import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:neurocare_app/core/errors/failures.dart';
import 'package:neurocare_app/core/usecases/usecase.dart';
import 'package:neurocare_app/features/appointment/domain/repositories/appointment_repository.dart';

class GetAvailableTimeSlotsUseCase
    implements UseCase<List<String>, GetAvailableTimeSlotsParams> {
  final AppointmentRepository repository;

  GetAvailableTimeSlotsUseCase(this.repository);

  @override
  Future<Either<Failure, List<String>>> call(
      GetAvailableTimeSlotsParams params) {
    return repository.getAvailableTimeSlots(
      doctorId: params.doctorId,
      date: params.date,
    );
  }
}

class GetAvailableTimeSlotsParams extends Equatable {
  final String doctorId;
  final DateTime date;

  const GetAvailableTimeSlotsParams({
    required this.doctorId,
    required this.date,
  });

  @override
  List<Object?> get props => [doctorId, date];
}
