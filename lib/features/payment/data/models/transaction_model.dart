import 'package:neurocare_app/features/payment/domain/entities/transaction_entity.dart';

class TransactionModel extends TransactionEntity {
  const TransactionModel({
    required super.id,
    required super.userId,
    required super.paymentMethodId,
    required super.type,
    required super.status,
    required super.amount,
    required super.currency,
    required super.description,
    super.appointmentId,
    super.doctorName,
    required super.transactionDate,
    required super.createdAt,
    super.failureReason,
    super.referenceNumber,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      id: json['id'] as String,
      userId: json['userId'] as String,
      paymentMethodId: json['paymentMethodId'] as String,
      type: _parseTransactionType(json['type'] as String),
      status: _parseTransactionStatus(json['status'] as String),
      amount: (json['amount'] as num).toDouble(),
      currency: json['currency'] as String,
      description: json['description'] as String,
      appointmentId: json['appointmentId'] as String?,
      doctorName: json['doctorName'] as String?,
      transactionDate: DateTime.parse(json['transactionDate'] as String),
      createdAt: DateTime.parse(json['createdAt'] as String),
      failureReason: json['failureReason'] as String?,
      referenceNumber: json['referenceNumber'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'paymentMethodId': paymentMethodId,
      'type': type.toString().split('.').last,
      'status': status.toString().split('.').last,
      'amount': amount,
      'currency': currency,
      'description': description,
      'appointmentId': appointmentId,
      'doctorName': doctorName,
      'transactionDate': transactionDate.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
      'failureReason': failureReason,
      'referenceNumber': referenceNumber,
    };
  }

  static TransactionType _parseTransactionType(String type) {
    switch (type.toLowerCase()) {
      case 'appointmentpayment':
        return TransactionType.appointmentPayment;
      case 'consultationpayment':
        return TransactionType.consultationPayment;
      case 'subscription':
        return TransactionType.subscription;
      default:
        return TransactionType.appointmentPayment;
    }
  }

  static TransactionStatus _parseTransactionStatus(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return TransactionStatus.pending;
      case 'completed':
        return TransactionStatus.completed;
      case 'failed':
        return TransactionStatus.failed;
      case 'refunded':
        return TransactionStatus.refunded;
      default:
        return TransactionStatus.pending;
    }
  }

  // Factory for creating sample transactions
  factory TransactionModel.sampleCompleted() {
    return TransactionModel(
      id: 'txn_1',
      userId: 'user_123',
      paymentMethodId: 'pm_1',
      type: TransactionType.appointmentPayment,
      status: TransactionStatus.completed,
      amount: 120.0,
      currency: 'SAR',
      description: 'دفع موعد مع د. سارة أحمد',
      appointmentId: 'apt_1',
      doctorName: 'د. سارة أحمد',
      transactionDate: DateTime.now().subtract(const Duration(days: 2)),
      createdAt: DateTime.now().subtract(const Duration(days: 2)),
      referenceNumber: 'REF123456789',
    );
  }

  factory TransactionModel.samplePending() {
    return TransactionModel(
      id: 'txn_2',
      userId: 'user_123',
      paymentMethodId: 'pm_1',
      type: TransactionType.consultationPayment,
      status: TransactionStatus.pending,
      amount: 80.0,
      currency: 'SAR',
      description: 'دفع استشارة مع د. محمد علي',
      appointmentId: 'apt_2',
      doctorName: 'د. محمد علي',
      transactionDate: DateTime.now(),
      createdAt: DateTime.now(),
    );
  }

  factory TransactionModel.sampleFailed() {
    return TransactionModel(
      id: 'txn_3',
      userId: 'user_123',
      paymentMethodId: 'pm_2',
      type: TransactionType.appointmentPayment,
      status: TransactionStatus.failed,
      amount: 150.0,
      currency: 'SAR',
      description: 'دفع موعد مع د. فاطمة حسن',
      appointmentId: 'apt_3',
      doctorName: 'د. فاطمة حسن',
      transactionDate: DateTime.now().subtract(const Duration(days: 1)),
      createdAt: DateTime.now().subtract(const Duration(days: 1)),
      failureReason: 'رصيد غير كافي',
      referenceNumber: 'REF987654321',
    );
  }
}
