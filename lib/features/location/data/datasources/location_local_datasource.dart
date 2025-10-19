import 'package:neurocare_app/features/location/data/models/location_model.dart';

abstract class LocationLocalDataSource {
  /// Save user location
  Future<LocationModel> saveLocation(LocationModel location);

  /// Get saved locations
  Future<List<LocationModel>> getSavedLocations();

  /// Delete saved location
  Future<void> deleteLocation(String locationId);
}
