part of 'review_bloc.dart';

abstract class ReviewEvent {}

class SubmitReview extends ReviewEvent {
  final ReviewEntity review;

  SubmitReview(this.review);
}

class LoadReviews extends ReviewEvent {
  final String targetId;
  final ReviewType reviewType;
  final int limit;
  final int offset;

  LoadReviews({
    required this.targetId,
    required this.reviewType,
    this.limit = 20,
    this.offset = 0,
  });
}
