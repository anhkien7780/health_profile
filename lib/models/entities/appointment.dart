import 'package:health_profile/models/entities/selection_item.dart';

class Appointment {
  final SelectionItem hospital;
  final SelectionItem doctor;
  final DateTime date;
  final DateTime time;
  final String roomName;
  final String? note;

  Appointment({
    required this.hospital,
    required this.doctor,
    required this.date,
    required this.time,
    required this.roomName,
    this.note,
  });

  Map<String, dynamic> toJson() {
    return {
      'hospital_id': hospital.id,
      'doctor_id': doctor.id,
      'date': date.toIso8601String(),
      'time': time.toIso8601String(),
      'room_name': roomName,
      'note': note,
    };
  }
}
