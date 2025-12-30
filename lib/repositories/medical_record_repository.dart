import 'dart:async';

import 'package:dio/dio.dart';
import 'package:health_profile/configs/app_configs.dart';
import 'package:health_profile/database/secure_storage_helper.dart';
import 'package:health_profile/models/entities/medical_record.dart';

abstract class MedicalRecordRepository {
  Future<List<MedicalRecord>> getMedicalRecords(int patientId);
}

class MedicalRecordRepositoryImpl extends MedicalRecordRepository {
  final Dio _dio;

  MedicalRecordRepositoryImpl({Dio? dio})
      : _dio = dio ??
            Dio(
              BaseOptions(
                baseUrl: AppConfigs.baseUrl,
                connectTimeout: const Duration(seconds: 10),
                receiveTimeout: const Duration(seconds: 10),
              ),
            );

  @override
  Future<List<MedicalRecord>> getMedicalRecords(int patientId) async {
    try {
      final token = await SecureStorageHelper.getAccessToken();
      if (token == null) {
        throw Exception('Unauthorized: No token found.');
      }

      final response = await _dio.get(
        AppConfigs.medicalRecordEndpoint(patientId),
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      if (response.statusCode == 200 && response.data['success']) {
        final List<dynamic> data = response.data['data'];
        return data.map((json) => MedicalRecord.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load medical records');
      }
    } catch (e) {
      throw Exception('Failed to load medical records: $e');
    }
  }
}
