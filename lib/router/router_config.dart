import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:health_profile/ui/pages/login_page/login_page.dart';

import '../ui/pages/onboarding_page/onboarding_page.dart';
import '../ui/pages/splash_page/splash_page.dart';

class AppRouter {
  static final navigationKey = GlobalKey<NavigatorState>();

  static final splash = "/";
  static final onboarding = "/onboarding";
  static final login = "/login";

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
  ];
}
