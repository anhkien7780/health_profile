import 'package:flutter/material.dart';
import 'package:health_profile/common/app_dimens.dart';

class AppSnackBar {
  static void show(
    BuildContext context,
    String message, {
    bool isError = false,
  }) {
    final theme = Theme.of(context);
    final scaffoldMessenger = ScaffoldMessenger.of(context);

    scaffoldMessenger.clearSnackBars();

    scaffoldMessenger.showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: isError
                ? theme.colorScheme.onError
                : theme.colorScheme.onInverseSurface,
          ),
        ),
        backgroundColor: isError
            ? theme.colorScheme.error
            : theme.colorScheme.inverseSurface,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimens.borderRadiusNormal),
        ),
        margin: const EdgeInsets.all(AppDimens.marginBig),
      ),
    );
  }
}
