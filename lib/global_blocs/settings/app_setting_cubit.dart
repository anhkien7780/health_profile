import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_profile/database/shared_preferences_helper.dart';
import 'package:health_profile/models/enum/language.dart';

import 'app_setting_state.dart';

class AppSettingCubit extends Cubit<AppSettingState> {
  AppSettingCubit()
    : super(const AppSettingState(currentLanguage: Language.vi));

  Future<void> changeLanguage(Language language) async {
    await SharedPreferencesHelper.setLanguage(language);

    emit(state.copyWith(currentLanguage: language));
  }
}
