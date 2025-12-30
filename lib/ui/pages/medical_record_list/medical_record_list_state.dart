import 'package:equatable/equatable.dart';
import 'package:health_profile/models/entities/medical_record.dart';
import 'package:health_profile/models/enum/loading_status.dart';

class MedicalRecordListState extends Equatable {
  const MedicalRecordListState({
    this.medicalRecords = const [],
    this.loadingStatus = LoadingStatus.idle,
  });

  final List<MedicalRecord> medicalRecords;
  final LoadingStatus loadingStatus;

  MedicalRecordListState copyWith({
    List<MedicalRecord>? medicalRecords,
    LoadingStatus? loadingStatus,
  }) {
    return MedicalRecordListState(
      medicalRecords: medicalRecords ?? this.medicalRecords,
      loadingStatus: loadingStatus ?? this.loadingStatus,
    );
  }

  @override
  List<Object?> get props => [
    medicalRecords,
    loadingStatus,
  ];
}
