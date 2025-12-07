import 'package:health_profile/common/app_navigator.dart';
import 'package:health_profile/router/router_config.dart';

class ChangePasswordNavigator extends AppNavigator {
  ChangePasswordNavigator(super.context);

  void openLoginPage() {
    pushReplacementNamed(AppRouter.login);
  }
}
