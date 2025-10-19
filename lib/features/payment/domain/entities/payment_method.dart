class PaymentMethod {
  final String id;
  final String cardHolderName;
  final String lastFourDigits;
  final String expiryDate;
  final String cardType; // visa, mastercard, etc.
  final bool isDefault;

  const PaymentMethod({
    required this.id,
    required this.cardHolderName,
    required this.lastFourDigits,
    required this.expiryDate,
    required this.cardType,
    this.isDefault = false,
  });

  PaymentMethod copyWith({
    String? id,
    String? cardHolderName,
    String? lastFourDigits,
    String? expiryDate,
    String? cardType,
    bool? isDefault,
  }) {
    return PaymentMethod(
      id: id ?? this.id,
      cardHolderName: cardHolderName ?? this.cardHolderName,
      lastFourDigits: lastFourDigits ?? this.lastFourDigits,
      expiryDate: expiryDate ?? this.expiryDate,
      cardType: cardType ?? this.cardType,
      isDefault: isDefault ?? this.isDefault,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'cardHolderName': cardHolderName,
      'lastFourDigits': lastFourDigits,
      'expiryDate': expiryDate,
      'cardType': cardType,
      'isDefault': isDefault,
    };
  }

  factory PaymentMethod.fromJson(Map<String, dynamic> json) {
    return PaymentMethod(
      id: json['id'] as String,
      cardHolderName: json['cardHolderName'] as String,
      lastFourDigits: json['lastFourDigits'] as String,
      expiryDate: json['expiryDate'] as String,
      cardType: json['cardType'] as String,
      isDefault: json['isDefault'] as bool? ?? false,
    );
  }
}
