import 'package:dartz/dartz.dart';
import 'package:neurocare_app/core/errors/failures.dart';
import 'package:neurocare_app/core/usecases/usecase.dart';
import 'package:neurocare_app/features/location/domain/entities/location_entity.dart';
import 'package:neurocare_app/features/location/domain/repositories/location_repository.dart';

class GetNearbyPlacesUseCase
    implements UseCase<List<PlaceEntity>, GetNearbyPlacesParams> {
  final LocationRepository repository;

  GetNearbyPlacesUseCase(this.repository);

  @override
  Future<Either<Failure, List<PlaceEntity>>> call(
      GetNearbyPlacesParams params) {
    return repository.getNearbyPlaces(
      latitude: params.latitude,
      longitude: params.longitude,
      radius: params.radius,
      type: params.type,
    );
  }
}

class GetNearbyPlacesParams {
  final double latitude;
  final double longitude;
  final double radius;
  final String? type;

  const GetNearbyPlacesParams({
    required this.latitude,
    required this.longitude,
    this.radius = 5000,
    this.type,
  });
}
