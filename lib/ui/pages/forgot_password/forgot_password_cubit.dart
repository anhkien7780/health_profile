import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_profile/ui/pages/forgot_password/forgot_password_navigator.dart';
import 'package:health_profile/ui/pages/forgot_password/forgot_password_state.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  ForgotPasswordCubit({required this.navigator}) : super(ForgotPasswordState());

  final ForgotPasswordNavigator navigator;

  Future<void> onSendVerifyCodePressed() async {
    return navigator.openEnterVerifyCodePage();
  }

  Future<void> onBackButtonPressed() async {
    return navigator.openLoginPage();
  }
}
