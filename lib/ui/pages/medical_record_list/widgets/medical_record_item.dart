import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:health_profile/common/app_dimens.dart';
import 'package:health_profile/generated/l10n.dart';
import 'package:health_profile/models/entities/medical_record.dart';
import 'package:health_profile/router/router_config.dart';

class MedicalRecordItem extends StatelessWidget {
  final MedicalRecord record;

  const MedicalRecordItem({
    super.key,
    required this.record,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final s = S.of(context);
    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: AppDimens.marginMedium,
        vertical: AppDimens.marginSmall,
      ),
      child: InkWell(
        onTap: () => context.pushNamed(
          AppRouter.medicalRecordDetail,
          pathParameters: {'recordId': record.id.toString()},
        ),
        child: Padding(
          padding: const EdgeInsets.all(AppDimens.paddingMedium),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: AppDimens.paddingSmall,
            children: [
              Text('${s.medicalRecordDate}: ${record.recordDate}', style: theme.textTheme.titleMedium),
              Text('${s.medicalRecordSymptoms}: ${record.symptoms}'),
              Text('${s.medicalRecordDiagnosis}: ${record.diagnosis}'),
              Text('${s.medicalRecordTreatment}: ${record.treatment}'),
              if (record.notes != null && record.notes!.isNotEmpty)
                Text('${s.medicalRecordNotes}: ${record.notes}'),
            ],
          ),
        ),
      ),
    );
  }
}
