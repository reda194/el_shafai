import 'package:dartz/dartz.dart';
import 'package:neurocare_app/core/errors/exceptions.dart';
import 'package:neurocare_app/core/errors/failures.dart';
import 'package:neurocare_app/core/network/network_info.dart';
import 'package:neurocare_app/features/payment/data/datasources/payment_remote_datasource.dart';
import 'package:neurocare_app/features/payment/domain/entities/payment_method_entity.dart';
import 'package:neurocare_app/features/payment/domain/entities/payment_transaction_entity.dart';
import 'package:neurocare_app/features/payment/domain/repositories/payment_repository.dart';

class PaymentRepositoryImpl implements PaymentRepository {
  final PaymentRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  PaymentRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<PaymentMethodEntity>>> getPaymentMethods() async {
    if (await networkInfo.isConnected) {
      try {
        final result = await remoteDataSource.getPaymentMethods();
        return Right(result);
      } on ServerException {
        return const Left(ServerFailure('Server error occurred'));
      }
    } else {
      return const Left(NetworkFailure('No internet connection'));
    }
  }

  @override
  Future<Either<Failure, PaymentMethodEntity>> addPaymentMethod(
      PaymentMethodEntity paymentMethod) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await remoteDataSource.addPaymentMethod(paymentMethod);
        return Right(result);
      } on ServerException {
        return const Left(ServerFailure('Server error occurred'));
      }
    } else {
      return const Left(NetworkFailure('No internet connection'));
    }
  }

  @override
  Future<Either<Failure, void>> removePaymentMethod(
      String paymentMethodId) async {
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.removePaymentMethod(paymentMethodId);
        return const Right(null);
      } on ServerException {
        return const Left(ServerFailure('Server error occurred'));
      }
    } else {
      return const Left(NetworkFailure('No internet connection'));
    }
  }

  @override
  Future<Either<Failure, PaymentTransactionEntity>> processPayment(
      PaymentTransactionEntity transaction) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await remoteDataSource.processPayment(transaction);
        return Right(result);
      } on ServerException {
        return const Left(ServerFailure('Server error occurred'));
      }
    } else {
      return const Left(NetworkFailure('No internet connection'));
    }
  }

  @override
  Future<Either<Failure, List<PaymentTransactionEntity>>>
      getPaymentHistory() async {
    if (await networkInfo.isConnected) {
      try {
        final result = await remoteDataSource.getPaymentHistory();
        return Right(result);
      } on ServerException {
        return const Left(ServerFailure('Server error occurred'));
      }
    } else {
      return const Left(NetworkFailure('No internet connection'));
    }
  }
}
