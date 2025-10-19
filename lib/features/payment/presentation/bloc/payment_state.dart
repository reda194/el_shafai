part of 'payment_bloc.dart';

abstract class PaymentState extends Equatable {
  const PaymentState();

  @override
  List<Object> get props => [];
}

class PaymentInitial extends PaymentState {}

class PaymentLoading extends PaymentState {}

class PaymentMethodsLoaded extends PaymentState {
  final List<PaymentMethodEntity> paymentMethods;

  const PaymentMethodsLoaded({required this.paymentMethods});

  @override
  List<Object> get props => [paymentMethods];
}

class PaymentMethodAdded extends PaymentState {}

class PaymentProcessing extends PaymentState {}

class PaymentSuccess extends PaymentState {}

class PaymentError extends PaymentState {
  final String message;

  const PaymentError({required this.message});

  @override
  List<Object> get props => [message];
}
