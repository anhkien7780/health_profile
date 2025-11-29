import 'package:flutter/material.dart';
import 'package:health_profile/common/app_dimens.dart';
import 'package:health_profile/common/app_images.dart';
import 'package:health_profile/generated/l10n.dart';

class ChatBody extends StatelessWidget {
  const ChatBody({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: AppDimens.paddingNormal,
      children: [
        Text(
          S.of(context).conversations,
          style: theme.textTheme.titleSmall?.copyWith(color: Colors.black),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: 2,
            itemBuilder: (context, index) {
              return ListTile(
                tileColor: theme.colorScheme.surface,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(AppDimens.borderRadiusNormal),
                  ),
                ),
                title: Text(
                  "Doctor A",
                  style: theme.textTheme.titleLarge?.copyWith(
                    color: theme.colorScheme.onSurface,
                  ),
                ),
                subtitle: Text(
                  "Doctor A: Your balls is not good, you need do surgery",
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurface,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                leading: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  radius: AppDimens.iconChatRadius,
                  backgroundImage: AssetImage(AppImages.icDoctor),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
