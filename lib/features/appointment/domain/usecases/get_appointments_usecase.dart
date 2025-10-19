import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:neurocare_app/core/errors/failures.dart';
import 'package:neurocare_app/core/usecases/usecase.dart';
import 'package:neurocare_app/features/appointment/domain/entities/appointment_entity.dart';
import 'package:neurocare_app/features/appointment/domain/repositories/appointment_repository.dart';

class GetAppointmentsUseCase
    implements UseCase<List<AppointmentEntity>, GetAppointmentsParams> {
  final AppointmentRepository repository;

  GetAppointmentsUseCase(this.repository);

  @override
  Future<Either<Failure, List<AppointmentEntity>>> call(
      GetAppointmentsParams params) {
    return repository.getAppointments();
  }
}

class GetAppointmentsParams extends Equatable {
  const GetAppointmentsParams();

  @override
  List<Object?> get props => [];
}
