import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_profile/common/app_dimens.dart';
import 'package:health_profile/generated/l10n.dart';
import 'package:health_profile/models/enum/loading_status.dart';
import 'package:health_profile/models/enum/payment_method.dart';
import 'package:health_profile/ui/pages/payment_selection/payment_selection_cubit.dart';
import 'package:health_profile/ui/pages/payment_selection/payment_selection_state.dart';
import 'package:health_profile/ui/widgets/app_loading/app_loading.dart';
import 'package:health_profile/ui/widgets/buttons/app_elevated_button.dart';

class PaymentSelectionBody extends StatelessWidget {
  const PaymentSelectionBody({super.key});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final theme = Theme.of(context);
    return BlocBuilder<PaymentSelectionCubit, PaymentSelectionState>(
      builder: (context, state) {
        return AppLoadingOverlay(
          isLoading: state.loadingStatus == LoadingStatus.loading,
          child: Scaffold(
            appBar: AppBar(
              title: Text(s.paymentMethodSelectionTitle),
            ),
            body: Padding(
              padding: const EdgeInsets.all(AppDimens.paddingBig),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                spacing: AppDimens.paddingNormal,
                children: [
                  Text(
                    s.amountToBePaid,
                    style: theme.textTheme.titleLarge,
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    '500,000 VND',
                    style: theme.textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: AppDimens.paddingBig - AppDimens.paddingNormal),
                  AppElevatedButton(
                    onClick: () => context
                        .read<PaymentSelectionCubit>()
                        .createPayment(PaymentMethod.VNPAY),
                    text: s.payWithVnPay,
                  ),
                  AppElevatedButton(
                    onClick: () => context
                        .read<PaymentSelectionCubit>()
                        .createPayment(PaymentMethod.CASH),
                    text: s.payWithCash,
                  ),
                  AppElevatedButton(
                    onClick: () => context
                        .read<PaymentSelectionCubit>()
                        .createPayment(PaymentMethod.CARD),
                    text: s.payWithCard,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
