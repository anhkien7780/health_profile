class AppointmentDisplay {
  final int orderNumber;
  final String hospitalName;
  final String date;
  final String time;
  final String doctorName;

  AppointmentDisplay({
    required this.orderNumber,
    required this.hospitalName,
    required this.date,
    required this.time,
    required this.doctorName,
  });

  factory AppointmentDisplay.fromJson(Map<String, dynamic> json) {
    return AppointmentDisplay(
      orderNumber: json['queueNumber'] as int,
      hospitalName: json['hospitalName'] as String,
      date: json['appointmentDate'] as String,
      time: json['appointmentTime'] as String,
      doctorName: json['doctorName'] as String,
    );
  }
}
