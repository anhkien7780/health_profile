import 'dart:convert';

import 'package:health_profile/models/entities/user_profile.dart';
import 'package:health_profile/models/enum/language.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  SharedPreferencesHelper._();

  static const _firstRunKey = "first_run";
  static const _languageKey = "language";
  static const _userProfileKey = "user_profile";

  static Future<void> saveUserProfile(Map<String, dynamic> userProfile) async {
    final prefs = await SharedPreferences.getInstance();
    final profileToSave = Map<String, dynamic>.from(userProfile);
    profileToSave.remove('password');
    await prefs.setString(_userProfileKey, jsonEncode(profileToSave));
  }

  static Future<UserProfile?> getUserProfile() async {
    final prefs = await SharedPreferences.getInstance();
    final userProfileString = prefs.getString(_userProfileKey);
    if (userProfileString != null) {
      return UserProfile.fromJson(jsonDecode(userProfileString));
    }
    return null;
  }

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
