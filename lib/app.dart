import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:health_profile/generated/l10n.dart';
import 'package:health_profile/global_blocs/settings/app_setting_cubit.dart';
import 'package:health_profile/models/enum/language.dart';
import 'package:health_profile/repositories/appointment_repository.dart';
import 'package:health_profile/repositories/auth_repository.dart';
import 'package:health_profile/repositories/medical_record_repository.dart';
import 'package:health_profile/repositories/prescription_repository.dart';
import 'package:health_profile/repositories/user_profile_repository.dart';
import 'package:health_profile/router/router_config.dart';
import 'package:health_profile/utils/create_text_theme.dart';

import 'common/app_theme.dart';
import 'global_blocs/settings/app_setting_state.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AppointmentRepository>(
          create: (context) => AppointmentRepositoryImpl(),
        ),
        RepositoryProvider<AuthRepository>(
          create: (context) => AuthRepositoryImpl(),
        ),
        RepositoryProvider<UserProfileRepository>(
          create: (context) => UserProfileRepositoryImpl(),
        ),
        RepositoryProvider<MedicalRecordRepository>(
          create: (context) => MedicalRecordRepositoryImpl(),
        ),
        RepositoryProvider<PrescriptionRepository>(
          create: (context) => PrescriptionRepositoryImpl(),
        ),
      ],
      child: BlocProvider<AppSettingCubit>(
        create: (context) {
          return AppSettingCubit();
        },
        child: BlocBuilder<AppSettingCubit, AppSettingState>(
          buildWhen: (previous, current) =>
              previous.currentLanguage != current.currentLanguage,
          builder: (context, state) {
            return GestureDetector(
              onTap: () {
                _hideKeyboard(context);
              },
              child: _createMaterialApp(
                context,
                locale: state.currentLanguage.local,
              ),
            );
          },
        ),
      ),
    );
  }

  MaterialApp _createMaterialApp(
    BuildContext context, {
    required Locale locale,
  }) {
    final brightness = View.of(context).platformDispatcher.platformBrightness;
    TextTheme textTheme = createTextTheme(context, "Roboto", "Roboto");
    AppTheme theme = AppTheme(textTheme: textTheme, brightness: brightness);

    final pageTransitionsTheme = const PageTransitionsTheme(
      builders: {
        TargetPlatform.android: CupertinoPageTransitionsBuilder(),
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      },
    );

    ThemeData lightTheme = theme.light().copyWith(
          pageTransitionsTheme: pageTransitionsTheme,
        );

    ThemeData darkTheme = theme.dark().copyWith(
          pageTransitionsTheme: pageTransitionsTheme,
        );

    return MaterialApp.router(
      theme: brightness == Brightness.light ? lightTheme : darkTheme,
      routerConfig: AppRouter.routers,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        S.delegate,
      ],
      locale: locale,
    );
  }

  void _hideKeyboard(BuildContext context) {
    if (FocusScope.of(context).hasFocus) {
      FocusScope.of(context).unfocus();
    }
  }
}
