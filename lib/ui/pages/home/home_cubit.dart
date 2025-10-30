import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_profile/models/entities/user_profile.dart';

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
            gender: "Nam",
            id: "030202005908",
            address: "Phú Quý Bò Viên 1",
          ),
        ),
      );

  void onDestinationPressed(int? selectedPageIndex) {
    emit(state.copyWith(selectedPageIndex: selectedPageIndex));
    log("Selected page: ${state.selectedPageIndex.toString()}");
  }
}
