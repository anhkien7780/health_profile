import 'dart:async';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:health_profile/configs/app_configs.dart';
import 'package:health_profile/database/secure_storage_helper.dart';
import 'package:health_profile/models/entities/appointment.dart';
import 'package:health_profile/models/entities/appointment_display.dart';
import 'package:health_profile/models/entities/doctor.dart';
import 'package:health_profile/models/entities/hospital.dart';
import 'package:health_profile/models/entities/schedule_slot.dart';
import 'package:health_profile/utils/date_format_helper.dart';

abstract class AppointmentRepository {
  Future<List<Hospital>> getHospitals();

  Future<List<Doctor>> getDoctors(int hospitalId);

  Future<List<ScheduleSlot>> getScheduleSlots(
      {required int doctorId, required String date});

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
  Future<List<ScheduleSlot>> getScheduleSlots(
      {required int doctorId, required String date}) async {
    try {
      final token = await SecureStorageHelper.getAccessToken();
      if (token == null) {
        throw Exception('Unauthorized: No token found.');
      }

      final response = await _dio.get(
        AppConfigs.availableSlotsEndpoint(doctorId, date),
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      if (response.statusCode == 200 && response.data['success']) {
        final List<dynamic> data = response.data['data'];
        final availableSlots = data
            .where((slot) => slot['available'] == true)
            .map((slot) => (slot['time'] as String).substring(0, 5))
            .toList();

        final morningSlots = availableSlots
            .where((time) => int.parse(time.split(':')[0]) < 12)
            .toList();

        final afternoonSlots = availableSlots
            .where((time) => int.parse(time.split(':')[0]) >= 12)
            .toList();

        final result = <ScheduleSlot>[];
        if (morningSlots.isNotEmpty) {
          result.add(
            ScheduleSlot(id: 1, roomName: 'Sáng', slots: morningSlots),
          );
        }
        if (afternoonSlots.isNotEmpty) {
          result.add(
            ScheduleSlot(id: 2, roomName: 'Chiều', slots: afternoonSlots),
          );
        }
        return result;
      } else {
        throw Exception('Failed to load schedule slots');
      }
    } catch (e) {
      throw Exception('Failed to load schedule slots: $e');
    }
  }

  @override
  Future<void> bookAppointment(Appointment appointment) async {
    try {
      final token = await SecureStorageHelper.getAccessToken();
      if (token == null) {
        throw Exception('Unauthorized: No token found.');
      }

      final allDoctorsInHospital = await getDoctors(appointment.hospital.id);
      final fullDoctorInfo = allDoctorsInHospital.firstWhere(
        (doc) => doc.id == appointment.doctor.id,
        orElse: () => throw Exception('Could not find doctor in the hospital'),
      );

      final body = {
        'doctorId': fullDoctorInfo.id,
        'hospitalId': fullDoctorInfo.hospitalId,
        'departmentId': fullDoctorInfo.departmentId,
        'appointmentDate': DateFormatHelper.dateToApiString(appointment.date),
        'appointmentTime': DateFormatHelper.dateToTimeString(appointment.time),
        'notes': appointment.note,
      };

      final response = await _dio.post(
        AppConfigs.bookAppointmentEndpoint,
        data: body,
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      if (response.statusCode == 201 && response.data['success']) {
        await getAppointments();
      } else {
        throw Exception(
          'Failed to book appointment: ${response.data['message']}',
        );
      }
    } catch (e) {
      throw Exception('Failed to book appointment: $e');
    }
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
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      if (response.statusCode == 200 && response.data['success']) {
        final List<dynamic> data = response.data['data'];
        log("Appointments: $data");
        final appointments = data
            .where((json) => json['status'] == 'PENDING')
            .map((json) => AppointmentDisplay.fromJson(json))
            .toList();
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
