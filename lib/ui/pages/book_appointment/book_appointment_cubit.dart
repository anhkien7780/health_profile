import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_profile/ui/pages/book_appointment/book_appointment_navigator.dart';
import 'package:health_profile/ui/pages/book_appointment/book_appointment_state.dart';

class BookAppointmentCubit extends Cubit<BookAppointmentState> {
  BookAppointmentCubit({required this.navigator})
    : super(BookAppointmentState(selectedDate: null));

  final BookAppointmentNavigator navigator;
  final PageController pageController = PageController();

  @override
  Future<void> close() {
    pageController.dispose();
    return super.close();
  }

  bool isActive(int index) {
    return (index - 1) <= state.currentStep;
  }

  bool isSelectedDate(DateTime date) {
    if (state.selectedDate == null) return false;
    return DateUtils.isSameDay(state.selectedDate, date);
  }

  List<DateTime> generateDays({int count = 3}) {
    return List.generate(count, (index) {
      return DateTime.now().add(Duration(days: index));
    });
  }

  void changeStep(int step) {
    emit(state.copyWith(currentStep: step));
  }

  void selectTime(DateTime time) {
    emit(state.copyWith(selectedTime: time));
  }

  void onDateSlotPressed(DateTime date) {
    emit(state.copyWith(selectedDate: date));
  }

  void onNextPressed() {
    if (state.currentStep < 2) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      // Handle completion
    }
  }

  void onBackPressed() {
    if (state.currentStep > 0) {
      pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      navigator.pop();
    }
  }
}
