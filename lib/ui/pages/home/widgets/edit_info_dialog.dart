import 'package:flutter/material.dart';
import 'package:health_profile/common/app_dimens.dart';
import 'package:health_profile/generated/l10n.dart';
import 'package:health_profile/models/entities/user_profile.dart';
import 'package:health_profile/models/enum/gender.dart';
import 'package:health_profile/ui/widgets/buttons/app_elevated_button.dart';
import 'package:health_profile/ui/widgets/text_fileds/app_text_form_field.dart';
import 'package:health_profile/utils/date_format_helper.dart';

class EditInfoDialog extends StatefulWidget {
  const EditInfoDialog({super.key, required this.userProfile});

  final UserProfile userProfile;

  @override
  State<EditInfoDialog> createState() => _EditInfoDialogState();
}

class _EditInfoDialogState extends State<EditInfoDialog> {
  late UserProfile userProfile;
  late TextEditingController birthDayTextController;
  late TextEditingController genderTextController;

  @override
  void initState() {
    super.initState();
    userProfile = widget.userProfile;
    birthDayTextController = TextEditingController();
    genderTextController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
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
                hint: userProfile.fullName,
              ),
              AppTextFormField(
                controller: birthDayTextController,
                title: s.birthday,
                readOnly: true,
                hint: userProfile.birthDay,
                prefixIcon: createPrimaryColorIcon(
                  iconData: Icons.cake_outlined,
                ),
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
                    final dateString = DateFormatHelper.dateToString(
                      selectedDate,
                    );
                    setState(() {
                      userProfile = userProfile.copyWith(birthDay: dateString);
                      birthDayTextController.text = userProfile.birthDay;
                    });
                  }
                },
              ),
              AppTextFormField(
                title: s.phoneNumber,
                prefixIcon: createPrimaryColorIcon(
                  iconData: Icons.phone_outlined,
                ),
                hint: userProfile.phoneNumber,
              ),
              AppTextFormField(
                title: s.email,
                prefixIcon: createPrimaryColorIcon(
                  iconData: Icons.mail_outline,
                ),
                hint: userProfile.email ?? "N/A",
              ),
              AppTextFormField(
                controller: genderTextController,
                readOnly: true,
                onTap: () {
                  setState(() {
                    userProfile = userProfile.copyWith(
                      gender: userProfile.gender == Gender.male
                          ? Gender.female
                          : Gender.male,
                    );
                    genderTextController.text =
                        userProfile.gender == Gender.male
                        ? S.of(context).male
                        : S.of(context).female;
                  });
                },
                title: s.gender,
                prefixIcon: createPrimaryColorIcon(iconData: Icons.wc_outlined),
                hint: userProfile.gender == Gender.male
                    ? S.of(context).male
                    : S.of(context).female,
              ),
              AppTextFormField(
                title: s.id,
                prefixIcon: createPrimaryColorIcon(iconData: Icons.badge),
                hint: userProfile.id,
              ),
              AppTextFormField(
                title: s.address,
                prefixIcon: createPrimaryColorIcon(
                  iconData: Icons.place_outlined,
                ),
                hint: userProfile.address,
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
                      child: AppElevatedButton(onClick: () {}, text: s.save),
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
