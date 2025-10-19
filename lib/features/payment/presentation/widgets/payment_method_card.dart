import 'package:flutter/material.dart';
import 'package:neurocare_app/core/constants/app_colors.dart';
import 'package:neurocare_app/features/payment/domain/entities/payment_method_entity.dart';

class PaymentMethodCard extends StatelessWidget {
  final PaymentMethodEntity paymentMethod;
  final VoidCallback onDelete;
  final VoidCallback onSetDefault;

  const PaymentMethodCard({
    super.key,
    required this.paymentMethod,
    required this.onDelete,
    required this.onSetDefault,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with type and actions
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  _getPaymentIcon(),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _getPaymentTypeText(),
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  color: AppColors.homePrimaryText,
                                  fontWeight: FontWeight.bold,
                                ),
                      ),
                      if (paymentMethod.isDefault)
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: AppColors.homeAccentBlue.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            'افتراضي',
                            style:
                                Theme.of(context).textTheme.bodySmall?.copyWith(
                                      color: AppColors.homeAccentBlue,
                                      fontWeight: FontWeight.w500,
                                    ),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
              PopupMenuButton<String>(
                onSelected: (value) {
                  switch (value) {
                    case 'set_default':
                      if (!paymentMethod.isDefault) {
                        onSetDefault();
                      }
                      break;
                    case 'delete':
                      onDelete();
                      break;
                  }
                },
                itemBuilder: (context) => [
                  if (!paymentMethod.isDefault)
                    const PopupMenuItem(
                      value: 'set_default',
                      child: Text('تعيين كافتراضي'),
                    ),
                  const PopupMenuItem(
                    value: 'delete',
                    child: Text('حذف'),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Payment details
          if (paymentMethod.type == PaymentMethodType.paypal) ...[
            Text(
              paymentMethod.paypalEmail ?? '',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: AppColors.homePrimaryText,
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ] else ...[
            Text(
              paymentMethod.maskedCardNumber,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: AppColors.homePrimaryText,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 2,
                  ),
            ),
            const SizedBox(height: 4),
            Text(
              paymentMethod.cardHolderName,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.homeSecondaryText,
                  ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'انتهاء ${paymentMethod.expiryDate}',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.homeSecondaryText,
                      ),
                ),
                if (paymentMethod.isExpired)
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: AppColors.error.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      'منتهي الصلاحية',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppColors.error,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                  )
                else
                  Text(
                    paymentMethod.cardType,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.homeSecondaryText,
                        ),
                  ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _getPaymentIcon() {
    IconData iconData;
    Color iconColor;

    switch (paymentMethod.type) {
      case PaymentMethodType.creditCard:
      case PaymentMethodType.debitCard:
        iconData = Icons.credit_card;
        iconColor = AppColors.homeAccentBlue;
        break;
      case PaymentMethodType.paypal:
        iconData = Icons.account_balance_wallet;
        iconColor = Colors.blue;
        break;
      case PaymentMethodType.applePay:
        iconData = Icons.apple;
        iconColor = Colors.black;
        break;
      case PaymentMethodType.googlePay:
        iconData = Icons.payment;
        iconColor = Colors.blue;
        break;
    }

    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: iconColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Icon(
        iconData,
        color: iconColor,
        size: 24,
      ),
    );
  }

  String _getPaymentTypeText() {
    switch (paymentMethod.type) {
      case PaymentMethodType.creditCard:
        return 'بطاقة ائتمان';
      case PaymentMethodType.debitCard:
        return 'بطاقة خصم';
      case PaymentMethodType.paypal:
        return 'PayPal';
      case PaymentMethodType.applePay:
        return 'Apple Pay';
      case PaymentMethodType.googlePay:
        return 'Google Pay';
    }
  }
}
