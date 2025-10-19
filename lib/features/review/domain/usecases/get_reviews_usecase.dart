import 'package:dartz/dartz.dart';
import 'package:neurocare_app/core/errors/failures.dart';
import 'package:neurocare_app/core/usecases/usecase.dart';
import 'package:neurocare_app/features/review/domain/entities/review_entity.dart';
import 'package:neurocare_app/features/review/domain/repositories/review_repository.dart';

class GetReviewsUseCase
    implements UseCase<List<ReviewEntity>, GetReviewsParams> {
  final ReviewRepository repository;

  GetReviewsUseCase(this.repository);

  @override
  Future<Either<Failure, List<ReviewEntity>>> call(GetReviewsParams params) {
    return repository.getReviews(
      targetId: params.targetId,
      reviewType: params.reviewType,
      limit: params.limit,
      offset: params.offset,
    );
  }
}

class GetReviewsParams {
  final String targetId;
  final ReviewType reviewType;
  final int limit;
  final int offset;

  const GetReviewsParams({
    required this.targetId,
    required this.reviewType,
    this.limit = 20,
    this.offset = 0,
  });
}
