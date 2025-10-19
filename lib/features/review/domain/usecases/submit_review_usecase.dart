import 'package:dartz/dartz.dart';
import 'package:neurocare_app/core/errors/failures.dart';
import 'package:neurocare_app/core/usecases/usecase.dart';
import 'package:neurocare_app/features/review/domain/entities/review_entity.dart';
import 'package:neurocare_app/features/review/domain/repositories/review_repository.dart';

class SubmitReviewUseCase implements UseCase<ReviewEntity, ReviewEntity> {
  final ReviewRepository repository;

  SubmitReviewUseCase(this.repository);

  @override
  Future<Either<Failure, ReviewEntity>> call(ReviewEntity review) {
    return repository.submitReview(review);
  }
}
