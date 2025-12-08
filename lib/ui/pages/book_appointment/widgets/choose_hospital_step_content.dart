import 'package:flutter/material.dart';
import 'package:health_profile/common/app_dimens.dart';
import 'package:health_profile/generated/l10n.dart';
import 'package:health_profile/ui/pages/book_appointment/widgets/appointment_method_card.dart';
import 'package:health_profile/ui/pages/book_appointment/widgets/selection_bottom_sheet.dart';

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

  void _showSelectionSheet(String title) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => SelectionBottomSheet(title: title),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        spacing: AppDimens.paddingNormal,
        children: [
          AppointmentMethodCard(
            iconData: Icons.medical_services,
            title: s.selectHospital,
            subtitle: s.selectHospitalDesc,
            onTap: () => _showSelectionSheet(s.doctor), // Using generic title for demo
          ),
          AppointmentMethodCard(
            iconData: Icons.person_search,
            title: s.selectDoctor,
            subtitle: s.selectDoctorDesc,
            onTap: () => _showSelectionSheet(s.doctor),
          ),
        ],
      ),
    );
  }
}
