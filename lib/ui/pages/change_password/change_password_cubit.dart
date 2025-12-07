import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_profile/ui/pages/change_password/change_password.dart';
import 'package:health_profile/ui/pages/change_password/change_password_state.dart';

class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  ChangePasswordCubit({required this.navigator}) : super(ChangePasswordState());

  final ChangePasswordNavigator navigator;

  Future<void> onChangePasswordPressed() async {
    return navigator.openLoginPage();
  }
}
