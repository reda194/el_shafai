import 'package:dartz/dartz.dart';
import 'package:neurocare_app/core/errors/failures.dart';
import 'package:neurocare_app/features/location/domain/entities/location_entity.dart';

abstract class LocationRepository {
  /// Get current device location
  Future<Either<Failure, LocationEntity>> getCurrentLocation();

  /// Search for places by query
  Future<Either<Failure, List<PlaceEntity>>> searchPlaces(String query);

  /// Get place details by ID
  Future<Either<Failure, PlaceEntity>> getPlaceDetails(String placeId);

  /// Get nearby places (hospitals, clinics, pharmacies)
  Future<Either<Failure, List<PlaceEntity>>> getNearbyPlaces({
    required double latitude,
    required double longitude,
    double radius = 5000, // 5km default
    String? type, // hospital, clinic, pharmacy, etc.
  });

  /// Save user location
  Future<Either<Failure, LocationEntity>> saveLocation(LocationEntity location);

  /// Get saved locations
  Future<Either<Failure, List<LocationEntity>>> getSavedLocations();

  /// Delete saved location
  Future<Either<Failure, void>> deleteLocation(String locationId);
}
