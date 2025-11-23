import 'package:flutter_bloc/flutter_bloc.dart';

import 'login_navigator.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit({required this.navigator}) : super(LoginState());

  final LoginNavigator navigator;

  Future<void> onSignInButtonPressed() async {
    navigator.openHomePage();
  }

  Future<void> onSignUpButtonPressed() async {
    navigator.openSignUpPage();
  }

  Future<void> onForgotPasswordTextPressed() async {
    navigator.openForgotPasswordPage();
  }
}
