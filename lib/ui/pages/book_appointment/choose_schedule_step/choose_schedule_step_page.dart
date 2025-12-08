import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_profile/common/app_dimens.dart';
import 'package:health_profile/models/enum/loading_status.dart';
import 'package:health_profile/repositories/appointment_repository.dart';
import 'package:health_profile/ui/pages/book_appointment/book_appointment_cubit.dart';
import 'package:health_profile/ui/pages/book_appointment/choose_schedule_step/choose_schedule_step_cubit.dart';
import 'package:health_profile/ui/pages/book_appointment/choose_schedule_step/choose_schedule_step_state.dart';
import 'package:health_profile/ui/pages/book_appointment/choose_schedule_step/widgets/choose_time_section.dart';
import 'package:health_profile/ui/pages/book_appointment/choose_schedule_step/widgets/date_picker_section.dart';
import 'package:health_profile/ui/widgets/app_loading/app_loading.dart';

class ChooseScheduleStepPage extends StatelessWidget {
  const ChooseScheduleStepPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChooseScheduleStepCubit(
        bookAppointmentCubit: context.read<BookAppointmentCubit>(),
        appointmentRepository: context.read<AppointmentRepository>(),
      ),
      child: const ChooseScheduleStepContent(),
    );
  }
}

class ChooseScheduleStepContent extends StatelessWidget {
  const ChooseScheduleStepContent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<
      ChooseScheduleStepCubit,
      ChooseScheduleStepState,
      LoadingStatus
    >(
      selector: (state) => state.loadingStatus,
      builder: (context, loadingStatus) {
        return AppLoadingOverlay(
          isLoading: loadingStatus == LoadingStatus.loading,
          child: SingleChildScrollView(
            child: Column(
              spacing: AppDimens.paddingNormal,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [DatePickerSection(), ChooseTimeSection()],
            ),
          ),
        );
      },
    );
  }
}
