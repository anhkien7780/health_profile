import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_profile/database/shared_preferences_helper.dart';
import 'package:health_profile/ui/pages/splash/splash_navigator.dart';
import 'package:health_profile/ui/pages/splash/splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit({required this.navigator}) : super(SplashState());

  final SplashNavigator navigator;

  Future<void> checkLogin() async {
    await Future.delayed(const Duration(seconds: 2));
    final isFirstRun = await SharedPreferencesHelper.isFirstRun();
    if (isFirstRun) {
      await navigator.goToOnboardingPage();
    } else {
      await navigator.goToLoginPage();
    }
  }
}
