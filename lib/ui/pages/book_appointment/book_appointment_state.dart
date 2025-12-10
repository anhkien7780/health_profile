import 'package:equatable/equatable.dart';
import 'package:health_profile/models/entities/selection_item.dart';
import 'package:health_profile/models/enum/loading_status.dart';

class BookAppointmentState extends Equatable {
  final DateTime? selectedDate;
  final int currentStep;
  final SelectionItem? doctor;
  final SelectionItem? hospital;
  final String? note;
  final DateTime? selectedTime;
  final String? roomName;
  final LoadingStatus loadingStatus;

  const BookAppointmentState({
    this.doctor,
    this.hospital,
    this.selectedDate,
    this.currentStep = 0,
    this.note,
    this.selectedTime,
    this.roomName,
    this.loadingStatus = LoadingStatus.idle,
  });

  BookAppointmentState copyWith({
    SelectionItem? doctor,
    SelectionItem? hospital,
    DateTime? selectedTime,
    DateTime? selectedDate,
    int? currentStep,
    String? note,
    String? roomName,
    LoadingStatus? loadingStatus,
  }) {
    return BookAppointmentState(
      doctor: doctor ?? this.doctor,
      hospital: hospital ?? this.hospital,
      selectedDate: selectedDate ?? this.selectedDate,
      currentStep: currentStep ?? this.currentStep,
      note: note ?? this.note,
      selectedTime: selectedTime ?? this.selectedTime,
      roomName: roomName ?? this.roomName,
      loadingStatus: loadingStatus ?? this.loadingStatus,
    );
  }

  @override
  List<Object?> get props => [
    doctor,
    hospital,
    note,
    selectedDate,
    currentStep,
    selectedTime,
    roomName,
    loadingStatus,
  ];
}
