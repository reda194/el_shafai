part of 'location_bloc.dart';

abstract class LocationEvent {}

class GetCurrentLocation extends LocationEvent {}

class SearchPlaces extends LocationEvent {
  final String query;

  SearchPlaces(this.query);
}

class GetNearbyPlaces extends LocationEvent {
  final double latitude;
  final double longitude;
  final double radius;
  final String? type;

  GetNearbyPlaces({
    required this.latitude,
    required this.longitude,
    this.radius = 5000,
    this.type,
  });
}
