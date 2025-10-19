import 'package:dartz/dartz.dart';
import 'package:neurocare_app/core/errors/exceptions.dart';
import 'package:neurocare_app/core/errors/failures.dart';
import 'package:neurocare_app/core/network/network_info.dart';
import 'package:neurocare_app/features/call/data/datasources/call_remote_datasource.dart';
import 'package:neurocare_app/features/call/domain/entities/call_entity.dart';
import 'package:neurocare_app/features/call/domain/repositories/call_repository.dart';

class CallRepositoryImpl implements CallRepository {
  final CallRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  CallRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, CallEntity>> startCall({
    required String receiverId,
    required CallType callType,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final callModel = await remoteDataSource.startCall(
          receiverId: receiverId,
          callType: callType,
        );
        return Right(callModel);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      }
    } else {
      return const Left(NetworkFailure('No internet connection'));
    }
  }

  @override
  Future<Either<Failure, CallEntity>> endCall(String callId) async {
    if (await networkInfo.isConnected) {
      try {
        final callModel = await remoteDataSource.endCall(callId);
        return Right(callModel);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      }
    } else {
      return const Left(NetworkFailure('No internet connection'));
    }
  }

  @override
  Future<Either<Failure, List<CallEntity>>> getCallHistory() async {
    if (await networkInfo.isConnected) {
      try {
        final callModels = await remoteDataSource.getCallHistory();
        return Right(callModels);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      }
    } else {
      return const Left(NetworkFailure('No internet connection'));
    }
  }

  @override
  Future<Either<Failure, CallEntity?>> getOngoingCall() async {
    if (await networkInfo.isConnected) {
      try {
        final callModel = await remoteDataSource.getOngoingCall();
        return Right(callModel);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      }
    } else {
      return const Left(NetworkFailure('No internet connection'));
    }
  }

  @override
  Future<Either<Failure, CallEntity>> acceptCall(String callId) async {
    if (await networkInfo.isConnected) {
      try {
        final callModel = await remoteDataSource.acceptCall(callId);
        return Right(callModel);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      }
    } else {
      return const Left(NetworkFailure('No internet connection'));
    }
  }

  @override
  Future<Either<Failure, CallEntity>> declineCall(String callId) async {
    if (await networkInfo.isConnected) {
      try {
        final callModel = await remoteDataSource.declineCall(callId);
        return Right(callModel);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      }
    } else {
      return const Left(NetworkFailure('No internet connection'));
    }
  }
}
