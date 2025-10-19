import 'package:neurocare_app/features/location/data/models/location_model.dart';

abstract class LocationRemoteDataSource {
  /// Get current device location
  Future<LocationModel> getCurrentLocation();

  /// Search for places by query
  Future<List<PlaceModel>> searchPlaces(String query);

  /// Get place details by ID
  Future<PlaceModel> getPlaceDetails(String placeId);

  /// Get nearby places (hospitals, clinics, pharmacies)
  Future<List<PlaceModel>> getNearbyPlaces({
    required double latitude,
    required double longitude,
    double radius = 5000,
    String? type,
  });
}
