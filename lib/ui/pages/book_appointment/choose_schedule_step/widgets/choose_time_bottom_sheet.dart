import 'package:flutter/material.dart';
import 'package:health_profile/common/app_dimens.dart';
import 'package:health_profile/configs/app_configs.dart';
import 'package:health_profile/generated/l10n.dart';
import 'package:health_profile/models/entities/schedule_slot.dart';
import 'package:health_profile/ui/pages/book_appointment/choose_schedule_step/widgets/time_slot_item.dart';

class ChooseTimeBottomSheet extends StatelessWidget {
  const ChooseTimeBottomSheet({
    super.key,
    required this.selectedDate,
    required this.scheduleSlots,
    required this.onTimeSelected,
  });

  final DateTime selectedDate;
  final List<ScheduleSlot> scheduleSlots;
  final Function(String) onTimeSelected;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final s = S.of(context);

    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.8,
      minChildSize: 0.5,
      maxChildSize: 0.8,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(AppDimens.borderRadiusNormal),
            ),
          ),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(AppDimens.paddingNormal),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(AppDimens.borderRadiusNormal),
                  ),
                ),
                child: Row(
                  children: [
                    Icon(Icons.access_time, color: theme.colorScheme.onPrimary),
                    const SizedBox(width: AppDimens.paddingSmall),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            s.chooseTime,
                            style: theme.textTheme.titleMedium?.copyWith(
                              color: theme.colorScheme.onPrimary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "${s.day}: ${AppConfigs.dayMonthYearFormat.format(selectedDate)}",
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: theme.colorScheme.onPrimary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      color: theme.colorScheme.onPrimary,
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  controller: scrollController,
                  padding: const EdgeInsets.all(AppDimens.paddingNormal),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: AppDimens.paddingNormal,
                    children: scheduleSlots.map((scheduleSlot) {
                      return _buildTimeGrid(context, scheduleSlot);
                    }).toList(),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    final theme = Theme.of(context);
    return Row(
      spacing: AppDimens.paddingSmall,
      children: [
        Icon(Icons.local_hospital_outlined, size: AppDimens.iconSizeNormal),
        Expanded(
          child: Text(
            title,
            style: theme.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTimeGrid(BuildContext context, ScheduleSlot scheduleSlot) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: AppDimens.paddingNormal,
      children: [
        _buildSectionTitle(context, scheduleSlot.roomName),
        Wrap(
          spacing: AppDimens.paddingSmall,
          runSpacing: AppDimens.paddingSmall,
          children: scheduleSlot.slots.map((time) {
            return TimeSlotItem(
              time: time,
              isSelected: false,
              onTap: () {
                onTimeSelected(time);
                Navigator.pop(context);
              },
            );
          }).toList(),
        ),
      ],
    );
  }
}
