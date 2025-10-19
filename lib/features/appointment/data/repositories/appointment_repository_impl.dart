import 'package:dartz/dartz.dart';
import 'package:neurocare_app/core/errors/exceptions.dart';
import 'package:neurocare_app/core/errors/failures.dart';
import 'package:neurocare_app/features/appointment/data/datasources/appointment_remote_datasource.dart';
import 'package:neurocare_app/features/appointment/domain/entities/appointment_entity.dart';
import 'package:neurocare_app/features/appointment/domain/repositories/appointment_repository.dart';

class AppointmentRepositoryImpl implements AppointmentRepository {
  final AppointmentRemoteDataSource remoteDataSource;

  AppointmentRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<AppointmentEntity>>> getAppointments() async {
    try {
      final appointments = await remoteDataSource.getAppointments();
      return Right(appointments);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } catch (e) {
      return const Left(ServerFailure('Unexpected error occurred'));
    }
  }

  @override
  Future<Either<Failure, List<AppointmentEntity>>>
      getUpcomingAppointments() async {
    try {
      final appointments = await remoteDataSource.getUpcomingAppointments();
      return Right(appointments);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } catch (e) {
      return const Left(ServerFailure('Unexpected error occurred'));
    }
  }

  @override
  Future<Either<Failure, List<AppointmentEntity>>> getPastAppointments() async {
    try {
      final appointments = await remoteDataSource.getPastAppointments();
      return Right(appointments);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } catch (e) {
      return const Left(ServerFailure('Unexpected error occurred'));
    }
  }

  @override
  Future<Either<Failure, AppointmentEntity>> getAppointmentById(
      String appointmentId) async {
    try {
      final appointment =
          await remoteDataSource.getAppointmentById(appointmentId);
      return Right(appointment);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on NotFoundException catch (e) {
      return Left(NotFoundFailure(e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } catch (e) {
      return const Left(ServerFailure('Unexpected error occurred'));
    }
  }

  @override
  Future<Either<Failure, AppointmentEntity>> bookAppointment({
    required String doctorId,
    required DateTime appointmentDate,
    required String timeSlot,
    required AppointmentType type,
    String? notes,
    bool? isVirtual,
  }) async {
    try {
      final appointment = await remoteDataSource.bookAppointment(
        doctorId: doctorId,
        appointmentDate: appointmentDate,
        timeSlot: timeSlot,
        type: type.toString().split('.').last,
        notes: notes,
        isVirtual: isVirtual,
      );
      return Right(appointment);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on ConflictException catch (e) {
      return Left(ConflictFailure(e.message));
    } on ValidationException catch (e) {
      return Left(ValidationFailure(e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } catch (e) {
      return const Left(ServerFailure('Unexpected error occurred'));
    }
  }

  @override
  Future<Either<Failure, void>> cancelAppointment(String appointmentId) async {
    try {
      await remoteDataSource.cancelAppointment(appointmentId);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on NotFoundException catch (e) {
      return Left(NotFoundFailure(e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } catch (e) {
      return const Left(ServerFailure('Unexpected error occurred'));
    }
  }

  @override
  Future<Either<Failure, AppointmentEntity>> rescheduleAppointment({
    required String appointmentId,
    required DateTime newDate,
    required String newTimeSlot,
  }) async {
    try {
      final appointment = await remoteDataSource.rescheduleAppointment(
        appointmentId: appointmentId,
        newDate: newDate,
        newTimeSlot: newTimeSlot,
      );
      return Right(appointment);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on NotFoundException catch (e) {
      return Left(NotFoundFailure(e.message));
    } on ConflictException catch (e) {
      return Left(ConflictFailure(e.message));
    } on ValidationException catch (e) {
      return Left(ValidationFailure(e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } catch (e) {
      return const Left(ServerFailure('Unexpected error occurred'));
    }
  }

  @override
  Future<Either<Failure, AppointmentEntity>> updateAppointmentNotes({
    required String appointmentId,
    required String notes,
  }) async {
    try {
      final appointment = await remoteDataSource.updateAppointmentNotes(
        appointmentId: appointmentId,
        notes: notes,
      );
      return Right(appointment);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on NotFoundException catch (e) {
      return Left(NotFoundFailure(e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } catch (e) {
      return const Left(ServerFailure('Unexpected error occurred'));
    }
  }

  @override
  Future<Either<Failure, List<String>>> getAvailableTimeSlots({
    required String doctorId,
    required DateTime date,
  }) async {
    try {
      final timeSlots = await remoteDataSource.getAvailableTimeSlots(
        doctorId: doctorId,
        date: date,
      );
      return Right(timeSlots);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } catch (e) {
      return const Left(ServerFailure('Unexpected error occurred'));
    }
  }

  @override
  Future<Either<Failure, bool>> isTimeSlotAvailable({
    required String doctorId,
    required DateTime date,
    required String timeSlot,
  }) async {
    try {
      final isAvailable = await remoteDataSource.isTimeSlotAvailable(
        doctorId: doctorId,
        date: date,
        timeSlot: timeSlot,
      );
      return Right(isAvailable);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } catch (e) {
      return const Left(ServerFailure('Unexpected error occurred'));
    }
  }
}
