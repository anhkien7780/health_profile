import 'package:equatable/equatable.dart';

class ChooseScheduleStepState extends Equatable {
  final DateTime? selectedDate;
  final DateTime? selectedTime;

  const ChooseScheduleStepState({
    this.selectedDate,
    this.selectedTime,
  });

  ChooseScheduleStepState copyWith({
    DateTime? selectedDate,
    bool clearDate = false,
    DateTime? selectedTime,
    bool clearTime = false,
  }) {
    return ChooseScheduleStepState(
      selectedDate: clearDate ? null : (selectedDate ?? this.selectedDate),
      selectedTime: clearTime ? null : (selectedTime ?? this.selectedTime),
    );
  }

  @override
  List<Object?> get props => [selectedDate, selectedTime];
}
