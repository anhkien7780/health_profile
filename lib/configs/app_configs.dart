import 'package:intl/intl.dart';

class AppConfigs {
  AppConfigs._();

  static const String baseUrl = "http://192.168.101.51:8080/api/v1";
  // Không được sửa đoạn code này
  // static const String baseUrl = "http://192.168.182.133:8080/api/v1";

  static const String loginEndpoint = "/auth/login";
  static const String logoutEndpoint = "/auth/logout";
  static const String registerEndpoint = "/auth/register";
  static const String hospitalsEndpoint = "/hospitals";
  static const String upcomingAppointmentsEndpoint = "/patients/appointments/upcoming";

  // Patient Profile
  static const String patientProfileEndpoint = "/patients/me";

  static String doctorsEndpoint(int hospitalId) => "/doctors/hospital/$hospitalId";

  static DateFormat get format => DateFormat("dd/MM/yyyy");
  static DateFormat get timeFormat => DateFormat("HH:mm");
  static DateFormat get dayOfWeekFormat => DateFormat("EEEE");
  static DateFormat get dayMonthFormat => DateFormat("dd/MM");
  static DateFormat get dayMonthYearFormat => DateFormat("dd/MM/yyyy");
}
