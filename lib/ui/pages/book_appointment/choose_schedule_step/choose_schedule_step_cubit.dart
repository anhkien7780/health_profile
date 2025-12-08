import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_profile/ui/pages/book_appointment/book_appointment_cubit.dart';
import 'package:health_profile/ui/pages/book_appointment/choose_schedule_step/choose_schedule_step_state.dart';

class ChooseScheduleStepCubit extends Cubit<ChooseScheduleStepState> {
  ChooseScheduleStepCubit({
    required this.bookAppointmentCubit,
  }) : super(const ChooseScheduleStepState()) {
    emit(state.copyWith(
      selectedDate: bookAppointmentCubit.state.selectedDate,
      selectedTime: bookAppointmentCubit.state.selectedTime,
    ));
  }

  final BookAppointmentCubit bookAppointmentCubit;

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
    emit(state.copyWith(selectedDate: date));
    bookAppointmentCubit.onDateSlotPressed(date);
  }

  void selectTime(DateTime time) {
    emit(state.copyWith(selectedTime: time));
    bookAppointmentCubit.selectTime(time);
  }
}
