import 'package:dartz/dartz.dart';
import 'package:neurocare_app/core/errors/exceptions.dart';
import 'package:neurocare_app/core/errors/failures.dart';
import 'package:neurocare_app/core/network/network_info.dart';
import 'package:neurocare_app/features/review/data/datasources/review_remote_datasource.dart';
import 'package:neurocare_app/features/review/data/models/review_model.dart';
import 'package:neurocare_app/features/review/domain/entities/review_entity.dart';
import 'package:neurocare_app/features/review/domain/repositories/review_repository.dart';

class ReviewRepositoryImpl implements ReviewRepository {
  final ReviewRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  ReviewRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, ReviewEntity>> submitReview(
      ReviewEntity review) async {
    if (await networkInfo.isConnected) {
      try {
        final reviewModel = await remoteDataSource.submitReview(
          ReviewModel.fromEntity(review),
        );
        return Right(reviewModel);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      }
    } else {
      return const Left(NetworkFailure('No internet connection'));
    }
  }

  @override
  Future<Either<Failure, List<ReviewEntity>>> getReviews({
    required String targetId,
    required ReviewType reviewType,
    int limit = 20,
    int offset = 0,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final reviews = await remoteDataSource.getReviews(
          targetId: targetId,
          reviewType: reviewType,
          limit: limit,
          offset: offset,
        );
        return Right(reviews);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      }
    } else {
      return const Left(NetworkFailure('No internet connection'));
    }
  }

  @override
  Future<Either<Failure, ReviewSummary>> getReviewSummary({
    required String targetId,
    required ReviewType reviewType,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final summary = await remoteDataSource.getReviewSummary(
          targetId: targetId,
          reviewType: reviewType,
        );
        return Right(summary);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      }
    } else {
      return const Left(NetworkFailure('No internet connection'));
    }
  }

  @override
  Future<Either<Failure, ReviewEntity>> updateReview(
      ReviewEntity review) async {
    if (await networkInfo.isConnected) {
      try {
        final reviewModel = await remoteDataSource.updateReview(
          ReviewModel.fromEntity(review),
        );
        return Right(reviewModel);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      }
    } else {
      return const Left(NetworkFailure('No internet connection'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteReview(String reviewId) async {
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.deleteReview(reviewId);
        return const Right(null);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      }
    } else {
      return const Left(NetworkFailure('No internet connection'));
    }
  }

  @override
  Future<Either<Failure, bool>> hasUserReviewed({
    required String userId,
    required String targetId,
    required ReviewType reviewType,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final hasReviewed = await remoteDataSource.hasUserReviewed(
          userId: userId,
          targetId: targetId,
          reviewType: reviewType,
        );
        return Right(hasReviewed);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      }
    } else {
      return const Left(NetworkFailure('No internet connection'));
    }
  }
}
