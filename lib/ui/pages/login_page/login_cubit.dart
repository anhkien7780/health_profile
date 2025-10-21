import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_profile/ui/pages/login_page/login_navigator.dart';

import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit({required this.navigator}) : super(LoginState());

  final LoginNavigator navigator;
}
