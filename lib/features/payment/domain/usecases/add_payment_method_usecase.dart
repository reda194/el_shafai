import 'package:dartz/dartz.dart';
import 'package:neurocare_app/core/errors/failures.dart';
import 'package:neurocare_app/core/usecases/usecase.dart';
import 'package:neurocare_app/features/payment/domain/entities/payment_method_entity.dart';
import 'package:neurocare_app/features/payment/domain/repositories/payment_repository.dart';

class AddPaymentMethodUseCase
    implements UseCase<PaymentMethodEntity, PaymentMethodEntity> {
  final PaymentRepository repository;

  AddPaymentMethodUseCase(this.repository);

  @override
  Future<Either<Failure, PaymentMethodEntity>> call(
      PaymentMethodEntity params) {
    return repository.addPaymentMethod(params);
  }
}
