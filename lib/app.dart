import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:health_profile/generated/l10n.dart';
import 'package:health_profile/router/router_config.dart';
import 'package:health_profile/utils/create_text_theme.dart';

import 'common/app_theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
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
    );
  }
}
