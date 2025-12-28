import 'package:intl/intl.dart';

class AppConfigs {
  AppConfigs._();

  static const String baseUrl = "http://192.168.101.51:8080/api/v1";
  static const String loginEndpoint = "/auth/login";
  static const String logoutEndpoint = "/auth/logout";
  static const String registerEndpoint = "/auth/register";

  static DateFormat get format => DateFormat("dd/MM/yyyy");
  static DateFormat get timeFormat => DateFormat("HH:mm");
  static DateFormat get dayOfWeekFormat => DateFormat("EEEE");
  static DateFormat get dayMonthFormat => DateFormat("dd/MM");
  static DateFormat get dayMonthYearFormat => DateFormat("dd/MM/yyyy");
}
