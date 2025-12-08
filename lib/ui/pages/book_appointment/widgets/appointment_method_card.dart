import 'package:flutter/material.dart';
import 'package:health_profile/common/app_dimens.dart';

class AppointmentMethodCard extends StatelessWidget {
  const AppointmentMethodCard({
    super.key,
    required this.iconData,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final IconData iconData;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppDimens.borderRadiusNormal),
      child: Container(
        height: AppDimens.buttonBookMethodHeight,
        padding: const EdgeInsets.all(AppDimens.paddingNormal),
        decoration: BoxDecoration(
          color: theme.colorScheme.primary,
          borderRadius: BorderRadius.circular(AppDimens.borderRadiusNormal),
        ),
        child: Row(
          spacing: AppDimens.paddingNormal,
          children: [
            Container(
              padding: const EdgeInsets.all(AppDimens.paddingSmall),
              decoration: BoxDecoration(
                color: theme.colorScheme.inversePrimary,
                borderRadius: BorderRadius.circular(
                  AppDimens.borderRadiusNormal,
                ),
              ),
              child: Icon(
                iconData,
                size: AppDimens.iconSizeNormal,
                color: theme.colorScheme.onPrimary,
              ),
            ),
            Expanded(
              child: Column(
                spacing: AppDimens.paddingSmallest,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: theme.textTheme.titleSmall?.copyWith(
                      color: theme.colorScheme.onPrimary,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onPrimary.withValues(alpha: 0.9),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
