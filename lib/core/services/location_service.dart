import 'dart:async';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:geocoding/geocoding.dart' as geocoding;

/// Location service for handling GPS and location-related functionality
class LocationService {
  static final LocationService _instance = LocationService._internal();
  factory LocationService() => _instance;
  LocationService._internal();

  StreamSubscription<Position>? _positionStreamSubscription;
  final StreamController<Position> _positionController =
      StreamController<Position>.broadcast();

  /// Stream of position updates
  Stream<Position> get positionStream => _positionController.stream;

  /// Check if location services are enabled
  Future<bool> isLocationServiceEnabled() async {
    return await Geolocator.isLocationServiceEnabled();
  }

  /// Request location permission
  Future<LocationPermission> requestPermission() async {
    // First check if location permission is already granted
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    // Handle permanently denied permission
    if (permission == LocationPermission.deniedForever) {
      // Open app settings
      await openAppSettings();
    }

    return permission;
  }

  /// Get current position
  Future<Position> getCurrentPosition({
    LocationAccuracy accuracy = LocationAccuracy.high,
    Duration? timeLimit,
  }) async {
    // Ensure location services are enabled
    final serviceEnabled = await isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw LocationServiceDisabledException();
    }

    // Request permission
    final permission = await requestPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      throw LocationPermissionDeniedException();
    }

    return await Geolocator.getCurrentPosition(
      desiredAccuracy: accuracy,
      timeLimit: timeLimit,
    );
  }

  /// Get last known position
  Future<Position?> getLastKnownPosition() async {
    try {
      return await Geolocator.getLastKnownPosition();
    } catch (e) {
      return null;
    }
  }

  /// Start listening to position updates
  Future<void> startPositionUpdates({
    LocationAccuracy accuracy = LocationAccuracy.high,
    int distanceFilter = 10,
    Duration interval = const Duration(seconds: 5),
  }) async {
    // Ensure location services are enabled
    final serviceEnabled = await isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw LocationServiceDisabledException();
    }

    // Request permission
    final permission = await requestPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      throw LocationPermissionDeniedException();
    }

    // Cancel existing subscription
    await stopPositionUpdates();

    // Start listening to position updates
    _positionStreamSubscription = Geolocator.getPositionStream(
      locationSettings: LocationSettings(
        accuracy: accuracy,
        distanceFilter: distanceFilter,
        timeLimit: interval,
      ),
    ).listen(
      (Position position) {
        _positionController.add(position);
      },
      onError: (error) {
        _positionController.addError(error);
      },
    );
  }

  /// Stop listening to position updates
  Future<void> stopPositionUpdates() async {
    await _positionStreamSubscription?.cancel();
    _positionStreamSubscription = null;
  }

  /// Calculate distance between two positions
  double calculateDistance(Position start, Position end) {
    return Geolocator.distanceBetween(
      start.latitude,
      start.longitude,
      end.latitude,
      end.longitude,
    );
  }

  /// Calculate distance in kilometers
  double calculateDistanceInKm(Position start, Position end) {
    return calculateDistance(start, end) / 1000;
  }

  /// Check if position is within radius of target position
  bool isWithinRadius(
      Position current, Position target, double radiusInMeters) {
    final distance = calculateDistance(current, target);
    return distance <= radiusInMeters;
  }

  /// Get address from coordinates (reverse geocoding)
  Future<String> getAddressFromCoordinates(
      double latitude, double longitude) async {
    try {
      final placemarks =
          await geocoding.placemarkFromCoordinates(latitude, longitude);
      if (placemarks.isNotEmpty) {
        final place = placemarks.first;
        final addressParts = [
          place.street,
          place.locality,
          place.administrativeArea,
          place.country,
        ].where((part) => part != null && part.isNotEmpty);

        return addressParts.join(', ');
      }
      return 'Unknown location';
    } catch (e) {
      return 'Unable to get address';
    }
  }

  /// Get coordinates from address (geocoding)
  Future<List<geocoding.Location>> getCoordinatesFromAddress(
      String address) async {
    try {
      return await geocoding.locationFromAddress(address);
    } catch (e) {
      return [];
    }
  }

  /// Format position for display
  String formatPosition(Position position) {
    return '${position.latitude.toStringAsFixed(6)}, ${position.longitude.toStringAsFixed(6)}';
  }

  /// Dispose resources
  void dispose() {
    stopPositionUpdates();
    _positionController.close();
  }
}

/// Custom exceptions for location service
class LocationServiceDisabledException implements Exception {
  @override
  String toString() => 'Location services are disabled';
}

class LocationPermissionDeniedException implements Exception {
  @override
  String toString() => 'Location permission denied';
}
