import 'package:equatable/equatable.dart';

class PaymentTransaction extends Equatable {
  final int id;
  final int appointmentId;
  final int amount;
  final String paymentMethod;
  final String status;
  final String? transactionRef;
  final String? paymentUrl;
  final String? paidAt;
  final String createdAt;

  const PaymentTransaction({
    required this.id,
    required this.appointmentId,
    required this.amount,
    required this.paymentMethod,
    required this.status,
    this.transactionRef,
    this.paymentUrl,
    this.paidAt,
    required this.createdAt,
  });

  factory PaymentTransaction.fromJson(Map<String, dynamic> json) {
    return PaymentTransaction(
      id: json['id'],
      appointmentId: json['appointmentId'],
      amount: (json['amount'] as num).toInt(),
      paymentMethod: json['paymentMethod'],
      status: json['status'],
      transactionRef: json['transactionRef'],
      paymentUrl: json['paymentUrl'],
      paidAt: json['paidAt'],
      createdAt: json['createdAt'],
    );
  }

  @override
  List<Object?> get props => [
        id,
        appointmentId,
        amount,
        paymentMethod,
        status,
        transactionRef,
        paymentUrl,
        paidAt,
        createdAt,
      ];
}
