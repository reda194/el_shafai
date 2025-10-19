enum PaymentMethodType {
  creditCard,
  debitCard,
  paypal,
  applePay,
  googlePay,
}

class PaymentMethodEntity {
  final String id;
  final String cardHolderName;
  final String lastFourDigits;
  final String expiryDate;
  final PaymentMethodType type;
  final bool isDefault;

  const PaymentMethodEntity({
    required this.id,
    required this.cardHolderName,
    required this.lastFourDigits,
    required this.expiryDate,
    required this.type,
    this.isDefault = false,
  });

  PaymentMethodEntity copyWith({
    String? id,
    String? cardHolderName,
    String? lastFourDigits,
    String? expiryDate,
    PaymentMethodType? type,
    bool? isDefault,
  }) {
    return PaymentMethodEntity(
      id: id ?? this.id,
      cardHolderName: cardHolderName ?? this.cardHolderName,
      lastFourDigits: lastFourDigits ?? this.lastFourDigits,
      expiryDate: expiryDate ?? this.expiryDate,
      type: type ?? this.type,
      isDefault: isDefault ?? this.isDefault,
    );
  }

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

  factory PaymentMethodEntity.fromJson(Map<String, dynamic> json) {
    return PaymentMethodEntity(
      id: json['id'] as String,
      cardHolderName: json['cardHolderName'] as String,
      lastFourDigits: json['lastFourDigits'] as String,
      expiryDate: json['expiryDate'] as String,
      type: PaymentMethodType.values.firstWhere(
        (e) => e.name == json['type'],
        orElse: () => PaymentMethodType.creditCard,
      ),
      isDefault: json['isDefault'] as bool? ?? false,
    );
  }

  /// Get masked card number (e.g., **** **** **** 1234)
  String get maskedCardNumber {
    if (type == PaymentMethodType.paypal) return '';
    return '**** **** **** $lastFourDigits';
  }

  /// Get card type display name
  String get cardType {
    switch (type) {
      case PaymentMethodType.creditCard:
        return 'Credit Card';
      case PaymentMethodType.debitCard:
        return 'Debit Card';
      case PaymentMethodType.paypal:
        return 'PayPal';
      case PaymentMethodType.applePay:
        return 'Apple Pay';
      case PaymentMethodType.googlePay:
        return 'Google Pay';
    }
  }

  /// Check if card is expired
  bool get isExpired {
    if (type == PaymentMethodType.paypal) return false;
    try {
      final parts = expiryDate.split('/');
      if (parts.length != 2) return false;
      final month = int.parse(parts[0]);
      final year = int.parse('20${parts[1]}');
      final expiryDateTime =
          DateTime(year, month + 1, 0); // Last day of expiry month
      return DateTime.now().isAfter(expiryDateTime);
    } catch (e) {
      return false;
    }
  }

  /// Get PayPal email (only available for PayPal type)
  String? get paypalEmail {
    // This would be stored separately for PayPal accounts
    // For now, return null as we don't have this field in the entity
    return null;
  }
}
