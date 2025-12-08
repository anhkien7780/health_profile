import 'package:intl/intl.dart';

class AppConfigs {
  AppConfigs._();

  static DateFormat get format => DateFormat("dd/MM/yyyy");
  static DateFormat get timeFormat => DateFormat("HH:mm");
  static DateFormat get dayOfWeekFormat => DateFormat("EEEE");
  static DateFormat get dayMonthFormat => DateFormat("dd/MM");
  static DateFormat get dayMonthYearFormat => DateFormat("dd/MM/yyyy");
}
