import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_profile/models/entities/user_profile.dart';
import 'package:health_profile/models/enum/gender.dart';
import 'package:health_profile/utils/date_format_helper.dart';

import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit()
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

  void selectedBirthDay(DateTime date) {
    final dateString = DateFormatHelper.dateToString(date);
    textController.text = dateString;
  }
}
