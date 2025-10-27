import 'package:flutter/material.dart';
import 'package:health_profile/common/app_dimens.dart';

NavigationBarThemeData createNavigationBarThemeData(BuildContext context) {
  final theme = Theme.of(context);
  return NavigationBarThemeData(
    height: AppDimens.navigationBarHeight,
    backgroundColor: theme.colorScheme.primary,
    elevation: 4,
    labelTextStyle: WidgetStatePropertyAll(
      theme.textTheme.labelLarge?.copyWith(color: theme.colorScheme.onPrimary),
    ),
    iconTheme: WidgetStatePropertyAll(
      IconThemeData(
        size: AppDimens.iconSizeNormal,
        color: Theme.of(context).colorScheme.onPrimary,
      ),
    ),
  );
}
