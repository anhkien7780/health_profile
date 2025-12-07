import 'package:equatable/equatable.dart';

class BookAppointmentState extends Equatable {
  final DateTime? selectedDate;
  final int currentStep;
  final int? doctorID;
  final int? hospitalID;
  final String? note;
  final DateTime? selectedTime;

  const BookAppointmentState({
    this.doctorID,
    this.hospitalID,
    this.selectedDate,
    this.currentStep = 0,
    this.note,
    this.selectedTime,
  });

  BookAppointmentState copyWith({
    int? doctorID,
    int? hospitalID,
    DateTime? selectedTime,
    DateTime? selectedDate,
    int? currentStep,
    String? note,
  }) {
    return BookAppointmentState(
      doctorID: doctorID ?? this.doctorID,
      hospitalID: hospitalID ?? this.hospitalID,
      selectedDate: selectedDate ?? this.selectedDate,
      currentStep: currentStep ?? this.currentStep,
      note: note ?? this.note,
      selectedTime: selectedTime ?? this.selectedTime,
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
  ];
}
