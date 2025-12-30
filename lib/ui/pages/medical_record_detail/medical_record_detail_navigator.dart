import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:health_profile/router/router_config.dart';

class MedicalRecordDetailNavigator {
  const MedicalRecordDetailNavigator(this.context);

  final BuildContext context;

  void navigateToPaymentSelection(int appointmentId) {
    context.pushNamed(
      AppRouter.paymentSelection,
      pathParameters: {'appointmentId': appointmentId.toString()},
    );
  }
}
