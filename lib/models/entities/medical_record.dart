class MedicalRecord {
  final int id;
  final int patientId;
  final int doctorId;
  final int hospitalId;
  final int appointmentId;
  final String symptoms;
  final String diagnosis;
  final String treatment;
  final String status;
  final String recordDate;
  final String? notes;
  final String createdAt;
  final String updatedAt;

  MedicalRecord({
    required this.id,
    required this.patientId,
    required this.doctorId,
    required this.hospitalId,
    required this.appointmentId,
    required this.symptoms,
    required this.diagnosis,
    required this.treatment,
    required this.status,
    required this.recordDate,
    this.notes,
    required this.createdAt,
    required this.updatedAt,
  });

  factory MedicalRecord.fromJson(Map<String, dynamic> json) {
    return MedicalRecord(
      id: json['id'],
      patientId: json['patientId'],
      doctorId: json['doctorId'],
      hospitalId: json['hospitalId'],
      appointmentId: json['appointmentId'],
      symptoms: json['symptoms'],
      diagnosis: json['diagnosis'],
      treatment: json['treatment'],
      status: json['status'],
      recordDate: json['recordDate'],
      notes: json['notes'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }
}
