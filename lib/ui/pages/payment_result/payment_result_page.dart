import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_profile/ui/pages/payment_result/payment_result_cubit.dart';
import 'package:health_profile/ui/pages/payment_result/widgets/payment_result_body.dart';

class PaymentResultPage extends StatelessWidget {
  final String transactionRef;

  const PaymentResultPage({super.key, required this.transactionRef});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PaymentResultCubit(),
      child: PaymentResultBody(transactionRef: transactionRef),
    );
  }
}
