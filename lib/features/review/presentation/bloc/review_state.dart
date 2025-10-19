part of 'review_bloc.dart';

abstract class ReviewState {}

class ReviewInitial extends ReviewState {}

class ReviewLoading extends ReviewState {}

class ReviewSubmitted extends ReviewState {
  final ReviewEntity review;

  ReviewSubmitted(this.review);
}

class ReviewsLoaded extends ReviewState {
  final List<ReviewEntity> reviews;

  ReviewsLoaded(this.reviews);
}

class ReviewError extends ReviewState {
  final String message;

  ReviewError(this.message);
}
