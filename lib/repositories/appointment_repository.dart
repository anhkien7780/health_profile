import 'dart:async';

import 'package:dio/dio.dart';
import 'package:health_profile/configs/app_configs.dart';
import 'package:health_profile/database/secure_storage_helper.dart';
import 'package:health_profile/models/entities/appointment.dart';
import 'package:health_profile/models/entities/appointment_display.dart';
import 'package:health_profile/models/entities/doctor.dart';
import 'package:health_profile/models/entities/hospital.dart';
import 'package:health_profile/models/entities/schedule_slot.dart';

abstract class AppointmentRepository {
  Future<List<Hospital>> getHospitals();

  Future<List<Doctor>> getDoctors(int hospitalId);

  Future<List<ScheduleSlot>> getScheduleSlots();

  Future<void> bookAppointment(Appointment appointment);

  Future<List<AppointmentDisplay>> getAppointments();

  Stream<List<AppointmentDisplay>> get appointmentsStream;

  void dispose();
}

class AppointmentRepositoryImpl extends AppointmentRepository {
  final Dio _dio;
  final _appointmentsController =
      StreamController<List<AppointmentDisplay>>.broadcast();

  AppointmentRepositoryImpl({Dio? dio})
      : _dio = dio ??
            Dio(
              BaseOptions(
                baseUrl: AppConfigs.baseUrl,
                connectTimeout: const Duration(seconds: 10),
                receiveTimeout: const Duration(seconds: 10),
              ),
            );

  @override
  Stream<List<AppointmentDisplay>> get appointmentsStream =>
      _appointmentsController.stream;

  @override
  Future<List<Hospital>> getHospitals() async {
    try {
      final response = await _dio.get(AppConfigs.hospitalsEndpoint);
      if (response.statusCode == 200 && response.data['success']) {
        final List<dynamic> data = response.data['data'];
        return data.map((json) => Hospital.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load hospitals');
      }
    } catch (e) {
      throw Exception('Failed to load hospitals: $e');
    }
  }

  @override
  Future<List<Doctor>> getDoctors(int hospitalId) async {
    try {
      final response = await _dio.get(AppConfigs.doctorsEndpoint(hospitalId));
      if (response.statusCode == 200 && response.data['success']) {
        final List<dynamic> data = response.data['data'];
        return data.map((json) => Doctor.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load doctors');
      }
    } catch (e) {
      throw Exception('Failed to load doctors: $e');
    }
  }

  @override
  Future<List<ScheduleSlot>> getScheduleSlots() async {
    await Future.delayed(const Duration(seconds: 1));
    return [
      ScheduleSlot(
        id: 1,
        roomName: "Phòng khám dị ứng (P.312 Nhà C)",
        slots: ["07:00", "07:15", "07:30", "08:00", "13:00"],
      ),
      ScheduleSlot(
        id: 2,
        roomName: "Phòng khám dị ứng (P.412 Nhà C)",
        slots: ["08:00", "13:00", "13:30", "14:00", "14:30"],
      ),
    ];
  }

  @override
  Future<void> bookAppointment(Appointment appointment) async {
    await Future.delayed(const Duration(seconds: 2));
    await getAppointments();
  }

  @override
  Future<List<AppointmentDisplay>> getAppointments() async {
    try {
      final token = await SecureStorageHelper.getAccessToken();
      if (token == null) {
        throw Exception('Unauthorized: No token found.');
      }

      final response = await _dio.get(
        AppConfigs.upcomingAppointmentsEndpoint,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200 && response.data['success']) {
        final List<dynamic> data = response.data['data'];
        final appointments =
            data.map((json) => AppointmentDisplay.fromJson(json)).toList();
        _appointmentsController.add(appointments);
        return appointments;
      } else {
        final error = 'Failed to load upcoming appointments';
        _appointmentsController.addError(error);
        throw Exception(error);
      }
    } catch (e) {
      final error = 'Failed to load upcoming appointments: $e';
      _appointmentsController.addError(error);
      throw Exception(error);
    }
  }

  @override
  void dispose() {
    _appointmentsController.close();
  }
}
