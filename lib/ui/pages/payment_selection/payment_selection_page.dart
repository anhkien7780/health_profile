import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_profile/repositories/payment_repository.dart';
import 'package:health_profile/ui/pages/payment_selection/payment_selection_cubit.dart';
import 'package:health_profile/ui/pages/payment_selection/payment_selection_navigator.dart';
import 'package:health_profile/ui/pages/payment_selection/widgets/payment_selection_body.dart';

class PaymentSelectionPage extends StatelessWidget {
  final int appointmentId;

  const PaymentSelectionPage({super.key, required this.appointmentId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PaymentSelectionCubit(
        paymentRepository: context.read<PaymentRepository>(),
        appointmentId: appointmentId,
        navigator: PaymentSelectionNavigator(context),
      ),
      child: const PaymentSelectionBody(),
    );
  }
}
