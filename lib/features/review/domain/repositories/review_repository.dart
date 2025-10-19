import 'package:dartz/dartz.dart';
import 'package:neurocare_app/core/errors/failures.dart';
import 'package:neurocare_app/features/review/domain/entities/review_entity.dart';

abstract class ReviewRepository {
  /// Submit a new review
  Future<Either<Failure, ReviewEntity>> submitReview(ReviewEntity review);

  /// Get reviews for a specific target (doctor, appointment, app)
  Future<Either<Failure, List<ReviewEntity>>> getReviews({
    required String targetId,
    required ReviewType reviewType,
    int limit = 20,
    int offset = 0,
  });

  /// Get review summary for a target
  Future<Either<Failure, ReviewSummary>> getReviewSummary({
    required String targetId,
    required ReviewType reviewType,
  });

  /// Update an existing review
  Future<Either<Failure, ReviewEntity>> updateReview(ReviewEntity review);

  /// Delete a review
  Future<Either<Failure, void>> deleteReview(String reviewId);

  /// Check if user has already reviewed a target
  Future<Either<Failure, bool>> hasUserReviewed({
    required String userId,
    required String targetId,
    required ReviewType reviewType,
  });
}
