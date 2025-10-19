import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:neurocare_app/core/errors/failures.dart';
import 'package:neurocare_app/core/usecases/usecase.dart';
import 'package:neurocare_app/features/appointment/domain/entities/appointment_entity.dart';
import 'package:neurocare_app/features/appointment/domain/repositories/appointment_repository.dart';

class GetUpcomingAppointmentsUseCase
    implements UseCase<List<AppointmentEntity>, GetUpcomingAppointmentsParams> {
  final AppointmentRepository repository;

  GetUpcomingAppointmentsUseCase(this.repository);

  @override
  Future<Either<Failure, List<AppointmentEntity>>> call(
      GetUpcomingAppointmentsParams params) {
    return repository.getUpcomingAppointments();
  }
}

class GetUpcomingAppointmentsParams extends Equatable {
  const GetUpcomingAppointmentsParams();

  @override
  List<Object?> get props => [];
}
