import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:health_profile/router/router_config.dart';

class PaymentSelectionNavigator {
  const PaymentSelectionNavigator(this.context);

  final BuildContext context;

  void navigateToWebPayment(String paymentUrl) {
    context.pushNamed(
      AppRouter.webPayment,
      queryParameters: {'paymentUrl': paymentUrl},
    );
  }
}
