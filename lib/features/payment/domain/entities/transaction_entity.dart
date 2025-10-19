import 'package:equatable/equatable.dart';

enum TransactionStatus { pending, completed, failed, refunded }

enum TransactionType { appointmentPayment, consultationPayment, subscription }

class TransactionEntity extends Equatable {
  final String id;
  final String userId;
  final String paymentMethodId;
  final TransactionType type;
  final TransactionStatus status;
  final double amount;
  final String currency;
  final String description;
  final String? appointmentId;
  final String? doctorName;
  final DateTime transactionDate;
  final DateTime createdAt;
  final String? failureReason;
  final String? referenceNumber;

  const TransactionEntity({
    required this.id,
    required this.userId,
    required this.paymentMethodId,
    required this.type,
    required this.status,
    required this.amount,
    required this.currency,
    required this.description,
    this.appointmentId,
    this.doctorName,
    required this.transactionDate,
    required this.createdAt,
    this.failureReason,
    this.referenceNumber,
  });

  TransactionEntity copyWith({
    String? id,
    String? userId,
    String? paymentMethodId,
    TransactionType? type,
    TransactionStatus? status,
    double? amount,
    String? currency,
    String? description,
    String? appointmentId,
    String? doctorName,
    DateTime? transactionDate,
    DateTime? createdAt,
    String? failureReason,
    String? referenceNumber,
  }) {
    return TransactionEntity(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      paymentMethodId: paymentMethodId ?? this.paymentMethodId,
      type: type ?? this.type,
      status: status ?? this.status,
      amount: amount ?? this.amount,
      currency: currency ?? this.currency,
      description: description ?? this.description,
      appointmentId: appointmentId ?? this.appointmentId,
      doctorName: doctorName ?? this.doctorName,
      transactionDate: transactionDate ?? this.transactionDate,
      createdAt: createdAt ?? this.createdAt,
      failureReason: failureReason ?? this.failureReason,
      referenceNumber: referenceNumber ?? this.referenceNumber,
    );
  }

  bool get isSuccessful => status == TransactionStatus.completed;
  bool get isPending => status == TransactionStatus.pending;
  bool get isFailed => status == TransactionStatus.failed;
  bool get isRefunded => status == TransactionStatus.refunded;

  String get statusText {
    switch (status) {
      case TransactionStatus.pending:
        return 'قيد الانتظار';
      case TransactionStatus.completed:
        return 'مكتملة';
      case TransactionStatus.failed:
        return 'فاشلة';
      case TransactionStatus.refunded:
        return 'مستردة';
    }
  }

  String get typeText {
    switch (type) {
      case TransactionType.appointmentPayment:
        return 'دفع موعد';
      case TransactionType.consultationPayment:
        return 'دفع استشارة';
      case TransactionType.subscription:
        return 'اشتراك';
    }
  }

  @override
  List<Object?> get props => [
        id,
        userId,
        paymentMethodId,
        type,
        status,
        amount,
        currency,
        description,
        appointmentId,
        doctorName,
        transactionDate,
        createdAt,
        failureReason,
        referenceNumber,
      ];
}
