import 'package:equatable/equatable.dart';

class PrescriptionItem extends Equatable {
  final int id;
  final int medicineId;
  final String medicineName;
  final String dosage;
  final String frequency;
  final String duration;
  final int quantity;
  final String instructions;

  const PrescriptionItem({
    required this.id,
    required this.medicineId,
    required this.medicineName,
    required this.dosage,
    required this.frequency,
    required this.duration,
    required this.quantity,
    required this.instructions,
  });

  factory PrescriptionItem.fromJson(Map<String, dynamic> json) {
    return PrescriptionItem(
      id: json['id'],
      medicineId: json['medicineId'],
      medicineName: json['medicineName'],
      dosage: json['dosage'],
      frequency: json['frequency'],
      duration: json['duration'],
      quantity: json['quantity'],
      instructions: json['instructions'],
    );
  }

  @override
  List<Object?> get props => [
        id,
        medicineId,
        medicineName,
        dosage,
        frequency,
        duration,
        quantity,
        instructions,
      ];
}
