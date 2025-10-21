import 'package:health_profile/common/app_navigator.dart';
import 'package:health_profile/router/router_config.dart';

class LoginNavigator extends AppNavigator {
  LoginNavigator(super.context);

  Future<void> openSignUpPage() async {
    await pushReplacementNamed(AppRouter.signUp);
  }
}
