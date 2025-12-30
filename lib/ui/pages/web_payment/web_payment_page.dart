import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_profile/ui/pages/web_payment/web_payment_cubit.dart';
import 'package:health_profile/ui/pages/web_payment/widgets/web_payment_body.dart';

class WebPaymentPage extends StatelessWidget {
  final String paymentUrl;

  const WebPaymentPage({super.key, required this.paymentUrl});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WebPaymentCubit(),
      child: WebPaymentBody(paymentUrl: paymentUrl),
    );
  }
}
