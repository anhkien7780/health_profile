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
    this.avatarUrl = "https://cdn.prod.website-files.com/62d4f06f9c1357a606c3b7ef/65ddf3cdf19abaf5688af2f8_shutterstock_1933145801%20(1).jpg",
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
