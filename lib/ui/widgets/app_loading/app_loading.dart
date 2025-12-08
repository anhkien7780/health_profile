import 'package:flutter/material.dart';
import 'package:health_profile/common/app_dimens.dart';

class AppLoading extends StatelessWidget {
  const AppLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}

class AppLoadingOverlay extends StatelessWidget {
  const AppLoadingOverlay({
    super.key,
    required this.child,
    required this.isLoading,
  });

  final Widget child;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Stack(
      children: [
        child,
        if (isLoading)
          Container(
            color: theme.colorScheme.surface.withValues(alpha: 0.5),
            alignment: Alignment.center,
            child: Container(
              padding: const EdgeInsets.all(AppDimens.paddingNormal),
              decoration: BoxDecoration(
                color: theme.colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(
                  AppDimens.borderRadiusNormal,
                ),
              ),
              child: const CircularProgressIndicator(),
            ),
          ),
      ],
    );
  }
}
