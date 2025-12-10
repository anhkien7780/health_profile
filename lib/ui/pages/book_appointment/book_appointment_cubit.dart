import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_profile/generated/l10n.dart';
import 'package:health_profile/models/entities/selection_item.dart';
import 'package:health_profile/repositories/appointment_repository.dart';
import 'package:health_profile/ui/pages/book_appointment/book_appointment_navigator.dart';
import 'package:health_profile/ui/pages/book_appointment/book_appointment_state.dart';

class BookAppointmentCubit extends Cubit<BookAppointmentState> {
  BookAppointmentCubit({
    required this.navigator,
    required this.appointmentRepository,
  }) : super(const BookAppointmentState());

  final BookAppointmentNavigator navigator;
  final AppointmentRepository appointmentRepository;
  final PageController pageController = PageController();
  final TextEditingController noteController = TextEditingController();

  @override
  Future<void> close() {
    pageController.dispose();
    noteController.dispose();
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

  void selectDoctor(SelectionItem? doctor) {
    emit(state.copyWith(doctor: doctor));
  }

  void selectHospital(SelectionItem? hospital) {
    emit(state.copyWith(hospital: hospital));
  }

  String? getErrorMessage() {
    switch (state.currentStep) {
      case 0:
        if (state.hospital == null) {
          return S.current.pleaseSelectHospital;
        }
        if (state.doctor == null) {
          return S.current.pleaseSelectDoctor;
        }
        return null;
      case 1:
        if (state.selectedDate == null) {
          return S.current.pleaseSelectDate;
        }
        if (state.selectedTime == null) {
          return S.current.pleaseSelectTime;
        }
        return null;
      default:
        return null;
    }
  }

  void onNextPressed() {
    final errorMessage = getErrorMessage();
    if (errorMessage != null) {
      navigator.showErrorSnackBar(errorMessage);
      return;
    }

    if (state.currentStep < 2) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      final note = noteController.text;
      emit(state.copyWith(note: note));
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

  void onRefresh() {
    noteController.clear();
    emit(const BookAppointmentState());
    pageController.animateToPage(
      0,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }
}
