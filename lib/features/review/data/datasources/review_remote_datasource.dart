import 'package:neurocare_app/features/review/data/models/review_model.dart';
import 'package:neurocare_app/features/review/domain/entities/review_entity.dart';

abstract class ReviewRemoteDataSource {
  /// Submit a new review
  Future<ReviewModel> submitReview(ReviewModel review);

  /// Get reviews for a specific target
  Future<List<ReviewModel>> getReviews({
    required String targetId,
    required ReviewType reviewType,
    int limit = 20,
    int offset = 0,
  });

  /// Get review summary for a target
  Future<ReviewSummaryModel> getReviewSummary({
    required String targetId,
    required ReviewType reviewType,
  });

  /// Update an existing review
  Future<ReviewModel> updateReview(ReviewModel review);

  /// Delete a review
  Future<void> deleteReview(String reviewId);

  /// Check if user has already reviewed a target
  Future<bool> hasUserReviewed({
    required String userId,
    required String targetId,
    required ReviewType reviewType,
  });
}
