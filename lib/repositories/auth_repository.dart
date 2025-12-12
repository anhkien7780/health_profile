import 'package:dio/dio.dart';
import 'package:health_profile/configs/app_configs.dart';
import 'package:health_profile/database/secure_storage_helper.dart';

abstract class AuthRepository {
  Future<String> login(String email, String password);

  Future<void> logout();
}

class AuthRepositoryImpl implements AuthRepository {
  final Dio _dio;

  AuthRepositoryImpl({Dio? dio})
      : _dio = dio ??
            Dio(
              BaseOptions(
                baseUrl: AppConfigs.baseUrl,
                connectTimeout: const Duration(seconds: 10),
                receiveTimeout: const Duration(seconds: 10),
              ),
            );

  @override
  Future<String> login(String email, String password) async {
    try {
      final response = await _dio.post(
        AppConfigs.loginEndpoint,
        data: {
          "email": email,
          "password": password,
        },
      );

      if (response.statusCode == 200 && response.data != null) {
        final data = response.data;
        if (data['success'] == true) {
          final token = data['data']['token'];
          await SecureStorageHelper.setAccessToken(token);
          return token;
        } else {
          throw Exception(data['message'] ?? "Login failed");
        }
      } else {
        throw Exception("Login failed: ${response.statusMessage}");
      }
    } on DioException catch (e) {
      if (e.response != null && e.response?.data != null) {
        final data = e.response?.data;
        if (data is Map<String, dynamic> && data['message'] != null) {
          throw Exception(data['message']);
        }
      }
      throw Exception("Network error: ${e.message}");
    } catch (e) {
      throw Exception("An unexpected error occurred: $e");
    }
  }

  @override
  Future<void> logout() async {
    try {
      final token = await SecureStorageHelper.getAccessToken();
      if (token == null) return;

      final response = await _dio.post(
        AppConfigs.logoutEndpoint,
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
          },
        ),
      );

      if (response.statusCode == 200 && response.data != null) {
        final data = response.data;
        if (data['success'] != true) {
          throw Exception(data['message'] ?? "Logout failed");
        }
      }
    } on DioException catch (e) {
      if (e.response != null && e.response?.data != null) {
        final data = e.response?.data;
        if (data is Map<String, dynamic> && data['message'] != null) {
          throw Exception(data['message']);
        }
      }
      throw Exception("Network error: ${e.message}");
    } catch (e) {
      throw Exception("An unexpected error occurred: $e");
    } finally {
      await SecureStorageHelper.removeAccessToken();
    }
  }
}
