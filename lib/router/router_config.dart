import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:health_profile/ui/pages/book_appointment/book_appointment_page.dart';
import 'package:health_profile/ui/pages/change_password/change_password_page.dart';
import 'package:health_profile/ui/pages/chat/chat_page.dart';
import 'package:health_profile/ui/pages/home/home_page.dart';
import 'package:health_profile/ui/pages/login/login_page.dart';
import 'package:health_profile/ui/pages/medical_record_detail/medical_record_detail_page.dart';
import 'package:health_profile/ui/pages/medical_record_list/medical_record_list_page.dart';
import 'package:health_profile/ui/pages/onboarding/onboarding_page.dart';
import 'package:health_profile/ui/pages/profile_register/profile_register_page.dart';
import 'package:health_profile/ui/pages/sign_up/sign_up_page.dart';
import 'package:health_profile/ui/pages/splash/splash_page.dart';
import 'package:health_profile/ui/pages/verify_code/verify_code_page.dart';

import '../ui/pages/forgot_password/forgot_password_page.dart';

class AppRouter {
  static final navigationKey = GlobalKey<NavigatorState>();

  static final splash = "/";
  static final onboarding = "/onboarding";
  static final login = "/login";
  static final profileRegister = "/profileRegister";
  static final forgotPassword = "/forgotPassword";
  static final verifyCode = "/verifyCode";
  static final changePassword = "/changePassword";
  static final signUp = "/signUp";
  static final home = "/home";
  static final chat = "/chat";
  static final bookAppointment = "/bookAppointment";
  static const medicalRecordList = '/medicalRecordList';
  static const medicalRecordDetail = '/medicalRecordDetail';

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
    GoRoute(
      path: home,
      name: home,
      builder: (context, state) {
        return HomePage();
      },
    ),
    GoRoute(
      path: profileRegister,
      name: profileRegister,
      builder: (context, state) {
        return ProfileRegisterPage();
      },
    ),
    GoRoute(
      path: forgotPassword,
      name: forgotPassword,
      builder: (context, state) {
        return ForgotPasswordPage();
      },
    ),
    GoRoute(
      path: verifyCode,
      name: verifyCode,
      builder: (context, state) {
        return VerifyCodePage();
      },
    ),
    GoRoute(
      path: changePassword,
      name: changePassword,
      builder: (context, state) {
        return ChangePasswordPage();
      },
    ),
    GoRoute(
      path: '$chat/:conversationId',
      name: chat,
      builder: (context, state) {
        final conversationId = state.pathParameters['conversationId']!;
        final name = state.uri.queryParameters['name'] ?? '';
        final specialty = state.uri.queryParameters['specialty'] ?? '';
        return ChatPage(
          conversationId: conversationId,
          name: name,
          specialty: specialty,
        );
      },
    ),
    GoRoute(
      path: bookAppointment,
      name: bookAppointment,
      builder: (context, state) {
        return BookAppointmentPage();
      },
    ),
    GoRoute(
      path: medicalRecordList,
      name: medicalRecordList,
      builder: (context, state) {
        return const MedicalRecordListPage();
      },
    ),
    GoRoute(
      path: '$medicalRecordDetail/:recordId',
      name: medicalRecordDetail,
      builder: (context, state) {
        final recordId = int.parse(state.pathParameters['recordId']!);
        return MedicalRecordDetailPage(recordId: recordId);
      },
    ),
  ];
}
