import 'package:dartz/dartz.dart';
import 'package:neurocare_app/core/errors/failures.dart';
import 'package:neurocare_app/core/usecases/usecase.dart';
import 'package:neurocare_app/features/location/domain/entities/location_entity.dart';
import 'package:neurocare_app/features/location/domain/repositories/location_repository.dart';

class GetCurrentLocationUseCase implements UseCase<LocationEntity, NoParams> {
  final LocationRepository repository;

  GetCurrentLocationUseCase(this.repository);

  @override
  Future<Either<Failure, LocationEntity>> call(NoParams params) {
    return repository.getCurrentLocation();
  }
}
