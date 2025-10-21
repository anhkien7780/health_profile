import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_profile/ui/pages/sign_up/sign_up_navigator.dart';
import 'package:health_profile/ui/pages/sign_up/sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit({required this.navigator}) : super(SignUpState());

  final SignUpNavigator navigator;

  Future<void> openLoginPage() async {
    await navigator.openLoginPage();
  }
}
