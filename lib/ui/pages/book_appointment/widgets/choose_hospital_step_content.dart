import 'package:flutter/material.dart';
import 'package:health_profile/common/app_dimens.dart';
import 'package:health_profile/generated/l10n.dart';

class ChooseHospitalStepContent extends StatefulWidget {
  const ChooseHospitalStepContent({super.key});

  @override
  State<ChooseHospitalStepContent> createState() =>
      _ChooseHospitalStepContentState();
}

class _ChooseHospitalStepContentState extends State<ChooseHospitalStepContent> {
  late final ThemeData theme;
  late final S s;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    theme = Theme.of(context);
    s = S.of(context);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        spacing: AppDimens.paddingNormal,
        children: [
          _buildCardButton(
            iconData: Icons.medical_services,
            title: s.selectHospital,
            subtitle: s.selectHospitalDesc,
            onTap: () {},
          ),
          _buildCardButton(
            iconData: Icons.person_search,
            title: s.selectDoctor,
            subtitle: s.selectDoctorDesc,
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildCardButton({
    required IconData iconData,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppDimens.borderRadiusNormal),
      child: Container(
        height: AppDimens.buttonBookMethodHeight,
        padding: const EdgeInsets.all(AppDimens.paddingNormal),
        decoration: BoxDecoration(
          color: theme.colorScheme.primary,
          borderRadius: BorderRadius.circular(AppDimens.borderRadiusNormal),
        ),
        child: Row(
          spacing: AppDimens.paddingNormal,
          children: [
            Container(
              padding: const EdgeInsets.all(AppDimens.paddingSmall),
              decoration: BoxDecoration(
                color: theme.colorScheme.inversePrimary,
                borderRadius: BorderRadius.circular(
                  AppDimens.borderRadiusNormal,
                ),
              ),
              child: Icon(
                iconData,
                size: AppDimens.iconSizeNormal,
                color: theme.colorScheme.onPrimary,
              ),
            ),
            Expanded(
              child: Column(
                spacing: AppDimens.paddingSmallest,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: theme.textTheme.titleSmall?.copyWith(
                      color: theme.colorScheme.onPrimary,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onPrimary.withValues(alpha: 0.9),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
