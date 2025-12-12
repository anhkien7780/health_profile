import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_profile/generated/l10n.dart';
import 'package:health_profile/models/entities/selection_item.dart';
import 'package:health_profile/models/enum/loading_status.dart';
import 'package:health_profile/repositories/appointment_repository.dart';
import 'package:health_profile/ui/pages/book_appointment/book_appointment_cubit.dart';
import 'package:health_profile/ui/pages/book_appointment/book_appointment_navigator.dart';
import 'package:health_profile/ui/pages/book_appointment/choose_hospital_step/choose_hospital_step_state.dart';
import 'package:health_profile/ui/widgets/snack_bar/app_snackbar.dart';

class ChooseHospitalStepCubit extends Cubit<ChooseHospitalStepState> {
  ChooseHospitalStepCubit({
    required this.appointmentRepository,
    required this.navigator,
    required this.bookAppointmentCubit,
  }) : super(const ChooseHospitalStepState()) {
    emit(
      state.copyWith(
        hospital: bookAppointmentCubit.state.hospital,
        doctor: bookAppointmentCubit.state.doctor,
      ),
    );
  }

  final AppointmentRepository appointmentRepository;
  final BookAppointmentNavigator navigator;
  final BookAppointmentCubit bookAppointmentCubit;

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
        onItemSelected: (item) => selectHospital(item),
      );
    } catch (_) {
      emit(state.copyWith(loadingStatus: LoadingStatus.error));
      rethrow;
    } finally {
      emit(state.copyWith(loadingStatus: LoadingStatus.idle));
    }
  }

  Future<void> onChooseDoctorPressed() async {
    if (state.hospital == null) {
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
        onItemSelected: (item) => selectDoctor(item),
      );
    } catch (_) {
      emit(state.copyWith(loadingStatus: LoadingStatus.error));
      rethrow;
    } finally {
      emit(state.copyWith(loadingStatus: LoadingStatus.idle));
    }
  }

  void selectDoctor(SelectionItem? doctor) {
    if (doctor == null) {
      emit(state.copyWith(clearDoctor: true));
    } else {
      emit(state.copyWith(doctor: doctor));
    }
    bookAppointmentCubit.selectDoctor(doctor);
  }

  void selectHospital(SelectionItem? hospital) {
    if (hospital?.id != state.hospital?.id) {
      selectDoctor(null);
    }
    if (hospital == null) {
      emit(state.copyWith(clearHospital: true));
    } else {
      emit(state.copyWith(hospital: hospital));
    }
    bookAppointmentCubit.selectHospital(hospital);
  }
}
