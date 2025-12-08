import 'package:flutter/material.dart';
import 'package:health_profile/common/app_dimens.dart';

class TimeSlotItem extends StatelessWidget {
  const TimeSlotItem({
    super.key,
    required this.time,
    required this.isSelected,
    required this.onTap,
  });

  final String time;
  final bool isSelected;
  final VoidCallback onTap;

  IconData _getIcon() {
    try {
      final hour = int.parse(time.split(':')[0]);
      if (hour > 12) {
        return Icons.wb_twilight;
      }
    } catch (_) {}
    return Icons.wb_sunny_outlined;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppDimens.borderRadiusNormal),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimens.paddingNormal,
          vertical: AppDimens.paddingSmall,
        ),
        decoration: BoxDecoration(
          color: isSelected
              ? theme.colorScheme.primary
              : theme.colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(AppDimens.borderRadiusNormal),
          border: Border.all(
            color: isSelected
                ? theme.colorScheme.primary
                : theme.colorScheme.outline.withValues(alpha: 0.5),
          ),
        ),
        child: Row(
          spacing: AppDimens.paddingSmallest,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              _getIcon(),
              color: isSelected
                  ? theme.colorScheme.onPrimary
                  : theme.colorScheme.primary,
              size: AppDimens.iconSizeNormal,
            ),
            Text(
              time,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: isSelected
                    ? theme.colorScheme.onPrimary
                    : theme.colorScheme.onSurface,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
