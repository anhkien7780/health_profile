import 'package:flutter/material.dart';
import 'package:health_profile/common/app_dimens.dart';
import 'package:health_profile/models/entities/selection_item.dart';

class SelectionBottomSheet extends StatelessWidget {
  const SelectionBottomSheet({
    super.key,
    required this.searchHint,
    required this.items,
    required this.onItemSelected,
  });

  final String searchHint;
  final List<SelectionItem> items;
  final Function(SelectionItem) onItemSelected;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.8,
      minChildSize: 0.5,
      maxChildSize: 0.8,
      builder: (context, scrollController) {
        return Container(
          padding: const EdgeInsets.all(AppDimens.paddingNormal),
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(AppDimens.borderRadiusNormal),
            ),
          ),
          child: Column(
            spacing: AppDimens.paddingNormal,
            children: [
              SearchBar(
                hintText: searchHint,
                leading: const Icon(Icons.search),
                trailing: [
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
                elevation: WidgetStateProperty.all(0),
                backgroundColor: WidgetStateProperty.all(
                  theme.colorScheme.surfaceContainerHighest,
                ),
                shape: WidgetStateProperty.all(const StadiumBorder()),
              ),
              Expanded(
                child: ListView.separated(
                  controller: scrollController,
                  itemCount: items.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: AppDimens.paddingSmall),
                  itemBuilder: (context, index) {
                    final item = items[index];
                    return Card(
                      color: theme.colorScheme.surfaceContainerHighest,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          AppDimens.borderRadiusNormal,
                        ),
                      ),
                      child: InkWell(
                        onTap: () {
                          onItemSelected(item);
                          Navigator.pop(context);
                        },
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
                                backgroundColor:
                                    theme.colorScheme.primaryContainer,
                                backgroundImage: NetworkImage(item.imageUrl),
                              ),
                              Expanded(
                                child: Column(
                                  spacing: AppDimens.paddingSmallest,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item.title,
                                      style: theme.textTheme.titleMedium
                                          ?.copyWith(
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
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
