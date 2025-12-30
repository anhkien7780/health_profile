import 'package:flutter/material.dart';
import 'package:health_profile/models/entities/medical_record.dart';

class MedicalRecordItem extends StatelessWidget {
  final MedicalRecord record;

  const MedicalRecordItem({
    super.key,
    required this.record,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Date: ${record.recordDate}', style: theme.textTheme.titleMedium),
            const SizedBox(height: 8),
            Text('Symptoms: ${record.symptoms}'),
            const SizedBox(height: 8),
            Text('Diagnosis: ${record.diagnosis}'),
            const SizedBox(height: 8),
            Text('Treatment: ${record.treatment}'),
            if (record.notes != null && record.notes!.isNotEmpty) ...[
              const SizedBox(height: 8),
              Text('Notes: ${record.notes}'),
            ],
          ],
        ),
      ),
    );
  }
}
