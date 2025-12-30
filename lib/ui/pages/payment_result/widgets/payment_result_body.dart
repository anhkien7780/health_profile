import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:health_profile/common/app_dimens.dart';
import 'package:health_profile/generated/l10n.dart';
import 'package:health_profile/ui/widgets/buttons/app_elevated_button.dart';

class PaymentResultBody extends StatelessWidget {
  final String transactionRef;

  const PaymentResultBody({super.key, required this.transactionRef});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(s.paymentResultTitle),
        automaticallyImplyLeading: false, // No back button
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppDimens.paddingBig),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Icon(Icons.watch_later_outlined, size: 100, color: Colors.orange),
            const SizedBox(height: AppDimens.paddingBig),
            Text(
              s.pendingPaymentAtCounter,
              style: theme.textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppDimens.paddingNormal),
            Text(
              s.presentCodeAtCounter,
              style: theme.textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppDimens.paddingBig),
            Text(
              s.transactionCode,
              style: theme.textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppDimens.paddingSmall),
            SelectableText(
              transactionRef,
              style: theme.textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppDimens.paddingBig),
            AppElevatedButton(
              onClick: () => context.go('/'), // Navigate to home
              text: s.understood,
            ),
          ],
        ),
      ),
    );
  }
}
