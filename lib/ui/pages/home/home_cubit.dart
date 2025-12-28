import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_profile/models/enum/gender.dart';
import 'package:health_profile/models/enum/loading_status.dart';
import 'package:health_profile/repositories/appointment_repository.dart';
import 'package:health_profile/repositories/auth_repository.dart';
import 'package:health_profile/repositories/user_profile_repository.dart';
import 'package:health_profile/ui/pages/home/home_navigator.dart';
import 'package:health_profile/utils/date_format_helper.dart';

import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeNavigator navigator;
  final AuthRepository authRepository;
  final UserProfileRepository userProfileRepository;
  final AppointmentRepository appointmentRepository;
  late final StreamSubscription _appointmentsSubscription;

  HomeCubit({
    required this.navigator,
    required this.authRepository,
    required this.userProfileRepository,
    required this.appointmentRepository,
  }) : super(const HomeState()) {
    _initialLoad();
    _appointmentsSubscription = appointmentRepository.appointmentsStream.listen((appointments) {
      emit(state.copyWith(appointments: appointments));
    });
  }

  @override
  Future<void> close() {
    _appointmentsSubscription.cancel();
    return super.close();
  }


  final TextEditingController textController = TextEditingController();

  Future<void> _initialLoad() async {
    emit(state.copyWith(loadingStatus: LoadingStatus.loading));
    try {
      final userProfile = await userProfileRepository.getUserProfile();
      final appointments = await appointmentRepository.getAppointments();
      emit(state.copyWith(
        userProfile: userProfile,
        appointments: appointments,
        loadingStatus: LoadingStatus.finish,
      ));
    } catch (e) {
      log("Initial load error: $e");
      emit(state.copyWith(loadingStatus: LoadingStatus.error));
    }
  }

  void onDestinationPressed(int? selectedPageIndex) {
    emit(state.copyWith(selectedPageIndex: selectedPageIndex));
    log("Selected page: ${state.selectedPageIndex.toString()}");
  }

  Future<void> updateUserProfile({
    String? fullName,
    String? birthDay,
    String? phoneNumber,
    String? email,
    String? username,
    Gender? gender,
    String? id,
    String? address,
    String? emergencyContact,
    String? bloodType,
    String? allergies,
  }) async {
    final userProfile = state.userProfile?.copyWith(
      fullName: fullName,
      birthDay: birthDay,
      phoneNumber: phoneNumber,
      email: email,
      username: username,
      gender: gender,
      id: id,
      address: address,
      emergencyContact: emergencyContact,
      bloodType: bloodType,
      allergies: allergies,
    );
    log("Update user profile: $userProfile");
    if (userProfile != null) {
      emit(state.copyWith(userProfile: userProfile));
      await userProfileRepository.saveUserProfile(userProfile.toJson());
    }
  }

  void selectedBirthDay(DateTime date) {
    final dateString = DateFormatHelper.dateToString(date);
    textController.text = dateString;
  }

  Future<void> logout() async {
    emit(state.copyWith(loadingStatus: LoadingStatus.loading));
    try {
      await authRepository.logout();
      emit(state.copyWith(loadingStatus: LoadingStatus.finish));
      navigator.backToLoginPage();
    } catch (e) {
      log("Logout error: $e");
      emit(state.copyWith(loadingStatus: LoadingStatus.error));
      navigator.backToLoginPage(); // Vẫn logout dù có lỗi API
    }
  }
}
