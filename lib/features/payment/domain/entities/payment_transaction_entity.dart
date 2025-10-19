enum TransactionType {
  appointment,
  consultation,
  subscription,
  refund,
}

enum TransactionStatus {
  pending,
  completed,
  failed,
  refunded,
}

class PaymentTransactionEntity {
  final String id;
  final String paymentMethodId;
  final double amount;
  final String currency;
  final TransactionType type;
  final TransactionStatus status;
  final String description;
  final DateTime createdAt;
  final DateTime? completedAt;

  const PaymentTransactionEntity({
    required this.id,
    required this.paymentMethodId,
    required this.amount,
    required this.currency,
    required this.type,
    required this.status,
    required this.description,
    required this.createdAt,
    this.completedAt,
  });

  PaymentTransactionEntity copyWith({
    String? id,
    String? paymentMethodId,
    double? amount,
    String? currency,
    TransactionType? type,
    TransactionStatus? status,
    String? description,
    DateTime? createdAt,
    DateTime? completedAt,
  }) {
    return PaymentTransactionEntity(
      id: id ?? this.id,
      paymentMethodId: paymentMethodId ?? this.paymentMethodId,
      amount: amount ?? this.amount,
      currency: currency ?? this.currency,
      type: type ?? this.type,
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
      'type': type.name,
      'status': status.name,
      'description': description,
      'createdAt': createdAt.toIso8601String(),
      'completedAt': completedAt?.toIso8601String(),
    };
  }

  factory PaymentTransactionEntity.fromJson(Map<String, dynamic> json) {
    return PaymentTransactionEntity(
      id: json['id'] as String,
      paymentMethodId: json['paymentMethodId'] as String,
      amount: (json['amount'] as num).toDouble(),
      currency: json['currency'] as String,
      type: TransactionType.values.firstWhere(
        (e) => e.name == json['type'],
        orElse: () => TransactionType.appointment,
      ),
      status: TransactionStatus.values.firstWhere(
        (e) => e.name == json['status'],
        orElse: () => TransactionStatus.pending,
      ),
      description: json['description'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      completedAt: json['completedAt'] != null
          ? DateTime.parse(json['completedAt'] as String)
          : null,
    );
  }
}
