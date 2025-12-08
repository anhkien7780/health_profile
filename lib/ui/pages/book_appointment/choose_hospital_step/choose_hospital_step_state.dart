import 'package:equatable/equatable.dart';
import 'package:health_profile/models/entities/selection_item.dart';
import 'package:health_profile/models/enum/loading_status.dart';

class ChooseHospitalStepState extends Equatable {
  final SelectionItem? hospital;
  final SelectionItem? doctor;
  final LoadingStatus loadingStatus;

  const ChooseHospitalStepState({
    this.hospital,
    this.doctor,
    this.loadingStatus = LoadingStatus.idle,
  });

  ChooseHospitalStepState copyWith({
    SelectionItem? hospital,
    bool clearHospital = false,
    SelectionItem? doctor,
    bool clearDoctor = false,
    LoadingStatus? loadingStatus,
  }) {
    return ChooseHospitalStepState(
      hospital: clearHospital ? null : (hospital ?? this.hospital),
      doctor: clearDoctor ? null : (doctor ?? this.doctor),
      loadingStatus: loadingStatus ?? this.loadingStatus,
    );
  }

  @override
  List<Object?> get props => [hospital, doctor, loadingStatus];
}
