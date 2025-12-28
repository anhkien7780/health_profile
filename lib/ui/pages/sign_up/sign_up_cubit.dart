import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_profile/repositories/auth_repository.dart';
import 'package:health_profile/ui/pages/sign_up/sign_up_navigator.dart';
import 'package:health_profile/ui/pages/sign_up/sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit({required this.navigator, required this.authRepository})
      : super(const SignUpState());

  final SignUpNavigator navigator;
  final AuthRepository authRepository;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  Future<void> openLoginPage() async {
    await navigator.openLoginPage();
  }

  Future<void> onRegisterButtonPressed() async {
    await navigator.openProfileRegister(
      email: emailController.text,
      password: passwordController.text,
    );
  }

  @override
  Future<void> close() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    return super.close();
  }
}
