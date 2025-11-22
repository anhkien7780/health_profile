import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_profile/models/enum/gender.dart';
import 'package:health_profile/ui/pages/profile_register/profile_register_navigator.dart';
import 'package:health_profile/ui/pages/profile_register/profile_register_state.dart';

class ProfileRegisterCubit extends Cubit<ProfileRegisterState> {
  ProfileRegisterCubit({required this.navigator})
    : super(ProfileRegisterState());

  final ProfileRegisterNavigator navigator;

  final birthDayTextController = TextEditingController();
  final genderTextController = TextEditingController();
  final fullNameTextController = TextEditingController();
  final phoneNumberTextController = TextEditingController();
  final emailTextController = TextEditingController();
  final idTextController = TextEditingController();
  final addressTextController = TextEditingController();

  void changeGender() {
    if (genderTextController.text == Gender.male.name) {
      genderTextController.text = Gender.female.name;
      return;
    }
    genderTextController.text = Gender.male.name;
  }

  Future<void> onCompletedButtonPressed() {
    return navigator.openHomePage();
  }
}
