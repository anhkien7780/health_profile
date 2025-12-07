import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_profile/ui/pages/verify_code/verify_code_navigator.dart';
import 'package:health_profile/ui/pages/verify_code/verify_code_state.dart';

class VerifyCodeCubit extends Cubit<VerifyCodeState> {
  VerifyCodeCubit({required this.navigator}) : super(VerifyCodeState());

  final VerifyCodeNavigator navigator;

  Future<void> onBackButtonPressed() async {
    return await navigator.openLoginPage();
  }

  Future<void> onConfirmPressed() async {
    return await navigator.openChangePasswordPage();
  }
}
