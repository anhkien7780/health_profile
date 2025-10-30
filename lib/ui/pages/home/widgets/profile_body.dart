import 'package:flutter/material.dart';
import 'package:health_profile/common/app_dimens.dart';
import 'package:health_profile/generated/l10n.dart';
import 'package:health_profile/models/entities/user_profile.dart';

class ProfileBody extends StatelessWidget {
  const ProfileBody({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: AppDimens.paddingNormal,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                S.of(context).personalInformation,
                style: theme.textTheme.titleMedium,
              ),
              InkWell(
                onTap: () {},
                child: Row(
                  spacing: AppDimens.paddingSmall,
                  children: [
                    Text(
                      S.of(context).edit,
                      style: theme.textTheme.titleMedium,
                    ),
                    Icon(
                      Icons.edit_outlined,
                      color: theme.colorScheme.onSurface,
                    ),
                  ],
                ),
              ),
            ],
          ),
          _createPersonInformationListView(
            context: context,
            userProfile: UserProfile(
              fullName: "Nguyễn Văn Kiên",
              birthDay: "27/10/2002",
              phoneNumber: "0123423543",
              username: "NgVanKien",
              gender: "Nam",
              id: "030202005908",
              address: "Phú Quý Bò Viên 1",
            ),
          ),
          Text(
            S.of(context).security,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          InkWell(
            onTap: () {},
            child: Ink(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Theme.of(context).colorScheme.outline.withAlpha(24),
                ),
                borderRadius: BorderRadius.circular(
                  AppDimens.borderRadiusNormal,
                ),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 4,
                    offset: Offset(0, 4),
                    color: Colors.black.withAlpha(24),
                  ),
                ],
                color: theme.colorScheme.surface,
              ),
              child: ListTile(
                leading: Icon(Icons.lock_outline),
                title: Text(S.of(context).changePassword),
                trailing: Icon(Icons.chevron_right),
              ),
            ),
          ),
          InkWell(
            onTap: () {},
            child: Ink(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Theme.of(context).colorScheme.outline.withAlpha(24),
                ),
                borderRadius: BorderRadius.circular(
                  AppDimens.borderRadiusNormal,
                ),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 4,
                    offset: Offset(0, 4),
                    color: Colors.black.withAlpha(24),
                  ),
                ],
                color: theme.colorScheme.surface,
              ),
              child: ListTile(
                leading: Icon(Icons.logout),
                title: Text(S.of(context).logout),
                trailing: Icon(Icons.chevron_right),
              ),
            ),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget _createPersonInformationListView({
    required BuildContext context,
    required UserProfile userProfile,
  }) {
    final infoList = userProfile.toInfoList();
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        border: Border.all(
          color: Theme.of(context).colorScheme.outline.withAlpha(24),
        ),
        borderRadius: BorderRadius.circular(AppDimens.borderRadiusNormal),
        boxShadow: [
          BoxShadow(
            blurRadius: 4,
            offset: Offset(0, 4),
            color: Colors.black.withAlpha(24),
          ),
        ],
      ),
      child: ListView.separated(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: infoList.length,
        separatorBuilder: (context, index) =>
            Divider(height: 1, color: Theme.of(context).colorScheme.outline),
        itemBuilder: (context, index) {
          final info = infoList[index];
          return ListTile(
            leading: Icon(info["icon"]),
            title: Text(info["label"]),
            subtitle: Text(info["value"]),
          );
        },
      ),
    );
  }
}
