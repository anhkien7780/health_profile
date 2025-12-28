import 'dart:async';

import 'package:dio/dio.dart';
import 'package:health_profile/configs/app_configs.dart';
import 'package:health_profile/models/entities/appointment.dart';
import 'package:health_profile/models/entities/appointment_display.dart';
import 'package:health_profile/models/entities/doctor.dart';
import 'package:health_profile/models/entities/hospital.dart';
import 'package:health_profile/models/entities/schedule_slot.dart';
import 'package:intl/intl.dart';

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
  final List<AppointmentDisplay> _bookedAppointments = [];
  final List<AppointmentDisplay> _predefinedAppointments = [
    AppointmentDisplay(
      orderNumber: 1,
      hospitalName: 'Bệnh viện K Cơ sở 1',
      time: '08:30',
      doctorName: 'Bác sỹ A',
    ),
    AppointmentDisplay(
      orderNumber: 2,
      hospitalName: 'Bệnh viện K Cơ sở 2',
      time: '09:00',
      doctorName: 'Bác sỹ B',
    ),
    AppointmentDisplay(
      orderNumber: 3,
      hospitalName: 'Bệnh viện K Cơ sở 3',
      time: '09:30',
      doctorName: 'Bác sỹ C',
    ),
  ];

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
    final newAppointment = AppointmentDisplay(
      orderNumber:
          _predefinedAppointments.length + _bookedAppointments.length + 1,
      hospitalName: appointment.hospital.title,
      time: DateFormat('HH:mm').format(appointment.time),
      doctorName: appointment.doctor.title,
    );
    _bookedAppointments.add(newAppointment);
    _appointmentsController.add([..._predefinedAppointments, ..._bookedAppointments]);
  }

  @override
  Future<List<AppointmentDisplay>> getAppointments() async {
    await Future.delayed(const Duration(seconds: 1));
    return [..._predefinedAppointments, ..._bookedAppointments];
  }

  @override
  void dispose() {
    _appointmentsController.close();
  }
}
