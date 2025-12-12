import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_profile/models/enum/loading_status.dart';
import 'package:health_profile/repositories/auth_repository.dart';

import 'login_navigator.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit({
    required this.navigator,
    required this.authRepository,
  }) : super(const LoginState());

  final LoginNavigator navigator;
  final AuthRepository authRepository;

  final TextEditingController emailController = TextEditingController(
    text: "patient@test.com",
  );
  final TextEditingController passwordController = TextEditingController(
    text: "password123",
  );

  Future<void> onSignInButtonPressed() async {
    final email = emailController.text;
    final password = passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      emit(state.copyWith(
        loadStatus: LoadingStatus.error,
        errorMessage: "Email and password cannot be empty",
      ));
      return;
    }

    emit(state.copyWith(loadStatus: LoadingStatus.loading));
    try {
      await authRepository.login(email, password);
      emit(state.copyWith(loadStatus: LoadingStatus.finish));
      navigator.openHomePage();
    } catch (e) {
      emit(state.copyWith(
        loadStatus: LoadingStatus.error,
        errorMessage: e.toString().replaceFirst("Exception: ", ""),
      ));
    }
  }

  Future<void> onSignUpButtonPressed() async {
    navigator.openSignUpPage();
  }

  Future<void> onForgotPasswordTextPressed() async {
    navigator.openForgotPasswordPage();
  }

  @override
  Future<void> close() {
    emailController.dispose();
    passwordController.dispose();
    return super.close();
  }
}
