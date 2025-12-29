import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:health_profile/configs/app_configs.dart';
import 'package:health_profile/database/secure_storage_helper.dart';
import 'package:health_profile/database/shared_preferences_helper.dart';
import 'package:health_profile/models/entities/user_profile.dart';

abstract class UserProfileRepository {
  Future<void> saveUserProfile(Map<String, dynamic> userProfile);

  Future<UserProfile?> getUserProfile();
}

class UserProfileRepositoryImpl implements UserProfileRepository {
  final Dio _dio;

  UserProfileRepositoryImpl({Dio? dio})
      : _dio = dio ??
            Dio(
              BaseOptions(
                baseUrl: AppConfigs.baseUrl,
                connectTimeout: const Duration(seconds: 10),
                receiveTimeout: const Duration(seconds: 10),
              ),
            );

  @override
  Future<void> saveUserProfile(Map<String, dynamic> userProfile) async {
    try {
      final token = await SecureStorageHelper.getAccessToken();
      if (token == null) {
        throw Exception('Unauthorized: No token found.');
      }

      final response = await _dio.patch(
        AppConfigs.patientProfileEndpoint,
        data: userProfile,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200 && response.data['success']) {
        final updatedProfileData = response.data['data'];
        await SharedPreferencesHelper.saveUserProfile(updatedProfileData);
      } else {
        throw Exception('Failed to update user profile on server');
      }
    } catch (e) {
      throw Exception('Failed to save user profile: $e');
    }
  }

  @override
  Future<UserProfile?> getUserProfile() async {
    try {
      final token = await SecureStorageHelper.getAccessToken();
      if (token == null) {
        throw Exception('Unauthorized: No token found.');
      }

      final response = await _dio.get(
        AppConfigs.patientProfileEndpoint,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200 && response.data['success']) {
        final profileData = response.data['data'];
        await SharedPreferencesHelper.saveUserProfile(profileData);
        return UserProfile.fromJson(profileData);
      }
    } catch (e) {
      log('Failed to fetch profile from server, falling back to local storage. Error: $e');
    }

    return SharedPreferencesHelper.getUserProfile();
  }
}
