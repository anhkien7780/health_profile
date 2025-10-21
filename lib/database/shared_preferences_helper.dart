import 'package:health_profile/models/enum/language.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  SharedPreferencesHelper._();

  static const _firstRunKey = "first_run";
  static const _languageKey = "language";

  static Future<void> setLanguage(Language language) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_languageKey, language.toString());
  }

  static Future<Language> getLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    final languageString = prefs.getString(_languageKey);
    if (languageString == Language.en.name) {
      return Language.en;
    } else {
      return Language.vi;
    }
  }

  static Future<bool> isFirstRun() async {
    final prefs = await SharedPreferences.getInstance();
    final isFirstRun = prefs.getBool(_firstRunKey) ?? true;
    if (isFirstRun) {
      await prefs.setBool(_firstRunKey, false);
    }
    return isFirstRun;
  }
}
