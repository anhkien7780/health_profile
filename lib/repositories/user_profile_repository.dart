import 'package:health_profile/database/shared_preferences_helper.dart';
import 'package:health_profile/models/entities/user_profile.dart';

abstract class UserProfileRepository {
  Future<void> saveUserProfile(Map<String, dynamic> userProfile);

  Future<UserProfile?> getUserProfile();
}

class UserProfileRepositoryImpl implements UserProfileRepository {
  @override
  Future<void> saveUserProfile(Map<String, dynamic> userProfile) {
    return SharedPreferencesHelper.saveUserProfile(userProfile);
  }

  @override
  Future<UserProfile?> getUserProfile() {
    return SharedPreferencesHelper.getUserProfile();
  }
}
