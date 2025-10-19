import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/doctor.dart';
import '../entities/price_range.dart';
import '../repositories/doctor_repository.dart';

class GetDoctorsUseCase implements UseCase<List<Doctor>, GetDoctorsParams> {
  final DoctorRepository repository;

  GetDoctorsUseCase(this.repository);

  @override
  Future<Either<Failure, List<Doctor>>> call(GetDoctorsParams params) async {
    return await repository.getDoctors(
      specialty: params.specialty,
      location: params.location,
      minRating: params.minRating,
      priceRange: params.priceRange,
      sortBy: params.sortBy,
    );
  }
}

class GetDoctorsParams {
  final String? specialty;
  final String? location;
  final double? minRating;
  final PriceRange? priceRange;
  final String? sortBy;

  const GetDoctorsParams({
    this.specialty,
    this.location,
    this.minRating,
    this.priceRange,
    this.sortBy,
  });
}
