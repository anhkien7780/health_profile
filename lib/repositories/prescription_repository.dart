import 'dart:async';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:health_profile/configs/app_configs.dart';
import 'package:health_profile/database/secure_storage_helper.dart';
import 'package:health_profile/models/entities/prescription.dart';

abstract class PrescriptionRepository {
  Future<Prescription> getPrescriptionByMedicalRecord(String medicalRecordId);
}

class PrescriptionRepositoryImpl extends PrescriptionRepository {
  final Dio _dio;

  PrescriptionRepositoryImpl({Dio? dio})
      : _dio = dio ??
            Dio(
              BaseOptions(
                baseUrl: AppConfigs.baseUrl,
                connectTimeout: const Duration(seconds: 10),
                receiveTimeout: const Duration(seconds: 10),
              ),
            );

  @override
  Future<Prescription> getPrescriptionByMedicalRecord(String medicalRecordId) async {
    try {
      final token = await SecureStorageHelper.getAccessToken();
      if (token == null) {
        throw Exception('Unauthorized: No token found.');
      }

      final response = await _dio.get(
        AppConfigs.prescriptionByMedicalRecordEndpoint(medicalRecordId),
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      log('Prescription response: ${response.data}');

      if (response.statusCode == 200 && response.data['success']) {
        return Prescription.fromJson(response.data['data']);
      } else {
        throw Exception('Failed to load prescription');
      }
    } catch (e) {
      log('Failed to load prescription for medical record $medicalRecordId: $e');
      throw Exception('Failed to load prescription: $e');
    }
  }
}
