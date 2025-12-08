
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_profile/common/app_dimens.dart';
import 'package:health_profile/generated/l10n.dart';
import 'package:health_profile/ui/pages/book_appointment/choose_schedule_step/choose_schedule_step_cubit.dart';
import 'package:health_profile/ui/pages/book_appointment/choose_schedule_step/choose_schedule_step_state.dart';
import 'package:health_profile/ui/pages/book_appointment/widgets/date_slot_item.dart';

class DatePickerSection extends StatelessWidget {
  const DatePickerSection({super.key});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final theme = Theme.of(context);
    final cubit = context.read<ChooseScheduleStepCubit>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: AppDimens.paddingNormal,
      children: [
        Text(s.chooseDate, style: theme.textTheme.titleMedium),
        BlocBuilder<ChooseScheduleStepCubit, ChooseScheduleStepState>(
          buildWhen: (pre, current) => pre.selectedDate != current.selectedDate,
          builder: (context, state) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: cubit
                  .generateDays()
                  .map(
                    (date) => DateSlotItem(
                  onTap: () {
                    cubit.onDateSlotPressed(date);
                  },
                  date: date,
                  isSelected: cubit.isSelectedDate(date),
                ),
              )
                  .toList(),
            );
          },
        ),
      ],
    );
  }
}