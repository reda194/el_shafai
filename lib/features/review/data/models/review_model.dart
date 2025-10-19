import 'package:neurocare_app/features/review/domain/entities/review_entity.dart';

class ReviewModel extends ReviewEntity {
  const ReviewModel({
    required super.id,
    required super.userId,
    required super.targetId,
    required super.reviewType,
    required super.rating,
    super.comment,
    super.tags,
    required super.createdAt,
    super.updatedAt,
    super.isAnonymous,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      targetId: json['target_id'] as String,
      reviewType: ReviewType.values.firstWhere(
        (type) => type.toString() == json['review_type'],
      ),
      rating: (json['rating'] as num).toDouble(),
      comment: json['comment'] as String?,
      tags: (json['tags'] as List<dynamic>?)?.cast<String>(),
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'] as String)
          : null,
      isAnonymous: json['is_anonymous'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'target_id': targetId,
      'review_type': reviewType.toString(),
      'rating': rating,
      'comment': comment,
      'tags': tags,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
      'is_anonymous': isAnonymous,
    };
  }

  factory ReviewModel.fromEntity(ReviewEntity entity) {
    return ReviewModel(
      id: entity.id,
      userId: entity.userId,
      targetId: entity.targetId,
      reviewType: entity.reviewType,
      rating: entity.rating,
      comment: entity.comment,
      tags: entity.tags,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
      isAnonymous: entity.isAnonymous,
    );
  }
}

class ReviewSummaryModel extends ReviewSummary {
  const ReviewSummaryModel({
    required super.targetId,
    required super.reviewType,
    required super.averageRating,
    required super.totalReviews,
    required super.ratingDistribution,
  });

  factory ReviewSummaryModel.fromJson(Map<String, dynamic> json) {
    return ReviewSummaryModel(
      targetId: json['target_id'] as String,
      reviewType: ReviewType.values.firstWhere(
        (type) => type.toString() == json['review_type'],
      ),
      averageRating: (json['average_rating'] as num).toDouble(),
      totalReviews: json['total_reviews'] as int,
      ratingDistribution:
          Map<int, int>.from(json['rating_distribution'] as Map),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'target_id': targetId,
      'review_type': reviewType.toString(),
      'average_rating': averageRating,
      'total_reviews': totalReviews,
      'rating_distribution': ratingDistribution,
    };
  }
}
