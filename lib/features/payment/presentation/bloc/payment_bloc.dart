import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:neurocare_app/core/usecases/usecase.dart';
import 'package:neurocare_app/features/payment/domain/entities/payment_method_entity.dart';
import 'package:neurocare_app/features/payment/domain/entities/payment_transaction_entity.dart';
import 'package:neurocare_app/features/payment/domain/usecases/add_payment_method_usecase.dart';
import 'package:neurocare_app/features/payment/domain/usecases/get_payment_methods_usecase.dart';
import 'package:neurocare_app/features/payment/domain/usecases/process_payment_usecase.dart';

part 'payment_event.dart';
part 'payment_state.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  final GetPaymentMethodsUseCase getPaymentMethods;
  final AddPaymentMethodUseCase addPaymentMethod;
  final ProcessPaymentUseCase processPayment;

  PaymentBloc({
    required this.getPaymentMethods,
    required this.addPaymentMethod,
    required this.processPayment,
  }) : super(PaymentInitial()) {
    on<LoadPaymentMethods>(_onLoadPaymentMethods);
    on<AddPaymentMethod>(_onAddPaymentMethod);
    on<ProcessPayment>(_onProcessPayment);
  }

  Future<void> _onLoadPaymentMethods(
    LoadPaymentMethods event,
    Emitter<PaymentState> emit,
  ) async {
    emit(PaymentLoading());
    try {
      final result = await getPaymentMethods(NoParams());
      result.fold(
        (failure) => emit(PaymentError(message: failure.message)),
        (paymentMethods) =>
            emit(PaymentMethodsLoaded(paymentMethods: paymentMethods)),
      );
    } catch (e) {
      emit(PaymentError(message: e.toString()));
    }
  }

  Future<void> _onAddPaymentMethod(
    AddPaymentMethod event,
    Emitter<PaymentState> emit,
  ) async {
    emit(PaymentLoading());
    try {
      final result = await addPaymentMethod(event.paymentMethod);
      result.fold(
        (failure) => emit(PaymentError(message: failure.message)),
        (success) {
          emit(PaymentMethodAdded());
          add(LoadPaymentMethods()); // Reload the list
        },
      );
    } catch (e) {
      emit(PaymentError(message: e.toString()));
    }
  }

  Future<void> _onProcessPayment(
    ProcessPayment event,
    Emitter<PaymentState> emit,
  ) async {
    emit(PaymentProcessing());
    try {
      final result = await processPayment(event.paymentDetails);
      result.fold(
        (failure) => emit(PaymentError(message: failure.message)),
        (success) => emit(PaymentSuccess()),
      );
    } catch (e) {
      emit(PaymentError(message: e.toString()));
    }
  }
}
