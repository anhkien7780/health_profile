import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_profile/common/app_dimens.dart';
import 'package:health_profile/generated/l10n.dart';
import 'package:health_profile/models/entities/user_profile.dart';
import 'package:health_profile/ui/pages/home/home_cubit.dart';
import 'package:health_profile/ui/widgets/buttons/app_elevated_button.dart';
import 'package:health_profile/ui/widgets/text_fileds/app_text_form_field.dart';

class ProfileBody extends StatelessWidget {
  const ProfileBody({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<HomeCubit>(context);
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
                onTap: () async {
                  await showDialog(
                    context: context,
                    builder: (_) {
                      return _createEditDialog(context: context);
                    },
                  );
                },
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
            userProfile: cubit.state.userProfile!,
          ),
          Text(S.of(context).security, style: theme.textTheme.titleMedium),
          InkWell(
            onTap: () {},
            child: Ink(
              decoration: BoxDecoration(
                border: Border.all(
                  color: theme.colorScheme.outline.withAlpha(24),
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
                  color: theme.colorScheme.outline.withAlpha(24),
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
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        border: Border.all(color: theme.colorScheme.outline.withAlpha(24)),
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
            Divider(height: 1, color: theme.colorScheme.outline),
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

  Widget _createEditDialog({required BuildContext context}) {
    final theme = Theme.of(context);
    final cubit = BlocProvider.of<HomeCubit>(context);
    final s = S.of(context);

    Icon createPrimaryColorIcon({required IconData iconData}) =>
        Icon(iconData, color: theme.colorScheme.primary);

    return AlertDialog(
      content: Container(
        width: 350,
        height: 472,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppDimens.borderRadiusNormal),
        ),
        child: SingleChildScrollView(
          child: Column(
            spacing: AppDimens.paddingNormal,
            children: [
              Text(
                s.editProfileTitle,
                style: theme.textTheme.titleLarge?.copyWith(
                  color: theme.colorScheme.onSurface,
                ),
              ),
              AppTextFormField(
                title: s.fullName,
                prefixIcon: createPrimaryColorIcon(iconData: Icons.person),
                hint: cubit.state.userProfile?.fullName,
              ),
              AppTextFormField(
                title: s.birthday,
                readOnly: true,
                prefixIcon: createPrimaryColorIcon(iconData: Icons.cake_outlined),
                hint: cubit.state.userProfile?.birthDay,
                suffixIcon:
                createPrimaryColorIcon(iconData: Icons.calendar_today_outlined),
                onTap: () {},
              ),
              AppTextFormField(
                title: s.phoneNumber,
                prefixIcon: createPrimaryColorIcon(iconData: Icons.phone_outlined),
                hint: cubit.state.userProfile?.phoneNumber,
              ),
              AppTextFormField(
                title: s.email,
                prefixIcon: createPrimaryColorIcon(iconData: Icons.mail_outline),
                hint: cubit.state.userProfile?.email ?? "N/A",
              ),
              AppTextFormField(
                title: s.gender,
                prefixIcon: createPrimaryColorIcon(iconData: Icons.wc_outlined),
                hint: cubit.state.userProfile?.gender,
              ),
              AppTextFormField(
                title: s.id,
                prefixIcon: createPrimaryColorIcon(iconData: Icons.badge),
                hint: cubit.state.userProfile?.id,
              ),
              AppTextFormField(
                title: s.address,
                prefixIcon: createPrimaryColorIcon(iconData: Icons.place_outlined),
                hint: cubit.state.userProfile?.address,
              ),
              SizedBox(
                height: AppDimens.buttonHeightSmall,
                child: Row(
                  spacing: AppDimens.paddingSmall,
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          s.cancel,
                          style: theme.textTheme.labelLarge?.copyWith(
                            color: theme.colorScheme.onSurface,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: AppElevatedButton(
                        onClick: () {},
                        text: s.save,
                      ),
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
