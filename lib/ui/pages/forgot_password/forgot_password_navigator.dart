import 'package:health_profile/common/app_navigator.dart';
import 'package:health_profile/router/router_config.dart';

class ForgotPasswordNavigator extends AppNavigator {
  ForgotPasswordNavigator(super.context);

  void openLoginPage() {
    pushReplacementNamed(AppRouter.login);
  }

  void openEnterVerifyCodePage() {
    pushNamed(AppRouter.verifyCode);
  }
}
