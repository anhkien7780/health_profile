import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_profile/repositories/medical_record_repository.dart';
import 'package:health_profile/repositories/prescription_repository.dart';
import 'package:health_profile/ui/pages/medical_record_detail/medical_record_detail_cubit.dart';
import 'package:health_profile/ui/pages/medical_record_detail/widgets/medical_record_detail_body.dart';

class MedicalRecordDetailPage extends StatelessWidget {
  final int recordId;

  const MedicalRecordDetailPage({super.key, required this.recordId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MedicalRecordDetailCubit(
        medicalRecordRepository: context.read<MedicalRecordRepository>(),
        prescriptionRepository: context.read<PrescriptionRepository>(),
        recordId: recordId,
      ),
      child: const MedicalRecordDetailBody(),
    );
  }
}
