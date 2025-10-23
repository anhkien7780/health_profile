import 'package:health_profile/common/app_navigator.dart';
import 'package:health_profile/router/router_config.dart';

class OnboardingNavigator extends AppNavigator {
  OnboardingNavigator(super.context);

  Future<void> openLoginPage() async {
    await pushReplacementNamed(AppRouter.login);
  }
}
