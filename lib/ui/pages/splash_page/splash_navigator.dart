import 'package:health_profile/common/app_navigator.dart';
import 'package:health_profile/router/router_config.dart';

class SplashNavigator extends AppNavigator {
  SplashNavigator(super.context);


  Future<void> goToOnboardingPage() {
    return pushReplacementNamed(AppRouter.onboarding);
  }

  Future<void> goToLoginPage(){
    return pushReplacementNamed(AppRouter.login);
  }
}
