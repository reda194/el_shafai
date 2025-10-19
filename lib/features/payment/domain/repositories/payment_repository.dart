import 'package:dartz/dartz.dart';
import 'package:neurocare_app/core/errors/failures.dart';
import 'package:neurocare_app/features/payment/domain/entities/payment_method_entity.dart';
import 'package:neurocare_app/features/payment/domain/entities/payment_transaction_entity.dart';

abstract class PaymentRepository {
  Future<Either<Failure, List<PaymentMethodEntity>>> getPaymentMethods();
  Future<Either<Failure, PaymentMethodEntity>> addPaymentMethod(
      PaymentMethodEntity paymentMethod);
  Future<Either<Failure, void>> removePaymentMethod(String paymentMethodId);
  Future<Either<Failure, PaymentTransactionEntity>> processPayment(
      PaymentTransactionEntity transaction);
  Future<Either<Failure, List<PaymentTransactionEntity>>> getPaymentHistory();
}
