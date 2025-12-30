import 'dart:async';
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_profile/models/enum/loading_status.dart';
import 'package:health_profile/repositories/medical_record_repository.dart';
import 'package:health_profile/repositories/user_profile_repository.dart';
import 'package:health_profile/repositories/auth_repository.dart';
import 'package:health_profile/ui/pages/medical_record_list/medical_record_list_state.dart';

class MedicalRecordListCubit extends Cubit<MedicalRecordListState> {
  final MedicalRecordRepository medicalRecordRepository;
  final UserProfileRepository userProfileRepository;
  final AuthRepository authRepository;

  MedicalRecordListCubit({
    required this.medicalRecordRepository,
    required this.userProfileRepository,
    required this.authRepository,
  }) : super(const MedicalRecordListState()) {
    _initialLoad();
  }

  Future<void> _initialLoad() async {
    emit(state.copyWith(loadingStatus: LoadingStatus.loading));
    try {
      final userProfile = await userProfileRepository.getUserProfile();
      final patientId = int.tryParse(userProfile?.id ?? "0");
      if (patientId == null) {
        throw Exception('User profile not found or has invalid ID');
      }
      final medicalRecords = await medicalRecordRepository.getMedicalRecords(patientId);
      emit(state.copyWith(
        medicalRecords: medicalRecords,
        loadingStatus: LoadingStatus.finish,
      ));
    } catch (e) {
      log("Initial load error: $e");
      emit(state.copyWith(loadingStatus: LoadingStatus.error));
    }
  }
}
