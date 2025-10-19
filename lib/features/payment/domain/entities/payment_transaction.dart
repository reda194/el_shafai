class PaymentTransaction {
  final String id;
  final String paymentMethodId;
  final double amount;
  final String currency;
  final String status; // pending, completed, failed, refunded
  final String description;
  final DateTime createdAt;
  final DateTime? completedAt;

  const PaymentTransaction({
    required this.id,
    required this.paymentMethodId,
    required this.amount,
    required this.currency,
    required this.status,
    required this.description,
    required this.createdAt,
    this.completedAt,
  });

  PaymentTransaction copyWith({
    String? id,
    String? paymentMethodId,
    double? amount,
    String? currency,
    String? status,
    String? description,
    DateTime? createdAt,
    DateTime? completedAt,
  }) {
    return PaymentTransaction(
      id: id ?? this.id,
      paymentMethodId: paymentMethodId ?? this.paymentMethodId,
      amount: amount ?? this.amount,
      currency: currency ?? this.currency,
      status: status ?? this.status,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
      completedAt: completedAt ?? this.completedAt,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'paymentMethodId': paymentMethodId,
      'amount': amount,
      'currency': currency,
      'status': status,
      'description': description,
      'createdAt': createdAt.toIso8601String(),
      'completedAt': completedAt?.toIso8601String(),
    };
  }

  factory PaymentTransaction.fromJson(Map<String, dynamic> json) {
    return PaymentTransaction(
      id: json['id'] as String,
      paymentMethodId: json['paymentMethodId'] as String,
      amount: (json['amount'] as num).toDouble(),
      currency: json['currency'] as String,
      status: json['status'] as String,
      description: json['description'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      completedAt: json['completedAt'] != null
          ? DateTime.parse(json['completedAt'] as String)
          : null,
    );
  }
}
