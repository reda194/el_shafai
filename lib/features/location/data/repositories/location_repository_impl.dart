import 'package:dartz/dartz.dart';
import 'package:neurocare_app/core/errors/exceptions.dart';
import 'package:neurocare_app/core/errors/failures.dart';
import 'package:neurocare_app/core/network/network_info.dart';
import 'package:neurocare_app/features/location/data/datasources/location_local_datasource.dart';
import 'package:neurocare_app/features/location/data/datasources/location_remote_datasource.dart';
import 'package:neurocare_app/features/location/data/models/location_model.dart';
import 'package:neurocare_app/features/location/domain/entities/location_entity.dart';
import 'package:neurocare_app/features/location/domain/repositories/location_repository.dart';

class LocationRepositoryImpl implements LocationRepository {
  final LocationRemoteDataSource remoteDataSource;
  final LocationLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  LocationRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, LocationEntity>> getCurrentLocation() async {
    try {
      final locationModel = await remoteDataSource.getCurrentLocation();
      return Right(locationModel);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return const Left(ServerFailure('Failed to get current location'));
    }
  }

  @override
  Future<Either<Failure, List<PlaceEntity>>> searchPlaces(String query) async {
    if (await networkInfo.isConnected) {
      try {
        final places = await remoteDataSource.searchPlaces(query);
        return Right(places);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      }
    } else {
      return const Left(NetworkFailure('No internet connection'));
    }
  }

  @override
  Future<Either<Failure, PlaceEntity>> getPlaceDetails(String placeId) async {
    if (await networkInfo.isConnected) {
      try {
        final place = await remoteDataSource.getPlaceDetails(placeId);
        return Right(place);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      }
    } else {
      return const Left(NetworkFailure('No internet connection'));
    }
  }

  @override
  Future<Either<Failure, List<PlaceEntity>>> getNearbyPlaces({
    required double latitude,
    required double longitude,
    double radius = 5000,
    String? type,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final places = await remoteDataSource.getNearbyPlaces(
          latitude: latitude,
          longitude: longitude,
          radius: radius,
          type: type,
        );
        return Right(places);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      }
    } else {
      return const Left(NetworkFailure('No internet connection'));
    }
  }

  @override
  Future<Either<Failure, LocationEntity>> saveLocation(
      LocationEntity location) async {
    try {
      final locationModel = await localDataSource.saveLocation(
        LocationModel.fromEntity(location),
      );
      return Right(locationModel);
    } catch (e) {
      return const Left(CacheFailure('Cache operation failed'));
    }
  }

  @override
  Future<Either<Failure, List<LocationEntity>>> getSavedLocations() async {
    try {
      final locations = await localDataSource.getSavedLocations();
      return Right(locations);
    } catch (e) {
      return const Left(CacheFailure('Cache operation failed'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteLocation(String locationId) async {
    try {
      await localDataSource.deleteLocation(locationId);
      return const Right(null);
    } catch (e) {
      return const Left(CacheFailure('Cache operation failed'));
    }
  }
}
