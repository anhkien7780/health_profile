import 'package:health_profile/common/app_navigator.dart';
import 'package:health_profile/router/router_config.dart';

class VerifyCodeNavigator extends AppNavigator {
  VerifyCodeNavigator(super.context);

  Future<void> openLoginPage() async {
    pushReplacementNamed(AppRouter.login);
  }

  Future<void> openChangePasswordPage() async {
    pushNamed(AppRouter.changePassword);
  }
}
