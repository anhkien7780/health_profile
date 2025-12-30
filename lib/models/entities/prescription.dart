import 'package:equatable/equatable.dart';
import 'package:health_profile/models/entities/prescription_item.dart';

class Prescription extends Equatable {
  final int id;
  final int medicalRecordId;
  final int? doctorId;
  final int? patientId;
  final String createdAt;
  final List<PrescriptionItem> items;

  const Prescription({
    required this.id,
    required this.medicalRecordId,
    this.doctorId,
    this.patientId,
    required this.createdAt,
    required this.items,
  });

  factory Prescription.fromJson(Map<String, dynamic> json) {
    return Prescription(
      id: json['id'],
      medicalRecordId: json['medicalRecordId'],
      doctorId: json['doctorId'],
      patientId: json['patientId'],
      createdAt: json['createdAt'],
      items: json['items'] != null
          ? (json['items'] as List)
              .map((item) => PrescriptionItem.fromJson(item))
              .toList()
          : [],
    );
  }

  @override
  List<Object?> get props => [
        id,
        medicalRecordId,
        doctorId,
        patientId,
        createdAt,
        items,
      ];
}
