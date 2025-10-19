import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/doctor.dart';
import '../repositories/doctor_repository.dart';

class SearchDoctorsUseCase implements UseCase<List<Doctor>, String> {
  final DoctorRepository repository;

  SearchDoctorsUseCase(this.repository);

  @override
  Future<Either<Failure, List<Doctor>>> call(String query) async {
    return await repository.searchDoctors(query);
  }
}
