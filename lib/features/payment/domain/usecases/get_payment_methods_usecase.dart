import 'package:dartz/dartz.dart';
import 'package:neurocare_app/core/errors/failures.dart';
import 'package:neurocare_app/core/usecases/usecase.dart';
import 'package:neurocare_app/features/payment/domain/entities/payment_method_entity.dart';
import 'package:neurocare_app/features/payment/domain/repositories/payment_repository.dart';

class GetPaymentMethodsUseCase
    implements UseCase<List<PaymentMethodEntity>, NoParams> {
  final PaymentRepository repository;

  GetPaymentMethodsUseCase(this.repository);

  @override
  Future<Either<Failure, List<PaymentMethodEntity>>> call(NoParams params) {
    return repository.getPaymentMethods();
  }
}
