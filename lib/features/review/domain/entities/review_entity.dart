import 'package:equatable/equatable.dart';

enum ReviewType { doctor, appointment, app }

class ReviewEntity extends Equatable {
  final String id;
  final String userId;
  final String targetId; // doctor_id, appointment_id, or 'app' for app reviews
  final ReviewType reviewType;
  final double rating; // 1.0 to 5.0
  final String? comment;
  final List<String>? tags; // helpful, professional, etc.
  final DateTime createdAt;
  final DateTime? updatedAt;
  final bool isAnonymous;

  const ReviewEntity({
    required this.id,
    required this.userId,
    required this.targetId,
    required this.reviewType,
    required this.rating,
    this.comment,
    this.tags,
    required this.createdAt,
    this.updatedAt,
    this.isAnonymous = false,
  });

  ReviewEntity copyWith({
    String? id,
    String? userId,
    String? targetId,
    ReviewType? reviewType,
    double? rating,
    String? comment,
    List<String>? tags,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? isAnonymous,
  }) {
    return ReviewEntity(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      targetId: targetId ?? this.targetId,
      reviewType: reviewType ?? this.reviewType,
      rating: rating ?? this.rating,
      comment: comment ?? this.comment,
      tags: tags ?? this.tags,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isAnonymous: isAnonymous ?? this.isAnonymous,
    );
  }

  @override
  List<Object?> get props => [
        id,
        userId,
        targetId,
        reviewType,
        rating,
        comment,
        tags,
        createdAt,
        updatedAt,
        isAnonymous,
      ];
}

class ReviewSummary extends Equatable {
  final String targetId;
  final ReviewType reviewType;
  final double averageRating;
  final int totalReviews;
  final Map<int, int> ratingDistribution; // 1-star count, 2-star count, etc.

  const ReviewSummary({
    required this.targetId,
    required this.reviewType,
    required this.averageRating,
    required this.totalReviews,
    required this.ratingDistribution,
  });

  @override
  List<Object> get props => [
        targetId,
        reviewType,
        averageRating,
        totalReviews,
        ratingDistribution,
      ];
}
