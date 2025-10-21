import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:health_profile/generated/l10n.dart';
import 'package:health_profile/global_blocs/settings/app_setting_cubit.dart';
import 'package:health_profile/models/enum/language.dart';
import 'package:health_profile/router/router_config.dart';
import 'package:health_profile/utils/create_text_theme.dart';
import 'package:loader_overlay/loader_overlay.dart';

import 'common/app_theme.dart';
import 'global_blocs/settings/app_setting_state.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider<AppSettingCubit>(
      create: (context) {
        return AppSettingCubit();
      },
      child: BlocBuilder<AppSettingCubit, AppSettingState>(
        buildWhen: (previous, current) =>
            previous.currentLanguage != current.currentLanguage,
        builder: (context, state) {
          return GlobalLoaderOverlay(
            child: _createMaterialApp(
              context,
              locale: state.currentLanguage.local,
            ),
          );
        },
      ),
    );
  }

  MaterialApp _createMaterialApp(
    BuildContext context, {
    required Locale locale,
  }) {
    final brightness = View.of(context).platformDispatcher.platformBrightness;
    TextTheme textTheme = createTextTheme(context, "Roboto", "Roboto");
    AppTheme theme = AppTheme(textTheme);
    return MaterialApp.router(
      theme: brightness == Brightness.light ? theme.light() : theme.dark(),
      routerConfig: AppRouter.routers,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        S.delegate,
      ],
      locale: locale,
    );
  }
}
