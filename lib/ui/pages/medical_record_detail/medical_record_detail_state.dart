import 'package:equatable/equatable.dart';
import 'package:health_profile/models/entities/medical_record.dart';
import 'package:health_profile/models/entities/prescription.dart';
import 'package:health_profile/models/enum/loading_status.dart';

class MedicalRecordDetailState extends Equatable {
  const MedicalRecordDetailState({
    this.medicalRecord,
    this.prescription,
    this.loadingStatus = LoadingStatus.idle,
  });

  final MedicalRecord? medicalRecord;
  final Prescription? prescription;
  final LoadingStatus loadingStatus;

  MedicalRecordDetailState copyWith({
    MedicalRecord? medicalRecord,
    Prescription? prescription,
    LoadingStatus? loadingStatus,
  }) {
    return MedicalRecordDetailState(
      medicalRecord: medicalRecord ?? this.medicalRecord,
      prescription: prescription ?? this.prescription,
      loadingStatus: loadingStatus ?? this.loadingStatus,
    );
  }

  @override
  List<Object?> get props => [
        medicalRecord,
        prescription,
        loadingStatus,
      ];
}
