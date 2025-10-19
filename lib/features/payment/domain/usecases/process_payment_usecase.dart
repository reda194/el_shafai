import 'package:dartz/dartz.dart';
import 'package:neurocare_app/core/errors/failures.dart';
import 'package:neurocare_app/core/usecases/usecase.dart';
import 'package:neurocare_app/features/payment/domain/entities/payment_transaction_entity.dart';
import 'package:neurocare_app/features/payment/domain/repositories/payment_repository.dart';

class ProcessPaymentUseCase
    implements UseCase<PaymentTransactionEntity, PaymentTransactionEntity> {
  final PaymentRepository repository;

  ProcessPaymentUseCase(this.repository);

  @override
  Future<Either<Failure, PaymentTransactionEntity>> call(
      PaymentTransactionEntity params) {
    return repository.processPayment(params);
  }
}
