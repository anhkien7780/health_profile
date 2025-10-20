import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_profile/database/shared_preferences_helper.dart';
import 'package:health_profile/ui/splash_page/splash_navigator.dart';
import 'package:health_profile/ui/splash_page/splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit({required this.navigator}) : super(SplashState());

  final SplashNavigator navigator;

  Future<void> openOnboardingPage() async{
    await Future.delayed(const Duration(seconds: 2));
    await navigator.goToOnboarding();
  }

  Future<void> checkLogin() async {
    final isFirstRun = await SharedPreferencesHelper.isFirstRun();
    if (isFirstRun) {
      await navigator.goToOnboarding();
    }
  }
}
