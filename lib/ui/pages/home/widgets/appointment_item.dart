import 'package:flutter/material.dart';
import 'package:health_profile/common/app_dimens.dart';
import 'package:health_profile/generated/l10n.dart';

class AppointmentItem extends StatelessWidget {
  const AppointmentItem({
    super.key,
    required this.orderNumber,
    required this.hospitalName,
    required this.time,
    required this.doctorName,
  });

  final int orderNumber;
  final String hospitalName;
  final String time;
  final String doctorName;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.primary,
        borderRadius: BorderRadius.circular(AppDimens.borderRadiusBig),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(AppDimens.paddingNormal),
            alignment: Alignment.center,
            child: Text(
              orderNumber.toString(),
              style: theme.textTheme.headlineLarge?.copyWith(
                color: theme.colorScheme.onPrimary,
              ),
            ),
          ),
          Column(
            spacing: AppDimens.paddingSmall,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                hospitalName,
                style: theme.textTheme.labelLarge?.copyWith(
                  color: theme.colorScheme.onPrimary,
                ),
              ),
              Text(
                "$time - ${S.of(context).doctor} $doctorName",
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onPrimary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
