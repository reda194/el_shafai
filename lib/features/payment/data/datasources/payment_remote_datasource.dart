import 'package:neurocare_app/features/payment/domain/entities/payment_method_entity.dart';
import 'package:neurocare_app/features/payment/domain/entities/payment_transaction_entity.dart';

abstract class PaymentRemoteDataSource {
  Future<List<PaymentMethodEntity>> getPaymentMethods();
  Future<PaymentMethodEntity> addPaymentMethod(
      PaymentMethodEntity paymentMethod);
  Future<void> removePaymentMethod(String paymentMethodId);
  Future<PaymentTransactionEntity> processPayment(
      PaymentTransactionEntity transaction);
  Future<List<PaymentTransactionEntity>> getPaymentHistory();
}

class PaymentRemoteDataSourceImpl implements PaymentRemoteDataSource {
  // TODO: Inject Dio client for actual API calls
  PaymentRemoteDataSourceImpl();

  @override
  Future<List<PaymentMethodEntity>> getPaymentMethods() async {
    // TODO: Implement API call to get payment methods
    // For now, return mock data
    await Future.delayed(const Duration(seconds: 1));
    return [
      const PaymentMethodEntity(
        id: '1',
        cardHolderName: 'محمد أحمد',
        lastFourDigits: '1234',
        expiryDate: '12/25',
        type: PaymentMethodType.creditCard,
        isDefault: true,
      ),
      const PaymentMethodEntity(
        id: '2',
        cardHolderName: 'محمد أحمد',
        lastFourDigits: '5678',
        expiryDate: '08/26',
        type: PaymentMethodType.debitCard,
        isDefault: false,
      ),
    ];
  }

  @override
  Future<PaymentMethodEntity> addPaymentMethod(
      PaymentMethodEntity paymentMethod) async {
    // TODO: Implement API call to add payment method
    await Future.delayed(const Duration(seconds: 1));
    return paymentMethod.copyWith(
        id: DateTime.now().millisecondsSinceEpoch.toString());
  }

  @override
  Future<void> removePaymentMethod(String paymentMethodId) async {
    // TODO: Implement API call to remove payment method
    await Future.delayed(const Duration(seconds: 1));
  }

  @override
  Future<PaymentTransactionEntity> processPayment(
      PaymentTransactionEntity transaction) async {
    // TODO: Implement API call to process payment
    await Future.delayed(const Duration(seconds: 2));
    return transaction.copyWith(
      status: TransactionStatus.completed,
      completedAt: DateTime.now(),
    );
  }

  @override
  Future<List<PaymentTransactionEntity>> getPaymentHistory() async {
    // TODO: Implement API call to get payment history
    await Future.delayed(const Duration(seconds: 1));
    return [
      PaymentTransactionEntity(
        id: '1',
        paymentMethodId: '1',
        amount: 150.0,
        currency: 'SAR',
        type: TransactionType.appointment,
        status: TransactionStatus.completed,
        description: 'دفع مقابل موعد مع الطبيب',
        createdAt: DateTime.now().subtract(const Duration(days: 7)),
        completedAt: DateTime.now().subtract(const Duration(days: 7)),
      ),
      PaymentTransactionEntity(
        id: '2',
        paymentMethodId: '1',
        amount: 200.0,
        currency: 'SAR',
        type: TransactionType.consultation,
        status: TransactionStatus.completed,
        description: 'استشارة طبية عبر الإنترنت',
        createdAt: DateTime.now().subtract(const Duration(days: 14)),
        completedAt: DateTime.now().subtract(const Duration(days: 14)),
      ),
    ];
  }
}
