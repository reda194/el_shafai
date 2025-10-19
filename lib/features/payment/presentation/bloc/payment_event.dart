part of 'payment_bloc.dart';

abstract class PaymentEvent extends Equatable {
  const PaymentEvent();

  @override
  List<Object> get props => [];
}

class LoadPaymentMethods extends PaymentEvent {}

class AddPaymentMethod extends PaymentEvent {
  final PaymentMethodEntity paymentMethod;

  const AddPaymentMethod(this.paymentMethod);

  @override
  List<Object> get props => [paymentMethod];
}

class ProcessPayment extends PaymentEvent {
  final PaymentTransactionEntity paymentDetails;

  const ProcessPayment(this.paymentDetails);

  @override
  List<Object> get props => [paymentDetails];
}
