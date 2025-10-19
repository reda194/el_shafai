import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/doctor.dart';
import '../entities/price_range.dart';

abstract class DoctorRepository {
  /// Get all doctors with optional filtering
  Future<Either<Failure, List<Doctor>>> getDoctors({
    String? specialty,
    String? location,
    double? minRating,
    PriceRange? priceRange,
    String? sortBy,
  });

  /// Get doctor by ID
  Future<Either<Failure, Doctor>> getDoctorById(String doctorId);

  /// Search doctors by query
  Future<Either<Failure, List<Doctor>>> searchDoctors(String query);

  /// Get doctors by specialty
  Future<Either<Failure, List<Doctor>>> getDoctorsBySpecialty(String specialty);

  /// Get favorite doctors
  Future<Either<Failure, List<Doctor>>> getFavoriteDoctors();

  /// Add doctor to favorites
  Future<Either<Failure, void>> addToFavorites(String doctorId);

  /// Remove doctor from favorites
  Future<Either<Failure, void>> removeFromFavorites(String doctorId);

  /// Check if doctor is favorite
  Future<Either<Failure, bool>> isDoctorFavorite(String doctorId);

  /// Get doctor availability for specific date
  Future<Either<Failure, Map<String, List<String>>>> getDoctorAvailability(
    String doctorId,
    DateTime date,
  );

  /// Get doctor reviews
  Future<Either<Failure, List<Map<String, dynamic>>>> getDoctorReviews(
    String doctorId, {
    int limit = 10,
    int offset = 0,
  });

  /// Submit doctor review
  Future<Either<Failure, void>> submitReview({
    required String doctorId,
    required double rating,
    required String comment,
  });
}
