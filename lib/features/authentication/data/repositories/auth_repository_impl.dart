import 'package:dartz/dartz.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/auth_response_entity.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_local_datasource.dart';
import '../datasources/auth_remote_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, AuthResponseEntity>> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    if (!await networkInfo.isConnected) {
      return const Left(NetworkFailure('لا يوجد اتصال بالإنترنت'));
    }

    try {
      final authResponse = await remoteDataSource.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Cache the auth response
      await localDataSource.saveAuthResponse(authResponse);

      return Right(authResponse);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, AuthResponseEntity>> signUpWithEmailAndPassword({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required String phoneNumber,
  }) async {
    if (!await networkInfo.isConnected) {
      return const Left(NetworkFailure('لا يوجد اتصال بالإنترنت'));
    }

    try {
      final authResponse = await remoteDataSource.signUpWithEmailAndPassword(
        email: email,
        password: password,
        firstName: firstName,
        lastName: lastName,
        phoneNumber: phoneNumber,
      );

      // Cache the auth response
      await localDataSource.saveAuthResponse(authResponse);

      return Right(authResponse);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, AuthResponseEntity>> signInWithGoogle() async {
    if (!await networkInfo.isConnected) {
      return const Left(NetworkFailure('لا يوجد اتصال بالإنترنت'));
    }

    try {
      final authResponse = await remoteDataSource.signInWithGoogle();
      await localDataSource.saveAuthResponse(authResponse);
      return Right(authResponse);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, AuthResponseEntity>> signInWithApple() async {
    if (!await networkInfo.isConnected) {
      return const Left(NetworkFailure('لا يوجد اتصال بالإنترنت'));
    }

    try {
      final authResponse = await remoteDataSource.signInWithApple();
      await localDataSource.saveAuthResponse(authResponse);
      return Right(authResponse);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, AuthResponseEntity>> signInWithFacebook() async {
    if (!await networkInfo.isConnected) {
      return const Left(NetworkFailure('لا يوجد اتصال بالإنترنت'));
    }

    try {
      final authResponse = await remoteDataSource.signInWithFacebook();
      await localDataSource.saveAuthResponse(authResponse);
      return Right(authResponse);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, void>> sendPasswordResetEmail(String email) async {
    if (!await networkInfo.isConnected) {
      return const Left(NetworkFailure('لا يوجد اتصال بالإنترنت'));
    }

    try {
      await remoteDataSource.sendPasswordResetEmail(email);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, void>> resetPassword({
    required String token,
    required String newPassword,
  }) async {
    if (!await networkInfo.isConnected) {
      return const Left(NetworkFailure('لا يوجد اتصال بالإنترنت'));
    }

    try {
      await remoteDataSource.resetPassword(
        token: token,
        newPassword: newPassword,
      );
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, void>> verifyEmail(String token) async {
    if (!await networkInfo.isConnected) {
      return const Left(NetworkFailure('لا يوجد اتصال بالإنترنت'));
    }

    try {
      await remoteDataSource.verifyEmail(token);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, void>> resendEmailVerification() async {
    if (!await networkInfo.isConnected) {
      return const Left(NetworkFailure('لا يوجد اتصال بالإنترنت'));
    }

    try {
      await remoteDataSource.resendEmailVerification();
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> getCurrentUser() async {
    try {
      // Try to get from cache first
      final cachedUser = await localDataSource.getCachedUser();
      if (cachedUser != null) {
        return Right(cachedUser);
      }

      // If not in cache or network available, fetch from remote
      if (await networkInfo.isConnected) {
        final user = await remoteDataSource.getCurrentUser();
        await localDataSource.saveUser(user);
        return Right(user);
      }

      return const Left(NetworkFailure('لا يوجد اتصال بالإنترنت'));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> updateProfile({
    String? firstName,
    String? lastName,
    String? phoneNumber,
  }) async {
    if (!await networkInfo.isConnected) {
      return const Left(NetworkFailure('لا يوجد اتصال بالإنترنت'));
    }

    try {
      final updatedUser = await remoteDataSource.updateProfile(
        firstName: firstName,
        lastName: lastName,
        phoneNumber: phoneNumber,
      );

      // Update cache
      await localDataSource.saveUser(updatedUser);

      return Right(updatedUser);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, void>> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    if (!await networkInfo.isConnected) {
      return const Left(NetworkFailure('لا يوجد اتصال بالإنترنت'));
    }

    try {
      await remoteDataSource.changePassword(
        currentPassword: currentPassword,
        newPassword: newPassword,
      );
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, void>> signOut() async {
    try {
      // Clear local data first
      await localDataSource.clearAuthData();

      // Try to sign out from server if network available
      if (await networkInfo.isConnected) {
        await remoteDataSource.signOut();
      }

      return const Right(null);
    } on ServerException {
      // Even if server sign out fails, we cleared local data
      return const Right(null);
    }
  }

  @override
  Future<bool> isAuthenticated() async {
    return await localDataSource.isAuthenticated();
  }

  @override
  Future<Either<Failure, AuthResponseEntity>> refreshToken() async {
    if (!await networkInfo.isConnected) {
      return const Left(NetworkFailure('لا يوجد اتصال بالإنترنت'));
    }

    try {
      final authResponse = await remoteDataSource.refreshToken();
      await localDataSource.saveAuthResponse(authResponse);
      return Right(authResponse);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    }
  }
}
