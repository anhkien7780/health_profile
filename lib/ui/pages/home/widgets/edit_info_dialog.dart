import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_profile/common/app_dimens.dart';
import 'package:health_profile/generated/l10n.dart';
import 'package:health_profile/models/entities/user_profile.dart';
import 'package:health_profile/models/enum/gender.dart';
import 'package:health_profile/ui/pages/home/home_cubit.dart';
import 'package:health_profile/ui/widgets/buttons/app_elevated_button.dart';
import 'package:health_profile/ui/widgets/text_fields/app_text_form_field.dart';
import 'package:health_profile/utils/date_format_helper.dart';

class EditInfoDialog extends StatefulWidget {
  const EditInfoDialog({super.key, required this.userProfile});

  final UserProfile? userProfile;

  @override
  State<EditInfoDialog> createState() => _EditInfoDialogState();
}

class _EditInfoDialogState extends State<EditInfoDialog> {
  late HomeCubit cubit;
  late UserProfile? userProfile;
  late TextEditingController birthDayTextController;
  late TextEditingController genderTextController;
  late TextEditingController fullNameTextController;
  late TextEditingController phoneNumberTextController;
  late TextEditingController emailTextController;
  late TextEditingController idTextController;
  late TextEditingController addressTextController;
  late TextEditingController emergencyContactController;
  late TextEditingController bloodTypeController;
  late TextEditingController allergiesController;
  bool _isInit = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isInit) {
      userProfile = widget.userProfile;
      cubit = context.read<HomeCubit>();

      birthDayTextController = TextEditingController(
        text: userProfile?.birthDay,
      );
      genderTextController = TextEditingController(
        text: userProfile?.gender == Gender.male
            ? S.of(context).male
            : S.of(context).female,
      );
      fullNameTextController = TextEditingController(
        text: userProfile?.fullName,
      );
      phoneNumberTextController = TextEditingController(
        text: userProfile?.phoneNumber,
      );
      emailTextController = TextEditingController(text: userProfile?.email);
      idTextController = TextEditingController(text: userProfile?.id);
      addressTextController = TextEditingController(text: userProfile?.address);
      emergencyContactController = TextEditingController(
        text: userProfile?.emergencyContact,
      );
      bloodTypeController = TextEditingController(text: userProfile?.bloodType);
      allergiesController = TextEditingController(text: userProfile?.allergies);
      _isInit = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Container(
        width: 350,
        height: 600,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppDimens.borderRadiusNormal),
        ),
        child: SingleChildScrollView(
          child: Column(
            spacing: AppDimens.paddingNormal,
            children: [
              _buildTitle(),
              _buildContentBody(),
              _buildBottomButtons(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Text(
      S.of(context).editProfileTitle,
      style: Theme.of(context).textTheme.titleLarge?.copyWith(
        color: Theme.of(context).colorScheme.onSurface,
      ),
    );
  }

  Widget _buildContentBody() {
    final s = S.of(context);
    final theme = Theme.of(context);
    Icon createPrimaryColorIcon({required IconData iconData}) =>
        Icon(iconData, color: theme.colorScheme.primary);
    return Column(
      spacing: AppDimens.paddingNormal,
      children: [
        AppTextFormField(
          title: s.fullName,
          controller: fullNameTextController,
          prefixIcon: createPrimaryColorIcon(iconData: Icons.person),
          hint: userProfile?.fullName,
        ),
        AppTextFormField(
          controller: birthDayTextController,
          title: s.birthday,
          readOnly: true,
          hint: userProfile?.birthDay,
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
              birthDayTextController.text = dateString;
            }
          },
        ),
        AppTextFormField(
          title: s.phoneNumber,
          controller: phoneNumberTextController,
          prefixIcon: createPrimaryColorIcon(iconData: Icons.phone_outlined),
          hint: userProfile?.phoneNumber,
        ),
        AppTextFormField(
          title: s.email,
          controller: emailTextController,
          prefixIcon: createPrimaryColorIcon(iconData: Icons.mail_outline),
          hint: userProfile?.email ?? s.notAvailable,
        ),
        AppTextFormField(
          controller: genderTextController,
          readOnly: true,
          onTap: () {
            setState(() {
              userProfile = userProfile?.copyWith(
                gender: userProfile?.gender == Gender.male
                    ? Gender.female
                    : Gender.male,
              );
              genderTextController.text = userProfile?.gender == Gender.male
                  ? S.of(context).male
                  : S.of(context).female;
            });
          },
          title: s.gender,
          prefixIcon: createPrimaryColorIcon(iconData: Icons.wc_outlined),
          hint: userProfile?.gender == Gender.male
              ? S.of(context).male
              : S.of(context).female,
        ),
        AppTextFormField(
          title: s.id,
          controller: idTextController,
          prefixIcon: createPrimaryColorIcon(iconData: Icons.badge),
          hint: userProfile?.id,
        ),
        AppTextFormField(
          title: s.address,
          controller: addressTextController,
          prefixIcon: createPrimaryColorIcon(iconData: Icons.place_outlined),
          hint: userProfile?.address,
        ),
        AppTextFormField(
          title: s.emergencyContact,
          controller: emergencyContactController,
          prefixIcon: createPrimaryColorIcon(
            iconData: Icons.contact_emergency_outlined,
          ),
          hint: userProfile?.emergencyContact ?? s.notAvailable,
        ),
        AppTextFormField(
          title: s.bloodType,
          controller: bloodTypeController,
          prefixIcon: createPrimaryColorIcon(
            iconData: Icons.bloodtype_outlined,
          ),
          hint: userProfile?.bloodType ?? s.notAvailable,
        ),
        AppTextFormField(
          title: s.allergies,
          controller: allergiesController,
          prefixIcon: createPrimaryColorIcon(
            iconData: Icons.warning_amber_outlined,
          ),
          hint: userProfile?.allergies ?? s.notAvailable,
        ),
      ],
    );
  }

  Widget _buildBottomButtons() {
    return SizedBox(
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
                S.of(context).cancel,
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
            ),
          ),
          Expanded(
            child: AppElevatedButton(
              onClick: () {
                cubit.updateUserProfile(
                  fullName: fullNameTextController.text,
                  birthDay: birthDayTextController.text,
                  phoneNumber: phoneNumberTextController.text,
                  email: emailTextController.text,
                  gender: genderTextController.text == S.of(context).male
                      ? Gender.male
                      : Gender.female,
                  id: idTextController.text,
                  address: addressTextController.text,
                  emergencyContact: emergencyContactController.text,
                  bloodType: bloodTypeController.text,
                  allergies: allergiesController.text,
                );
                Navigator.pop(context);
              },
              text: S.of(context).save,
            ),
          ),
        ],
      ),
    );
  }
}
