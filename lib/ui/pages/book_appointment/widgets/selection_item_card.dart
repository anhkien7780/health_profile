import 'package:flutter/material.dart';
import 'package:health_profile/common/app_dimens.dart';
import 'package:health_profile/models/entities/selection_item.dart';

class SelectionItemCard extends StatelessWidget {
  const SelectionItemCard({
    super.key,
    required this.item,
    this.onTap,
  });

  final SelectionItem item;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      color: theme.colorScheme.surfaceContainerHighest,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          AppDimens.borderRadiusNormal,
        ),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(
          AppDimens.borderRadiusNormal,
        ),
        child: Padding(
          padding: const EdgeInsets.all(
            AppDimens.paddingNormal,
          ),
          child: Row(
            spacing: AppDimens.paddingSmall,
            children: [
              CircleAvatar(
                radius: AppDimens.avatarRadius,
                backgroundColor: theme.colorScheme.primaryContainer,
                backgroundImage: NetworkImage(item.imageUrl),
              ),
              Expanded(
                child: Column(
                  spacing: AppDimens.paddingSmallest,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.title,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      item.subtitle,
                      style: theme.textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
