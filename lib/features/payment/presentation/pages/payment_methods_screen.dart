import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neurocare_app/config/dependency_injection.dart';
import 'package:neurocare_app/core/constants/app_colors.dart';
import 'package:neurocare_app/core/constants/app_strings.dart';
import 'package:neurocare_app/features/payment/domain/entities/payment_method_entity.dart';
import 'package:neurocare_app/features/payment/domain/usecases/add_payment_method_usecase.dart';
import 'package:neurocare_app/features/payment/domain/usecases/get_payment_methods_usecase.dart';
import 'package:neurocare_app/features/payment/domain/usecases/process_payment_usecase.dart';
import 'package:neurocare_app/features/payment/presentation/bloc/payment_bloc.dart';

class PaymentMethodsScreen extends StatelessWidget {
  const PaymentMethodsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PaymentBloc(
        getPaymentMethods: GetPaymentMethodsUseCase(getIt()),
        addPaymentMethod: AddPaymentMethodUseCase(getIt()),
        processPayment: ProcessPaymentUseCase(getIt()),
      )..add(LoadPaymentMethods()),
      child: Scaffold(
        backgroundColor: AppColors.onboardingBackground,
        appBar: AppBar(
          backgroundColor: AppColors.onboardingBackground,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: AppColors.primary),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text(
            AppStrings.paymentMethods,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
        body: BlocBuilder<PaymentBloc, PaymentState>(
          builder: (context, state) {
            if (state is PaymentLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is PaymentMethodsLoaded) {
              return _buildPaymentMethodsList(context, state.paymentMethods);
            } else if (state is PaymentError) {
              return Center(child: Text(state.message));
            }
            return const SizedBox.shrink();
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _showAddPaymentMethodDialog(context),
          backgroundColor: AppColors.primary,
          child: const Icon(Icons.add, color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildPaymentMethodsList(
      BuildContext context, List<PaymentMethodEntity> paymentMethods) {
    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: paymentMethods.length,
      itemBuilder: (context, index) {
        final method = paymentMethods[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: ListTile(
            leading: const Icon(Icons.credit_card, color: AppColors.primary),
            title: Text(
              '${method.cardHolderName} - ****${method.lastFourDigits}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(method.expiryDate),
            trailing: IconButton(
              icon: const Icon(Icons.delete, color: AppColors.error),
              onPressed: () {
                // TODO: Implement delete payment method
              },
            ),
          ),
        );
      },
    );
  }

  void _showAddPaymentMethodDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            AppStrings.addCard,
            style: TextStyle(color: AppColors.primary),
          ),
          content: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(
                  labelText: AppStrings.cardNumber,
                  hintText: '1234 5678 9012 3456',
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(
                  labelText: AppStrings.cardHolderName,
                  hintText: 'John Doe',
                ),
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: AppStrings.expiryDate,
                        hintText: 'MM/YY',
                      ),
                      keyboardType: TextInputType.datetime,
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: AppStrings.cvv,
                        hintText: '123',
                      ),
                      keyboardType: TextInputType.number,
                      obscureText: true,
                    ),
                  ),
                ],
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text(AppStrings.cancel),
            ),
            ElevatedButton(
              onPressed: () {
                // TODO: Implement add payment method logic
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
              ),
              child: const Text(AppStrings.save),
            ),
          ],
        );
      },
    );
  }
}
