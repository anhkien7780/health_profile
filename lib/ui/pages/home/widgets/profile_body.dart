import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_profile/common/app_dimens.dart';
import 'package:health_profile/generated/l10n.dart';
import 'package:health_profile/models/entities/user_profile.dart';
import 'package:health_profile/ui/pages/home/home_cubit.dart';
import 'package:health_profile/ui/pages/home/home_state.dart';
import 'package:health_profile/ui/pages/home/widgets/edit_info_dialog.dart';

class ProfileBody extends StatefulWidget {
  const ProfileBody({super.key});

  @override
  State<ProfileBody> createState() => _ProfileBodyState();
}

class _ProfileBodyState extends State<ProfileBody> {
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
              _createEditButton(),
            ],
          ),
          BlocBuilder<HomeCubit, HomeState>(
            buildWhen: (previous, current) =>
                previous.userProfile != current.userProfile,
            builder: (context, state) {
              return _createPersonInformationListView(
                context: context,
                userProfile: cubit.state.userProfile,
              );
            },
          ),
          Text(S.of(context).security, style: theme.textTheme.titleMedium),
          _createChangePasswordButton(),
          _createLogoutButton(),
          SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget _createEditButton() {
    return InkWell(
      onTap: () async {
        await showDialog(
          context: context,
          builder: (_) {
            return BlocProvider.value(
              value: BlocProvider.of<HomeCubit>(context),
              child: EditInfoDialog(
                userProfile: context.read<HomeCubit>().state.userProfile,
              ),
            );
          },
        );
      },
      child: Row(
        spacing: AppDimens.paddingSmall,
        children: [
          Text(
            S.of(context).edit,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          Icon(
            Icons.edit_outlined,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ],
      ),
    );
  }

  Widget _createChangePasswordButton() {
    return InkWell(
      onTap: () {},
      child: Ink(
        decoration: BoxDecoration(
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
          color: Theme.of(context).colorScheme.surface,
        ),
        child: ListTile(
          leading: Icon(Icons.lock_outline),
          title: Text(S.of(context).changePassword),
          trailing: Icon(Icons.chevron_right),
        ),
      ),
    );
  }

  Widget _createLogoutButton() {
    return InkWell(
      onTap: () {},
      child: Ink(
        decoration: BoxDecoration(
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
          color: Theme.of(context).colorScheme.surface,
        ),
        child: ListTile(
          leading: Icon(Icons.logout),
          title: Text(S.of(context).logout),
          trailing: Icon(Icons.chevron_right),
        ),
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
}
