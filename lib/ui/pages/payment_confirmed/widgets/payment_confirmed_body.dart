import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:health_profile/common/app_dimens.dart';
import 'package:health_profile/generated/l10n.dart';
import 'package:health_profile/router/router_config.dart';
import 'package:health_profile/ui/widgets/buttons/app_elevated_button.dart';

class PaymentConfirmedBody extends StatelessWidget {
  const PaymentConfirmedBody({super.key});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(s.paymentConfirmedTitle),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppDimens.paddingBig),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Icon(Icons.check_circle_outline, size: 100, color: Colors.green),
            const SizedBox(height: AppDimens.paddingBig),
            Text(
              s.paymentConfirmedMessage,
              style: theme.textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppDimens.paddingBig),
            AppElevatedButton(
              onClick: () => context.goNamed(AppRouter.home),
              text: s.backToHome,
            ),
          ],
        ),
      ),
    );
  }
}
