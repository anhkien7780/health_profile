import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_profile/repositories/medical_record_repository.dart';
import 'package:health_profile/repositories/user_profile_repository.dart';
import 'package:health_profile/repositories/auth_repository.dart';
import 'package:health_profile/ui/pages/medical_record_list/medical_record_list_cubit.dart';
import 'package:health_profile/ui/pages/medical_record_list/widgets/medical_record_list_body.dart';

class MedicalRecordListPage extends StatelessWidget {
  const MedicalRecordListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MedicalRecordListCubit(
        medicalRecordRepository: context.read<MedicalRecordRepository>(),
        userProfileRepository: context.read<UserProfileRepository>(),
        authRepository: context.read<AuthRepository>(),
      ),
      child: const MedicalRecordListBody(),
    );
  }
}
