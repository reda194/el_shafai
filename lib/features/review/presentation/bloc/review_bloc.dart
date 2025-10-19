import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neurocare_app/features/review/domain/entities/review_entity.dart';
import 'package:neurocare_app/features/review/domain/usecases/get_reviews_usecase.dart';
import 'package:neurocare_app/features/review/domain/usecases/submit_review_usecase.dart';

part 'review_event.dart';
part 'review_state.dart';

class ReviewBloc extends Bloc<ReviewEvent, ReviewState> {
  final SubmitReviewUseCase submitReview;
  final GetReviewsUseCase getReviews;

  ReviewBloc({
    required this.submitReview,
    required this.getReviews,
  }) : super(ReviewInitial()) {
    on<SubmitReview>(_onSubmitReview);
    on<LoadReviews>(_onLoadReviews);
  }

  Future<void> _onSubmitReview(
    SubmitReview event,
    Emitter<ReviewState> emit,
  ) async {
    emit(ReviewLoading());
    final result = await submitReview(event.review);

    result.fold(
      (failure) => emit(ReviewError(failure.message)),
      (review) => emit(ReviewSubmitted(review)),
    );
  }

  Future<void> _onLoadReviews(
    LoadReviews event,
    Emitter<ReviewState> emit,
  ) async {
    emit(ReviewLoading());
    final result = await getReviews(GetReviewsParams(
      targetId: event.targetId,
      reviewType: event.reviewType,
      limit: event.limit,
      offset: event.offset,
    ));

    result.fold(
      (failure) => emit(ReviewError(failure.message)),
      (reviews) => emit(ReviewsLoaded(reviews)),
    );
  }
}
