import 'package:health_profile/common/app_navigator.dart';
import 'package:health_profile/router/router_config.dart';

class SignUpNavigator extends AppNavigator {
  SignUpNavigator(super.context);

  Future<void> openLoginPage() async {
    await pushReplacementNamed(AppRouter.login);
  }

  Future<void> openProfileRegister() async {
    await pushReplacementNamed(AppRouter.profileRegister);
  }
}
