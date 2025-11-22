import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_profile/common/app_dimens.dart';
import 'package:health_profile/generated/l10n.dart';
import 'package:health_profile/models/enum/gender.dart';
import 'package:health_profile/ui/pages/profile_register/profile_register_cubit.dart';
import 'package:health_profile/ui/pages/profile_register/profile_register_navigator.dart';
import 'package:health_profile/ui/widgets/buttons/app_elevated_button.dart';
import 'package:health_profile/ui/widgets/text_fields/app_text_form_field.dart';
import 'package:health_profile/utils/date_format_helper.dart';

class ProfileRegisterPage extends StatelessWidget {
  const ProfileRegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProfileRegisterCubit>(
      create: (context) {
        return ProfileRegisterCubit(
          navigator: ProfileRegisterNavigator(context),
        );
      },
      child: ProfileRegisterChildPage(),
    );
  }
}

class ProfileRegisterChildPage extends StatefulWidget {
  const ProfileRegisterChildPage({super.key});

  @override
  State<ProfileRegisterChildPage> createState() =>
      _ProfileRegisterChildPageState();
}

class _ProfileRegisterChildPageState extends State<ProfileRegisterChildPage> {
  late final ProfileRegisterCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = context.read<ProfileRegisterCubit>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: _createAppBar(),
      bottomNavigationBar: _createCompletedButton(),
      body: _createBody(),
    );
  }

  AppBar _createAppBar() {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.primaryFixedDim,
      centerTitle: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(AppDimens.borderRadiusBig),
          bottomRight: Radius.circular(AppDimens.borderRadiusBig),
        ),
      ),
      title: Text(
        S.of(context).profileRegister,
        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
          color: Theme.of(context).colorScheme.onPrimaryFixed,
        ),
      ),
    );
  }

  Widget _createBody() {
    final s = S.of(context);
    final theme = Theme.of(context);
    Icon createPrimaryColorIcon({required IconData iconData}) =>
        Icon(iconData, color: theme.colorScheme.primary);
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppDimens.paddingNormal),
      child: Column(
        spacing: AppDimens.paddingNormal,
        children: [
          AppTextFormField(
            title: s.fullName,
            controller: _cubit.fullNameTextController,
            prefixIcon: createPrimaryColorIcon(iconData: Icons.person),
            hint: s.fullName,
          ),
          AppTextFormField(
            controller: _cubit.birthDayTextController,
            title: s.birthday,
            readOnly: true,
            hint: s.birthday,
            prefixIcon: createPrimaryColorIcon(iconData: Icons.cake_outlined),
            suffixIcon: createPrimaryColorIcon(
              iconData: Icons.calendar_today_outlined,
            ),
            onTap: () async {
              final selectedDate = await showDatePicker(
                context: context,
                firstDate: DateTime(1900),
                lastDate: DateTime.now(),
                cancelText: S.of(context).cancel,
              );
              if (selectedDate != null) {
                final dateString = DateFormatHelper.dateToString(selectedDate);
                _cubit.birthDayTextController.text = dateString;
              }
            },
          ),
          AppTextFormField(
            title: s.phoneNumber,
            controller: _cubit.phoneNumberTextController,
            prefixIcon: createPrimaryColorIcon(iconData: Icons.phone_outlined),
            hint: s.phoneNumber,
          ),
          AppTextFormField(
            title: s.email,
            controller: _cubit.emailTextController,
            prefixIcon: createPrimaryColorIcon(iconData: Icons.mail_outline),
            hint: s.email,
          ),
          AppTextFormField(
            controller: _cubit.genderTextController,
            readOnly: true,
            onTap: () {
              _cubit.changeGender();
            },
            title: s.gender,
            prefixIcon: createPrimaryColorIcon(iconData: Icons.wc_outlined),
            hint: s.gender == Gender.male.name
                ? S.of(context).male
                : S.of(context).female,
          ),
          AppTextFormField(
            title: s.id,
            controller: _cubit.idTextController,
            prefixIcon: createPrimaryColorIcon(iconData: Icons.badge),
            hint: s.id,
          ),
          AppTextFormField(
            title: s.address,
            controller: _cubit.addressTextController,
            prefixIcon: createPrimaryColorIcon(iconData: Icons.place_outlined),
            hint: s.address,
          ),
        ],
      ),
    );
  }

  Widget _createCompletedButton() {
    return Padding(
      padding: EdgeInsets.only(
        left: AppDimens.paddingNormal,
        right: AppDimens.paddingNormal,
        bottom:
            MediaQuery.of(context).viewInsets.bottom + AppDimens.paddingNormal,
      ),
      child: AppElevatedButton(
        height: AppDimens.buttonHeightNormal,
        onClick: () async {
          await _cubit.onCompletedButtonPressed();
        },
        text: S.of(context).completed,
      ),
    );
  }
}
