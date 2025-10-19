import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/doctor.dart';
import '../repositories/doctor_repository.dart';

class GetDoctorDetailsUseCase implements UseCase<Doctor, String> {
  final DoctorRepository repository;

  GetDoctorDetailsUseCase(this.repository);

  @override
  Future<Either<Failure, Doctor>> call(String doctorId) async {
    return await repository.getDoctorById(doctorId);
  }
}
