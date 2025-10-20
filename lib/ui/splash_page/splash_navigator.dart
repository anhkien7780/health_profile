import 'package:health_profile/common/app_navigator.dart';
import 'package:health_profile/router/router_config.dart';

class SplashNavigator extends AppNavigator {
  SplashNavigator(super.context);


  Future<void> goToOnboarding() {
    return pushReplacementNamed(AppRouter.onboarding);
  }
}
