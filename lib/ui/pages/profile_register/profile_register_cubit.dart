import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_profile/models/enum/gender.dart';
import 'package:health_profile/repositories/auth_repository.dart';
import 'package:health_profile/repositories/user_profile_repository.dart';
import 'package:health_profile/ui/pages/profile_register/profile_register_navigator.dart';
import 'package:health_profile/ui/pages/profile_register/profile_register_state.dart';
import 'package:health_profile/utils/date_format_helper.dart';

class ProfileRegisterCubit extends Cubit<ProfileRegisterState> {
  ProfileRegisterCubit({
    required this.navigator,
    required this.email,
    required this.password,
    required this.authRepository,
    required this.userProfileRepository,
  }) : super(const ProfileRegisterState()) {
    emailTextController.text = email;
    genderTextController.text = Gender.male.name;
  }

  final ProfileRegisterNavigator navigator;
  final AuthRepository authRepository;
  final UserProfileRepository userProfileRepository;
  final String email;
  final String password;

  DateTime? _selectedDateOfBirth;

  final birthDayTextController = TextEditingController();
  final genderTextController = TextEditingController();
  final fullNameTextController = TextEditingController();
  final phoneNumberTextController = TextEditingController();
  final emailTextController = TextEditingController();
  final addressTextController = TextEditingController();
  final emergencyContactTextController = TextEditingController();
  final bloodTypeTextController = TextEditingController();
  final allergiesTextController = TextEditingController();

  void onDateOfBirthChanged(DateTime date) {
    _selectedDateOfBirth = date;
    birthDayTextController.text = DateFormatHelper.dateToString(date);
  }

  void changeGender() {
    if (genderTextController.text == Gender.male.name) {
      genderTextController.text = Gender.female.name;
    } else {
      genderTextController.text = Gender.male.name;
    }
  }

  @override
  Future<void> close() {
    birthDayTextController.dispose();
    genderTextController.dispose();
    fullNameTextController.dispose();
    phoneNumberTextController.dispose();
    emailTextController.dispose();
    addressTextController.dispose();
    emergencyContactTextController.dispose();
    bloodTypeTextController.dispose();
    allergiesTextController.dispose();
    return super.close();
  }

  Future<void> onCompletedButtonPressed() async {
    emit(state.copyWith(isLoading: true, error: null));
    try {
      final Map<String, dynamic> userData = {
        'email': email,
        'password': password,
        'fullName': fullNameTextController.text,
        'role': 'PATIENT',
      };

      if (_selectedDateOfBirth != null) {
        userData['dateOfBirth'] = DateFormatHelper.dateToApiString(
          _selectedDateOfBirth!,
        );
      }
      if (genderTextController.text.isNotEmpty) {
        userData['gender'] = genderTextController.text.toUpperCase();
      }
      if (phoneNumberTextController.text.isNotEmpty) {
        userData['phone'] = phoneNumberTextController.text;
      }
      if (addressTextController.text.isNotEmpty) {
        userData['address'] = addressTextController.text;
      }
      if (emergencyContactTextController.text.isNotEmpty) {
        userData['emergencyContact'] = emergencyContactTextController.text;
      }
      if (bloodTypeTextController.text.isNotEmpty) {
        userData['bloodType'] = bloodTypeTextController.text;
      }
      if (allergiesTextController.text.isNotEmpty) {
        userData['allergies'] = allergiesTextController.text;
      }

      await authRepository.register(userData);
      await userProfileRepository.saveUserProfile(userData);
      await navigator.openHomePage();
    } catch (e) {
      emit(state.copyWith(error: e.toString()));
    } finally {
      emit(state.copyWith(isLoading: false));
    }
  }
}
