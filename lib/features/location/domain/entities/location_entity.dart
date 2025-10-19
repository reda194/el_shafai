import 'package:equatable/equatable.dart';

class LocationEntity extends Equatable {
  final String id;
  final String name;
  final String address;
  final double latitude;
  final double longitude;
  final String? city;
  final String? country;
  final String? postalCode;

  const LocationEntity({
    required this.id,
    required this.name,
    required this.address,
    required this.latitude,
    required this.longitude,
    this.city,
    this.country,
    this.postalCode,
  });

  LocationEntity copyWith({
    String? id,
    String? name,
    String? address,
    double? latitude,
    double? longitude,
    String? city,
    String? country,
    String? postalCode,
  }) {
    return LocationEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      address: address ?? this.address,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      city: city ?? this.city,
      country: country ?? this.country,
      postalCode: postalCode ?? this.postalCode,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        address,
        latitude,
        longitude,
        city,
        country,
        postalCode,
      ];
}

class PlaceEntity extends Equatable {
  final String id;
  final String name;
  final String address;
  final double latitude;
  final double longitude;
  final String? description;
  final List<String>? categories;

  const PlaceEntity({
    required this.id,
    required this.name,
    required this.address,
    required this.latitude,
    required this.longitude,
    this.description,
    this.categories,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        address,
        latitude,
        longitude,
        description,
        categories,
      ];
}
