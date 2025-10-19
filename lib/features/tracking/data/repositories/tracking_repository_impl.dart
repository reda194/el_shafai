import 'package:dartz/dartz.dart';
import 'package:neurocare_app/core/errors/exceptions.dart';
import 'package:neurocare_app/core/errors/failures.dart';
import 'package:neurocare_app/core/network/network_info.dart';
import 'package:neurocare_app/features/tracking/data/datasources/tracking_remote_datasource.dart';
import 'package:neurocare_app/features/tracking/data/models/health_metric_model.dart';
import 'package:neurocare_app/features/tracking/domain/entities/health_metric_entity.dart';
import 'package:neurocare_app/features/tracking/domain/repositories/tracking_repository.dart';

class TrackingRepositoryImpl implements TrackingRepository {
  final TrackingRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  TrackingRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, HealthMetric>> addMetric(HealthMetric metric) async {
    if (await networkInfo.isConnected) {
      try {
        final metricModel = await remoteDataSource.addMetric(
          HealthMetricModel.fromEntity(metric),
        );
        return Right(metricModel);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      }
    } else {
      return const Left(NetworkFailure('No internet connection'));
    }
  }

  @override
  Future<Either<Failure, List<HealthMetric>>> getMetrics({
    required MetricType type,
    DateTime? startDate,
    DateTime? endDate,
    int limit = 50,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final metrics = await remoteDataSource.getMetrics(
          type: type,
          startDate: startDate,
          endDate: endDate,
          limit: limit,
        );
        return Right(metrics);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      }
    } else {
      return const Left(NetworkFailure('No internet connection'));
    }
  }

  @override
  Future<Either<Failure, List<MetricSummary>>> getMetricSummaries() async {
    if (await networkInfo.isConnected) {
      try {
        final summaries = await remoteDataSource.getMetricSummaries();
        return Right(summaries);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      }
    } else {
      return const Left(NetworkFailure('No internet connection'));
    }
  }

  @override
  Future<Either<Failure, MetricSummary>> getMetricSummary(
      MetricType type) async {
    if (await networkInfo.isConnected) {
      try {
        final summary = await remoteDataSource.getMetricSummary(type);
        return Right(summary);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      }
    } else {
      return const Left(NetworkFailure('No internet connection'));
    }
  }

  @override
  Future<Either<Failure, HealthMetric>> updateMetric(
      HealthMetric metric) async {
    if (await networkInfo.isConnected) {
      try {
        final metricModel = await remoteDataSource.updateMetric(
          HealthMetricModel.fromEntity(metric),
        );
        return Right(metricModel);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      }
    } else {
      return const Left(NetworkFailure('No internet connection'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteMetric(String metricId) async {
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.deleteMetric(metricId);
        return const Right(null);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      }
    } else {
      return const Left(NetworkFailure('No internet connection'));
    }
  }

  @override
  Future<Either<Failure, HealthGoal>> setHealthGoal(HealthGoal goal) async {
    if (await networkInfo.isConnected) {
      try {
        final goalModel = await remoteDataSource.setHealthGoal(
          HealthGoalModel(
            id: goal.id,
            userId: goal.userId,
            metricType: goal.metricType,
            targetValue: goal.targetValue,
            targetUnit: goal.targetUnit,
            targetDate: goal.targetDate,
            createdAt: goal.createdAt,
            isActive: goal.isActive,
          ),
        );
        return Right(goalModel);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      }
    } else {
      return const Left(NetworkFailure('No internet connection'));
    }
  }

  @override
  Future<Either<Failure, List<HealthGoal>>> getActiveGoals() async {
    if (await networkInfo.isConnected) {
      try {
        final goals = await remoteDataSource.getActiveGoals();
        return Right(goals);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      }
    } else {
      return const Left(NetworkFailure('No internet connection'));
    }
  }

  @override
  Future<Either<Failure, HealthGoal>> updateGoalProgress(
      String goalId, double progress) async {
    if (await networkInfo.isConnected) {
      try {
        final goal =
            await remoteDataSource.updateGoalProgress(goalId, progress);
        return Right(goal);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      }
    } else {
      return const Left(NetworkFailure('No internet connection'));
    }
  }
}
