import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_profile/models/entities/user_profile.dart';
import 'package:health_profile/models/enum/gender.dart';
import 'package:health_profile/ui/pages/home/home_navigator.dart';
import 'package:health_profile/utils/date_format_helper.dart';

import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {

  final HomeNavigator navigator;

  HomeCubit({required this.navigator})
    : super(
        HomeState(
          userProfile: UserProfile(
            fullName: "Nguyễn Văn Kiên",
            birthDay: "27/10/2002",
            phoneNumber: "0123423543",
            username: "NgVanKien",
            gender: Gender.male,
            id: "030202005908",
            address: "Phú Quý Bò Viên 1",
          ),
        ),
      );

  final TextEditingController textController = TextEditingController();

  void onDestinationPressed(int? selectedPageIndex) {
    emit(state.copyWith(selectedPageIndex: selectedPageIndex));
    log("Selected page: ${state.selectedPageIndex.toString()}");
  }

  void updateUserProfile({
    String? fullName,
    String? birthDay,
    String? phoneNumber,
    String? email,
    String? username,
    Gender? gender,
    String? id,
    String? address,
  }) {
    final userProfile = state.userProfile.copyWith(
      fullName: fullName ?? state.userProfile.fullName,
      birthDay: birthDay ?? state.userProfile.birthDay,
      phoneNumber: phoneNumber ?? state.userProfile.phoneNumber,
      email: email ?? state.userProfile.email,
      username: username ?? state.userProfile.username,
      gender: gender ?? state.userProfile.gender,
      id: id ?? state.userProfile.id,
      address: address ?? state.userProfile.address,
    );
    log("Update user profile: $userProfile");
    emit(state.copyWith(userProfile: userProfile));
  }

  void selectedBirthDay(DateTime date) {
    final dateString = DateFormatHelper.dateToString(date);
    textController.text = dateString;
  }

  void logout() {
    navigator.backToLoginPage();
  }
}
