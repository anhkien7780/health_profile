import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_profile/models/enum/loading_status.dart';
import 'package:health_profile/repositories/appointment_repository.dart';
import 'package:health_profile/ui/pages/book_appointment/book_appointment_cubit.dart';
import 'package:health_profile/ui/pages/book_appointment/choose_schedule_step/choose_schedule_step_state.dart';

class ChooseScheduleStepCubit extends Cubit<ChooseScheduleStepState> {
  ChooseScheduleStepCubit({
    required this.bookAppointmentCubit,
    required this.appointmentRepository,
  }) : super(const ChooseScheduleStepState()) {
    emit(
      state.copyWith(
        selectedDate: bookAppointmentCubit.state.selectedDate,
        selectedTime: bookAppointmentCubit.state.selectedTime,
      ),
    );
    _fetchScheduleSlots();
  }

  final BookAppointmentCubit bookAppointmentCubit;
  final AppointmentRepository appointmentRepository;

  Future<void> _fetchScheduleSlots() async {
    if (state.selectedDate == null) return;
    emit(state.copyWith(loadingStatus: LoadingStatus.loading));
    try {
      final slots = await appointmentRepository.getScheduleSlots();
      emit(
        state.copyWith(scheduleSlots: slots, loadingStatus: LoadingStatus.idle),
      );
    } catch (_) {
      emit(state.copyWith(loadingStatus: LoadingStatus.error));
    }
  }

  List<DateTime> generateDays({int count = 3}) {
    return List.generate(count, (index) {
      return DateTime.now().add(Duration(days: index));
    });
  }

  bool isSelectedDate(DateTime date) {
    if (state.selectedDate == null) return false;
    return DateUtils.isSameDay(state.selectedDate, date);
  }

  void onDateSlotPressed(DateTime date) {
    emit(state.copyWith(selectedDate: date, clearTime: true));
    bookAppointmentCubit.onDateSlotPressed(date);
    _fetchScheduleSlots();
  }

  void selectTime(DateTime time) {
    emit(state.copyWith(selectedTime: time));
    bookAppointmentCubit.selectTime(time);
  }

  void onTimeSlotPressed(String time) {
    if (state.selectedDate == null) return;
    try {
      final parts = time.split(':');
      final hour = int.parse(parts[0]);
      final minute = int.parse(parts[1]);
      final selectedTime = DateTime(
        state.selectedDate!.year,
        state.selectedDate!.month,
        state.selectedDate!.day,
        hour,
        minute,
      );
      selectTime(selectedTime);
    } catch (_) {}
  }
}
