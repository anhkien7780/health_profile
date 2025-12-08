import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_profile/generated/l10n.dart';
import 'package:health_profile/models/entities/selection_item.dart';
import 'package:health_profile/models/enum/loading_status.dart';
import 'package:health_profile/repositories/appointment_repository.dart';
import 'package:health_profile/ui/pages/book_appointment/book_appointment_navigator.dart';
import 'package:health_profile/ui/pages/book_appointment/book_appointment_state.dart';
import 'package:health_profile/ui/widgets/app_snackbar.dart';

class BookAppointmentCubit extends Cubit<BookAppointmentState> {
  BookAppointmentCubit({
    required this.navigator,
    required this.appointmentRepository,
  }) : super(const BookAppointmentState());

  final BookAppointmentNavigator navigator;
  final AppointmentRepository appointmentRepository;
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

  Future<void> onChooseHospitalPressed() async {
    emit(state.copyWith(loadingStatus: LoadingStatus.loading));
    try {
      final hospitals = await appointmentRepository.getHospitals();
      final items = hospitals.map((hospital) {
        return SelectionItem(
          id: hospital.id,
          title: hospital.name,
          subtitle: hospital.address,
          imageUrl: hospital.imageUrl,
        );
      }).toList();
      return navigator.showSelectionSheet(
        title: S.current.selectHospital,
        items: items,
        onItemSelected: (item) => selectHospital(item.id),
      );
    } catch (_) {
      emit(state.copyWith(loadingStatus: LoadingStatus.error));
      rethrow;
    } finally {
      emit(state.copyWith(loadingStatus: LoadingStatus.idle));
    }
  }

  Future<void> onChooseDoctorPressed() async {
    if (state.hospitalID == null) {
      AppSnackBar.show(
        navigator.context,
        S.current.pleaseSelectHospitalFirst,
        isError: true,
      );
      return;
    }
    emit(state.copyWith(loadingStatus: LoadingStatus.loading));
    try {
      final doctors = await appointmentRepository.getDoctors();
      final items = doctors.map((doctor) {
        return SelectionItem(
          id: doctor.id,
          title: doctor.fullName,
          subtitle: doctor.specialty,
          imageUrl: doctor.avatarUrl,
        );
      }).toList();
      return navigator.showSelectionSheet(
        title: S.current.selectDoctor,
        items: items,
        onItemSelected: (item) => selectDoctor(item.id),
      );
    } catch (_) {
      emit(state.copyWith(loadingStatus: LoadingStatus.error));
      rethrow;
    } finally {
      emit(state.copyWith(loadingStatus: LoadingStatus.idle));
    }
  }

  void selectDoctor(int id) {
    emit(state.copyWith(doctorID: id));
  }

  void selectHospital(int id) {
    emit(state.copyWith(hospitalID: id));
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
