import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:neurocare_app/core/errors/exceptions.dart';
import 'package:neurocare_app/core/errors/failures.dart';
import 'package:neurocare_app/core/network/network_info.dart';
import 'package:neurocare_app/features/profile/data/datasources/profile_remote_datasource.dart';
import 'package:neurocare_app/features/profile/domain/entities/user_profile.dart';
import 'package:neurocare_app/features/profile/domain/repositories/profile_repository.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  ProfileRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, UserProfile>> getUserProfile() async {
    if (await networkInfo.isConnected) {
      try {
        final result = await remoteDataSource.getUserProfile();
        return Right(result);
      } on ServerException {
        return const Left(ServerFailure('Server error occurred'));
      }
    } else {
      return const Left(NetworkFailure('No internet connection'));
    }
  }

  @override
  Future<Either<Failure, UserProfile>> updateUserProfile(
      UserProfile profile) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await remoteDataSource.updateUserProfile(profile);
        return Right(result);
      } on ServerException {
        return const Left(ServerFailure('Server error occurred'));
      }
    } else {
      return const Left(NetworkFailure('No internet connection'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteUserProfile() async {
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.deleteUserProfile();
        return const Right(null);
      } on ServerException {
        return const Left(ServerFailure('Server error occurred'));
      }
    } else {
      return const Left(NetworkFailure('No internet connection'));
    }
  }

  @override
  Future<Either<Failure, String>> uploadProfileImage(String imagePath) async {
    if (await networkInfo.isConnected) {
      try {
        final result =
            await remoteDataSource.uploadProfileImage(File(imagePath));
        return Right(result);
      } on ServerException {
        return const Left(ServerFailure('Server error occurred'));
      }
    } else {
      return const Left(NetworkFailure('No internet connection'));
    }
  }
}
