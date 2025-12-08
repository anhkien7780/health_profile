import 'package:equatable/equatable.dart';
import 'package:health_profile/models/enum/loading_status.dart';

class BookAppointmentState extends Equatable {
  final DateTime? selectedDate;
  final int currentStep;
  final int? doctorID;
  final int? hospitalID;
  final String? note;
  final DateTime? selectedTime;
  final LoadingStatus loadingStatus;

  const BookAppointmentState({
    this.doctorID,
    this.hospitalID,
    this.selectedDate,
    this.currentStep = 0,
    this.note,
    this.selectedTime,
    this.loadingStatus = LoadingStatus.idle,
  });

  BookAppointmentState copyWith({
    int? doctorID,
    int? hospitalID,
    DateTime? selectedTime,
    DateTime? selectedDate,
    int? currentStep,
    String? note,
    LoadingStatus? loadingStatus,
  }) {
    return BookAppointmentState(
      doctorID: doctorID ?? this.doctorID,
      hospitalID: hospitalID ?? this.hospitalID,
      selectedDate: selectedDate ?? this.selectedDate,
      currentStep: currentStep ?? this.currentStep,
      note: note ?? this.note,
      selectedTime: selectedTime ?? this.selectedTime,
      loadingStatus: loadingStatus ?? this.loadingStatus,
    );
  }

  @override
  List<Object?> get props => [
    doctorID,
    hospitalID,
    note,
    selectedDate,
    currentStep,
    selectedTime,
    loadingStatus,
  ];
}
