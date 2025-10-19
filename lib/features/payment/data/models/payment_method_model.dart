import 'package:neurocare_app/features/payment/domain/entities/payment_method_entity.dart';

class PaymentMethodModel extends PaymentMethodEntity {
  const PaymentMethodModel({
    required super.id,
    required super.cardHolderName,
    required super.lastFourDigits,
    required super.expiryDate,
    required super.type,
    super.isDefault,
  });

  factory PaymentMethodModel.fromJson(Map<String, dynamic> json) {
    return PaymentMethodModel(
      id: json['id'] as String,
      cardHolderName: json['cardHolderName'] as String,
      lastFourDigits: json['lastFourDigits'] as String,
      expiryDate: json['expiryDate'] as String,
      type: _parsePaymentMethodType(json['type'] as String),
      isDefault: json['isDefault'] as bool? ?? false,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'cardHolderName': cardHolderName,
      'lastFourDigits': lastFourDigits,
      'expiryDate': expiryDate,
      'type': type.name,
      'isDefault': isDefault,
    };
  }

  static PaymentMethodType _parsePaymentMethodType(String type) {
    switch (type.toLowerCase()) {
      case 'creditcard':
        return PaymentMethodType.creditCard;
      case 'debitcard':
        return PaymentMethodType.debitCard;
      case 'paypal':
        return PaymentMethodType.paypal;
      case 'applepay':
        return PaymentMethodType.applePay;
      case 'googlepay':
        return PaymentMethodType.googlePay;
      default:
        return PaymentMethodType.creditCard;
    }
  }

  // Factory for creating sample payment methods
  factory PaymentMethodModel.sampleCreditCard() {
    return const PaymentMethodModel(
      id: 'pm_1',
      cardHolderName: 'محمد أحمد',
      lastFourDigits: '1111',
      expiryDate: '12/26',
      type: PaymentMethodType.creditCard,
      isDefault: true,
    );
  }

  factory PaymentMethodModel.samplePayPal() {
    return const PaymentMethodModel(
      id: 'pm_2',
      cardHolderName: 'محمد أحمد',
      lastFourDigits: '',
      expiryDate: '',
      type: PaymentMethodType.paypal,
      isDefault: false,
    );
  }
}
