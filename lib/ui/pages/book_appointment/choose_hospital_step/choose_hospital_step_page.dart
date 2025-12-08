import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_profile/common/app_dimens.dart';
import 'package:health_profile/generated/l10n.dart';
import 'package:health_profile/models/enum/loading_status.dart';
import 'package:health_profile/repositories/appointment_repository.dart';
import 'package:health_profile/ui/pages/book_appointment/book_appointment_cubit.dart';
import 'package:health_profile/ui/pages/book_appointment/book_appointment_navigator.dart';
import 'package:health_profile/ui/pages/book_appointment/choose_hospital_step/choose_hospital_step_cubit.dart';
import 'package:health_profile/ui/pages/book_appointment/choose_hospital_step/choose_hospital_step_state.dart';
import 'package:health_profile/ui/pages/book_appointment/widgets/appointment_method_card.dart';
import 'package:health_profile/ui/pages/book_appointment/widgets/selection_item_card.dart';
import 'package:health_profile/ui/widgets/app_loading/app_loading.dart';

class ChooseHospitalStepPage extends StatelessWidget {
  const ChooseHospitalStepPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChooseHospitalStepCubit(
        appointmentRepository: context.read<AppointmentRepository>(),
        navigator: BookAppointmentNavigator(context),
        bookAppointmentCubit: context.read<BookAppointmentCubit>(),
      ),
      child: const ChooseHospitalStepContent(),
    );
  }
}

class ChooseHospitalStepContent extends StatefulWidget {
  const ChooseHospitalStepContent({super.key});

  @override
  State<ChooseHospitalStepContent> createState() =>
      _ChooseHospitalStepContentState();
}

class _ChooseHospitalStepContentState extends State<ChooseHospitalStepContent> {
  late final ThemeData theme;
  late final S s;
  late final ChooseHospitalStepCubit _cubit;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    theme = Theme.of(context);
    s = S.of(context);
    _cubit = context.read<ChooseHospitalStepCubit>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChooseHospitalStepCubit, ChooseHospitalStepState>(
      buildWhen: (pre, current) => pre.loadingStatus != current.loadingStatus,
      builder: (context, state) {
        return AppLoadingOverlay(
          isLoading: state.loadingStatus == LoadingStatus.loading,
          child: SingleChildScrollView(
            child: Column(
              spacing: AppDimens.paddingNormal,
              children: [
                BlocBuilder<ChooseHospitalStepCubit, ChooseHospitalStepState>(
                  buildWhen: (pre, current) => pre.hospital != current.hospital,
                  builder: (context, state) {
                    return state.hospital == null
                        ? AppointmentMethodCard(
                            iconData: Icons.medical_services,
                            title: s.selectHospital,
                            subtitle: s.selectHospitalDesc,
                            onTap: () async {
                              await _cubit.onChooseHospitalPressed();
                            },
                          )
                        : SelectionItemCard(
                            item: state.hospital!,
                            onTap: () async {
                              await _cubit.onChooseHospitalPressed();
                            },
                          );
                  },
                ),
                BlocBuilder<ChooseHospitalStepCubit, ChooseHospitalStepState>(
                  buildWhen: (pre, current) => pre.doctor != current.doctor,
                  builder: (context, state) {
                    return state.doctor == null
                        ? AppointmentMethodCard(
                            iconData: Icons.person_search,
                            title: s.selectDoctor,
                            subtitle: s.selectDoctorDesc,
                            onTap: () async {
                              await _cubit.onChooseDoctorPressed();
                            },
                          )
                        : SelectionItemCard(
                            item: state.doctor!,
                            onTap: () async {
                              await _cubit.onChooseDoctorPressed();
                            },
                          );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
