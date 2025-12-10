import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_profile/common/app_dimens.dart';
import 'package:health_profile/configs/app_configs.dart';
import 'package:health_profile/generated/l10n.dart';
import 'package:health_profile/ui/pages/book_appointment/book_appointment_cubit.dart';
import 'package:health_profile/ui/pages/book_appointment/book_appointment_state.dart';
import 'package:health_profile/ui/pages/book_appointment/widgets/selection_item_card.dart';
import 'package:health_profile/ui/widgets/text_fields/app_text_form_field.dart';

class ConfirmAppointmentStepPage extends StatelessWidget {
  const ConfirmAppointmentStepPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookAppointmentCubit, BookAppointmentState>(
      builder: (context, state) {
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: AppDimens.paddingNormal,
            children: [
              if (state.hospital != null)
                SelectionItemCard(item: state.hospital!),
              if (state.doctor != null) SelectionItemCard(item: state.doctor!),
              _buildLocationInfo(context),
              _buildTimeInfo(context, state),
              _buildNoteSection(context),
            ],
          ),
        );
      },
    );
  }

  Widget _buildLocationInfo(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      spacing: AppDimens.paddingSmall,
      children: [
        Icon(Icons.add_box_outlined, size: AppDimens.iconSizeNormal),
        Expanded(
          child: Text(
            "Phòng khám dị ứng (P.312 Nhà C)",
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTimeInfo(BuildContext context, BookAppointmentState state) {
    final theme = Theme.of(context);
    final s = S.of(context);
    String timeString = "";
    if (state.selectedTime != null) {
      timeString = AppConfigs.timeFormat.format(state.selectedTime!);
    }
    if (state.selectedDate != null) {
      if (timeString.isNotEmpty) timeString += " - ";
      timeString += AppConfigs.dayMonthYearFormat.format(state.selectedDate!);
    }

    return Text(
      "${s.chooseTime}: $timeString",
      style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
    );
  }

  Widget _buildNoteSection(BuildContext context) {
    final s = S.of(context);
    final cubit = context.read<BookAppointmentCubit>();
    return AppTextFormField(
      controller: cubit.noteController,
      title: s.note,
      hint: s.noteHint,
      maxLines: 5,
    );
  }
}
