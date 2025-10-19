import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neurocare_app/core/usecases/usecase.dart';
import 'package:neurocare_app/features/location/domain/entities/location_entity.dart';
import 'package:neurocare_app/features/location/domain/usecases/get_current_location_usecase.dart';
import 'package:neurocare_app/features/location/domain/usecases/get_nearby_places_usecase.dart';
import 'package:neurocare_app/features/location/domain/usecases/search_places_usecase.dart';

part 'location_event.dart';
part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  final GetCurrentLocationUseCase getCurrentLocation;
  final SearchPlacesUseCase searchPlaces;
  final GetNearbyPlacesUseCase getNearbyPlaces;

  LocationBloc({
    required this.getCurrentLocation,
    required this.searchPlaces,
    required this.getNearbyPlaces,
  }) : super(LocationInitial()) {
    on<GetCurrentLocation>(_onGetCurrentLocation);
    on<SearchPlaces>(_onSearchPlaces);
    on<GetNearbyPlaces>(_onGetNearbyPlaces);
  }

  Future<void> _onGetCurrentLocation(
    GetCurrentLocation event,
    Emitter<LocationState> emit,
  ) async {
    emit(LocationLoading());
    final result = await getCurrentLocation(NoParams());

    result.fold(
      (failure) => emit(LocationError(failure.message)),
      (location) => emit(CurrentLocationLoaded(location)),
    );
  }

  Future<void> _onSearchPlaces(
    SearchPlaces event,
    Emitter<LocationState> emit,
  ) async {
    emit(LocationLoading());
    final result = await searchPlaces(SearchPlacesParams(query: event.query));

    result.fold(
      (failure) => emit(LocationError(failure.message)),
      (places) => emit(PlacesSearched(places)),
    );
  }

  Future<void> _onGetNearbyPlaces(
    GetNearbyPlaces event,
    Emitter<LocationState> emit,
  ) async {
    emit(LocationLoading());
    final result = await getNearbyPlaces(GetNearbyPlacesParams(
      latitude: event.latitude,
      longitude: event.longitude,
      radius: event.radius,
      type: event.type,
    ));

    result.fold(
      (failure) => emit(LocationError(failure.message)),
      (places) => emit(NearbyPlacesLoaded(places)),
    );
  }
}
