import 'package:health_profile/common/app_navigator.dart';
import 'package:health_profile/router/router_config.dart';

class ProfileRegisterNavigator extends AppNavigator {
  ProfileRegisterNavigator(super.context);

  Future<void> openHomePage() {
    return pushReplacementNamed(AppRouter.home);
  }
}
