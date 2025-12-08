import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_profile/common/app_dimens.dart';
import 'package:health_profile/generated/l10n.dart';
import 'package:health_profile/ui/pages/book_appointment/book_appointment_cubit.dart';
import 'package:health_profile/ui/pages/book_appointment/book_appointment_state.dart';
import 'package:health_profile/ui/pages/book_appointment/widgets/appointment_method_card.dart';

class ChooseHospitalStepContent extends StatefulWidget {
  const ChooseHospitalStepContent({super.key});

  @override
  State<ChooseHospitalStepContent> createState() =>
      _ChooseHospitalStepContentState();
}

class _ChooseHospitalStepContentState extends State<ChooseHospitalStepContent> {
  late final ThemeData theme;
  late final S s;
  late final BookAppointmentCubit _cubit;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    theme = Theme.of(context);
    s = S.of(context);
    _cubit = context.read<BookAppointmentCubit>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookAppointmentCubit, BookAppointmentState>(
      builder: (context, state) {
        return SingleChildScrollView(
          child: Column(
            spacing: AppDimens.paddingNormal,
            children: [
              AppointmentMethodCard(
                iconData: Icons.medical_services,
                title: s.selectHospital,
                subtitle: s.selectHospitalDesc,
                onTap: () async {
                  await _cubit.onChooseHospitalPressed();
                },
              ),
              AppointmentMethodCard(
                iconData: Icons.person_search,
                title: s.selectDoctor,
                subtitle: s.selectDoctorDesc,
                onTap: () async {
                  await _cubit.onChooseDoctorPressed();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
