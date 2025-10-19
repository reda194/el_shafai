import 'package:dartz/dartz.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/doctor.dart';
import '../../domain/entities/price_range.dart';
import '../../domain/repositories/doctor_repository.dart';
import '../datasources/doctor_local_datasource.dart';
import '../datasources/doctor_remote_datasource.dart';

class DoctorRepositoryImpl implements DoctorRepository {
  final DoctorRemoteDataSource remoteDataSource;
  final DoctorLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  DoctorRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<Doctor>>> getDoctors({
    String? specialty,
    String? location,
    double? minRating,
    PriceRange? priceRange,
    String? sortBy,
  }) async {
    try {
      // Try to get from cache first if no filters are applied
      if (specialty == null &&
          location == null &&
          minRating == null &&
          priceRange == null &&
          sortBy == null) {
        final cachedDoctors = await localDataSource.getCachedDoctors();
        if (cachedDoctors != null && cachedDoctors.isNotEmpty) {
          return Right(cachedDoctors);
        }
      }

      // Fetch from remote if network available
      if (await networkInfo.isConnected) {
        final doctors = await remoteDataSource.getDoctors(
          specialty: specialty,
          location: location,
          minRating: minRating,
          priceRange: priceRange,
          sortBy: sortBy,
        );

        // Cache doctors if no filters applied
        if (specialty == null &&
            location == null &&
            minRating == null &&
            priceRange == null &&
            sortBy == null) {
          await localDataSource.cacheDoctors(doctors);
        }

        return Right(doctors);
      } else {
        return const Left(NetworkFailure('لا يوجد اتصال بالإنترنت'));
      }
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, Doctor>> getDoctorById(String doctorId) async {
    try {
      // Try to get from cache first
      final cachedDoctor =
          await localDataSource.getCachedDoctorDetails(doctorId);
      if (cachedDoctor != null) {
        return Right(cachedDoctor);
      }

      // Fetch from remote if network available
      if (await networkInfo.isConnected) {
        final doctor = await remoteDataSource.getDoctorById(doctorId);

        // Cache doctor details
        await localDataSource.cacheDoctorDetails(doctor);

        return Right(doctor);
      } else {
        return const Left(NetworkFailure('لا يوجد اتصال بالإنترنت'));
      }
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<Doctor>>> searchDoctors(String query) async {
    if (!await networkInfo.isConnected) {
      return const Left(NetworkFailure('لا يوجد اتصال بالإنترنت'));
    }

    try {
      final doctors = await remoteDataSource.searchDoctors(query);
      return Right(doctors);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<Doctor>>> getDoctorsBySpecialty(
      String specialty) async {
    try {
      // Try to get from cache first
      final cachedDoctors = await localDataSource.getCachedDoctors();
      if (cachedDoctors != null) {
        final filteredDoctors = cachedDoctors
            .where((doctor) =>
                doctor.specialty.contains(specialty) ||
                doctor.specializations.contains(specialty))
            .toList();
        if (filteredDoctors.isNotEmpty) {
          return Right(filteredDoctors);
        }
      }

      // Fetch from remote if network available
      if (await networkInfo.isConnected) {
        final doctors = await remoteDataSource.getDoctorsBySpecialty(specialty);
        return Right(doctors);
      } else {
        return const Left(NetworkFailure('لا يوجد اتصال بالإنترنت'));
      }
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<Doctor>>> getFavoriteDoctors() async {
    try {
      final favoriteIds = await localDataSource.getFavoriteDoctorIds();
      final favoriteDoctors = <Doctor>[];

      for (final doctorId in favoriteIds) {
        final doctorResult = await getDoctorById(doctorId);
        doctorResult.fold(
          (failure) => null, // Skip if doctor not found
          (doctor) => favoriteDoctors.add(doctor),
        );
      }

      return Right(favoriteDoctors);
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, void>> addToFavorites(String doctorId) async {
    try {
      await localDataSource.addToFavorites(doctorId);
      return const Right(null);
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, void>> removeFromFavorites(String doctorId) async {
    try {
      await localDataSource.removeFromFavorites(doctorId);
      return const Right(null);
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, bool>> isDoctorFavorite(String doctorId) async {
    try {
      final isFavorite = await localDataSource.isDoctorFavorite(doctorId);
      return Right(isFavorite);
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, Map<String, List<String>>>> getDoctorAvailability(
    String doctorId,
    DateTime date,
  ) async {
    if (!await networkInfo.isConnected) {
      return const Left(NetworkFailure('لا يوجد اتصال بالإنترنت'));
    }

    try {
      final availability =
          await remoteDataSource.getDoctorAvailability(doctorId, date);
      return Right(availability);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<Map<String, dynamic>>>> getDoctorReviews(
    String doctorId, {
    int limit = 10,
    int offset = 0,
  }) async {
    if (!await networkInfo.isConnected) {
      return const Left(NetworkFailure('لا يوجد اتصال بالإنترنت'));
    }

    try {
      final reviews = await remoteDataSource.getDoctorReviews(
        doctorId,
        limit: limit,
        offset: offset,
      );
      return Right(reviews);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, void>> submitReview({
    required String doctorId,
    required double rating,
    required String comment,
  }) async {
    if (!await networkInfo.isConnected) {
      return const Left(NetworkFailure('لا يوجد اتصال بالإنترنت'));
    }

    try {
      await remoteDataSource.submitReview(
        doctorId: doctorId,
        rating: rating,
        comment: comment,
      );
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }
}
