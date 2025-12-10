import 'package:equatable/equatable.dart';
import 'package:health_profile/models/entities/schedule_slot.dart';
import 'package:health_profile/models/enum/loading_status.dart';

class ChooseScheduleStepState extends Equatable {
  final DateTime? selectedDate;
  final DateTime? selectedTime;
  final String? roomName;
  final List<ScheduleSlot> scheduleSlots;
  final LoadingStatus loadingStatus;

  const ChooseScheduleStepState({
    this.selectedDate,
    this.selectedTime,
    this.roomName,
    this.scheduleSlots = const [],
    this.loadingStatus = LoadingStatus.idle,
  });

  ChooseScheduleStepState copyWith({
    DateTime? selectedDate,
    bool clearDate = false,
    DateTime? selectedTime,
    String? roomName,
    bool clearTime = false,
    List<ScheduleSlot>? scheduleSlots,
    LoadingStatus? loadingStatus,
  }) {
    return ChooseScheduleStepState(
      selectedDate: clearDate ? null : (selectedDate ?? this.selectedDate),
      selectedTime: clearTime ? null : (selectedTime ?? this.selectedTime),
      roomName: clearTime ? null : (roomName ?? this.roomName),
      scheduleSlots: scheduleSlots ?? this.scheduleSlots,
      loadingStatus: loadingStatus ?? this.loadingStatus,
    );
  }

  @override
  List<Object?> get props => [
    selectedDate,
    selectedTime,
    roomName,
    scheduleSlots,
    loadingStatus,
  ];
}
