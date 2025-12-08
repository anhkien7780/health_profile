class Doctor {
  final int id;
  final String fullName;
  final String specialty;
  final int hospitalId;
  final int departmentId;
  final int experienceYears;
  final double consultationFee;
  final double rating;
  final double distance;
  final String avatarUrl;

  Doctor({
    required this.id,
    required this.fullName,
    required this.specialty,
    required this.hospitalId,
    required this.departmentId,
    required this.experienceYears,
    required this.consultationFee,
    this.rating = 0.0,
    this.distance = 0.0,
    this.avatarUrl = "https://i.pravatar.cc/150?img=11",
  });

  factory Doctor.fromJson(Map<String, dynamic> json) {
    return Doctor(
      id: json['id'],
      fullName: json['fullName'],
      specialty: json['specialty'],
      hospitalId: json['hospitalId'],
      departmentId: json['departmentId'],
      experienceYears: json['experienceYears'],
      consultationFee: (json['consultationFee'] as num).toDouble(),
    );
  }
}
