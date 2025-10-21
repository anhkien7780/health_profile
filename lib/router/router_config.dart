import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:health_profile/ui/pages/login/login_page.dart';
import 'package:health_profile/ui/pages/onboarding/onboarding_page.dart';
import 'package:health_profile/ui/pages/sign_up/sign_up_page.dart';
import 'package:health_profile/ui/pages/splash/splash_page.dart';

class AppRouter {
  static final navigationKey = GlobalKey<NavigatorState>();

  static final splash = "/";
  static final onboarding = "/onboarding";
  static final login = "/login";
  static final signUp = "/signUp";

  static final GoRouter routers = GoRouter(
    routes: _routers,
    debugLogDiagnostics: true,
    navigatorKey: navigationKey,
  );

  static final _routers = <RouteBase>[
    GoRoute(
      path: splash,
      builder: (context, state) {
        return SplashPage();
      },
    ),
    GoRoute(
      path: onboarding,
      name: onboarding,
      builder: (context, state) {
        return OnboardingPage();
      },
    ),
    GoRoute(
      path: login,
      name: login,
      builder: (context, state) {
        return LoginPage();
      },
    ),
    GoRoute(
      path: signUp,
      name: signUp,
      builder: (context, state) {
        return SignUpPage();
      },
    ),
  ];
}
