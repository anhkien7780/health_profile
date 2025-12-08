import 'package:flutter/material.dart';
import 'package:health_profile/common/app_dimens.dart';

class SelectionBottomSheet extends StatelessWidget {
  const SelectionBottomSheet({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.9,
      minChildSize: 0.5,
      maxChildSize: 0.95,
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
              // Search Bar
              SearchBar(
                hintText: "Nhập tên $title", // Simple localization placeholder
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
                  theme.colorScheme.surfaceContainerHighest.withValues(
                    alpha: 0.3,
                  ),
                ),
                shape: WidgetStateProperty.all(const StadiumBorder()),
              ),
              
              // List
              Expanded(
                child: ListView.separated(
                  controller: scrollController,
                  itemCount: 10, // Mock data count
                  separatorBuilder:
                      (context, index) =>
                          const SizedBox(height: AppDimens.paddingSmall),
                  itemBuilder: (context, index) {
                    return Card(
                      elevation: 0,
                      color: theme.colorScheme.surfaceContainerHighest.withValues(
                        alpha: 0.3,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          AppDimens.borderRadiusNormal,
                        ),
                      ),
                      child: InkWell(
                        onTap: () {
                          // Handle selection
                        },
                        borderRadius: BorderRadius.circular(
                          AppDimens.borderRadiusNormal,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(
                            AppDimens.paddingNormal,
                          ),
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 20,
                                backgroundColor: theme.colorScheme.primary,
                                child: Text(
                                  "A",
                                  style: TextStyle(
                                    color: theme.colorScheme.onPrimary,
                                  ),
                                ),
                              ),
                              const SizedBox(width: AppDimens.paddingNormal),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "$title ${String.fromCharCode(65 + index)}",
                                      style: theme.textTheme.titleMedium,
                                    ),
                                    Text(
                                      "Khoa Nội tiết",
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
