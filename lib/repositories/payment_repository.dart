import 'dart:async';

import 'package:dio/dio.dart';
import 'package:health_profile/configs/app_configs.dart';
import 'package:health_profile/database/secure_storage_helper.dart';
import 'package:health_profile/models/entities/payment_transaction.dart';
import 'package:health_profile/models/enum/payment_method.dart';

abstract class PaymentRepository {
  Future<PaymentTransaction> createPaymentTransaction(
      {required int appointmentId, required PaymentMethod paymentMethod});

  Future<List<PaymentTransaction>> getTransactionsForAppointment(
      int appointmentId);
}

class PaymentRepositoryImpl extends PaymentRepository {
  final Dio _dio;

  PaymentRepositoryImpl({Dio? dio})
      : _dio = dio ??
            Dio(
              BaseOptions(
                baseUrl: AppConfigs.baseUrl,
                connectTimeout: const Duration(seconds: 10),
                receiveTimeout: const Duration(seconds: 10),
              ),
            );

  @override
  Future<PaymentTransaction> createPaymentTransaction(
      {required int appointmentId, required PaymentMethod paymentMethod}) async {
    try {
      final token = await SecureStorageHelper.getAccessToken();
      if (token == null) {
        throw Exception('Unauthorized: No token found.');
      }

      final response = await _dio.post(
        '/payments',
        data: {
          'appointmentId': appointmentId,
          'paymentMethod': paymentMethod.name.toUpperCase(), // Convert to uppercase for the API
        },
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      if (response.statusCode == 201 && response.data['success']) {
        return PaymentTransaction.fromJson(response.data['data']);
      } else {
        throw Exception('Failed to create payment transaction');
      }
    } catch (e) {
      throw Exception('Failed to create payment transaction: $e');
    }
  }

  @override
  Future<List<PaymentTransaction>> getTransactionsForAppointment(
      int appointmentId) async {
    try {
      final token = await SecureStorageHelper.getAccessToken();
      if (token == null) {
        throw Exception('Unauthorized: No token found.');
      }

      final response = await _dio.get(
        '/payments/appointment/$appointmentId',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      if (response.statusCode == 200 && response.data['success']) {
        final List<dynamic> data = response.data['data'];
        return data.map((json) => PaymentTransaction.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load transactions');
      }
    } catch (e) {
      throw Exception('Failed to load transactions: $e');
    }
  }
}
