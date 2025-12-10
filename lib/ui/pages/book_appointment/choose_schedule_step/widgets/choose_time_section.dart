import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_profile/common/app_dimens.dart';
import 'package:health_profile/configs/app_configs.dart';
import 'package:health_profile/generated/l10n.dart';
import 'package:health_profile/ui/pages/book_appointment/choose_schedule_step/choose_schedule_step_cubit.dart';
import 'package:health_profile/ui/pages/book_appointment/choose_schedule_step/choose_schedule_step_state.dart';
import 'package:health_profile/ui/pages/book_appointment/choose_schedule_step/widgets/choose_time_bottom_sheet.dart';
import 'package:health_profile/ui/pages/book_appointment/choose_schedule_step/widgets/time_slot_item.dart';
import 'package:health_profile/ui/widgets/buttons/app_elevated_button.dart';

class ChooseTimeSection extends StatelessWidget {
  const ChooseTimeSection({super.key});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final theme = Theme.of(context);
    final cubit = context.read<ChooseScheduleStepCubit>();

    return BlocBuilder<ChooseScheduleStepCubit, ChooseScheduleStepState>(
      buildWhen: (previous, current) =>
          previous.selectedDate != current.selectedDate ||
          previous.selectedTime != current.selectedTime ||
          previous.roomName != current.roomName,
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: AppDimens.paddingNormal,
          children: [
            if (state.selectedDate != null) ...[
              Text(
                s.chooseTime,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              if (state.selectedTime != null)
                Column(
                  spacing: AppDimens.paddingSmall,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TimeSlotItem(
                      time: AppConfigs.timeFormat.format(state.selectedTime!),
                      isSelected: true,
                      onTap: () => _showTimeSelectionBottomSheet(context, cubit),
                    ),
                    if (state.roomName != null)
                      Text(
                        state.roomName!,
                        style: theme.textTheme.bodyLarge?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                  ],
                )
              else
                AppElevatedButton(
                  onClick: () => _showTimeSelectionBottomSheet(context, cubit),
                  text: s.chooseTimeButton,
                  width: double.infinity,
                  height: AppDimens.buttonHeightNormal,
                  prefixIcon: Icon(
                    Icons.access_time,
                    color: theme.colorScheme.onPrimary,
                  ),
                ),
            ] else ...[
              Center(child: Text(s.pleaseSelectDate)),
            ],
          ],
        );
      },
    );
  }

  void _showTimeSelectionBottomSheet(
    BuildContext context,
    ChooseScheduleStepCubit cubit,
  ) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder:
          (context) => BlocBuilder<ChooseScheduleStepCubit, ChooseScheduleStepState>(
            bloc: cubit,
            builder: (context, state) {
              return ChooseTimeBottomSheet(
                selectedDate: state.selectedDate!,
                scheduleSlots: state.scheduleSlots,
                onTimeSelected: (time, roomName) {
                  cubit.onTimeSlotPressed(time, roomName);
                },
              );
            },
          ),
    );
  }
}
