import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_profile/common/app_dimens.dart';
import 'package:health_profile/generated/l10n.dart';
import 'package:health_profile/ui/pages/book_appointment/book_appointment_cubit.dart';
import 'package:health_profile/ui/pages/book_appointment/book_appointment_state.dart';
import 'package:health_profile/ui/pages/book_appointment/widgets/date_slot_item.dart';
import 'package:health_profile/ui/widgets/buttons/app_elevated_button.dart';

class ChooseScheduleStepContent extends StatefulWidget {
  const ChooseScheduleStepContent({super.key});

  @override
  State<ChooseScheduleStepContent> createState() =>
      _ChooseScheduleStepContentState();
}

class _ChooseScheduleStepContentState extends State<ChooseScheduleStepContent> {
  late final BookAppointmentCubit _cubit;
  late final ThemeData theme;
  late final S s;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _cubit = context.read<BookAppointmentCubit>();
    theme = Theme.of(context);
    s = S.of(context);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        spacing: AppDimens.paddingNormal,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _createDatePicker(),
          BlocBuilder<BookAppointmentCubit, BookAppointmentState>(
            buildWhen: (previous, current) =>
                previous.selectedDate != current.selectedDate,
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
                    AppElevatedButton(
                      onClick: () {},
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
          ),
        ],
      ),
    );
  }

  Widget _createDatePicker() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: AppDimens.paddingNormal,
      children: [
        Text(s.chooseDate, style: theme.textTheme.titleMedium),
        BlocBuilder<BookAppointmentCubit, BookAppointmentState>(
          buildWhen: (pre, current) => pre.selectedDate != current.selectedDate,
          builder: (context, state) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: _cubit
                  .generateDays()
                  .map(
                    (date) => DateSlotItem(
                      onTap: () {
                        _cubit.onDateSlotPressed(date);
                      },
                      date: date,
                      isSelected: _cubit.isSelectedDate(date),
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
