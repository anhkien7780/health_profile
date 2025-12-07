import 'package:health_profile/common/app_navigator.dart';
import 'package:health_profile/router/router_config.dart';

class HomeNavigator extends AppNavigator {
  HomeNavigator(super.context);

  void backToLoginPage() {
    pushReplacementNamed(AppRouter.login);
  }
}
