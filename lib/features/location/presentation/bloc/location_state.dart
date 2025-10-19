part of 'location_bloc.dart';

abstract class LocationState {}

class LocationInitial extends LocationState {}

class LocationLoading extends LocationState {}

class CurrentLocationLoaded extends LocationState {
  final LocationEntity location;

  CurrentLocationLoaded(this.location);
}

class PlacesSearched extends LocationState {
  final List<PlaceEntity> places;

  PlacesSearched(this.places);
}

class NearbyPlacesLoaded extends LocationState {
  final List<PlaceEntity> places;

  NearbyPlacesLoaded(this.places);
}

class LocationError extends LocationState {
  final String message;

  LocationError(this.message);
}
