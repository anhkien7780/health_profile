import 'dart:async';
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_profile/models/enum/loading_status.dart';
import 'package:health_profile/repositories/medical_record_repository.dart';
import 'package:health_profile/repositories/prescription_repository.dart';
import 'package:health_profile/ui/pages/medical_record_detail/medical_record_detail_state.dart';

class MedicalRecordDetailCubit extends Cubit<MedicalRecordDetailState> {
  final MedicalRecordRepository medicalRecordRepository;
  final PrescriptionRepository prescriptionRepository;
  final int recordId;

  MedicalRecordDetailCubit({
    required this.medicalRecordRepository,
    required this.prescriptionRepository,
    required this.recordId,
  }) : super(const MedicalRecordDetailState()) {
    _initialLoad();
  }

  Future<void> _initialLoad() async {
    emit(state.copyWith(loadingStatus: LoadingStatus.loading));
    try {
      final medicalRecord = await medicalRecordRepository.getMedicalRecordDetail(recordId);
      try {
        final prescription = await prescriptionRepository.getPrescriptionByMedicalRecord(recordId.toString());
        emit(state.copyWith(
          medicalRecord: medicalRecord,
          prescription: prescription,
          loadingStatus: LoadingStatus.finish,
        ));
      } catch (e) {
        log("No prescription found for record $recordId: $e");
        emit(state.copyWith(
          medicalRecord: medicalRecord,
          loadingStatus: LoadingStatus.finish,
        ));
      }
    } catch (e) {
      log("Load medical record detail error: $e");
      emit(state.copyWith(loadingStatus: LoadingStatus.error));
    }
  }
}
