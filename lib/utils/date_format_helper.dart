import 'package:health_profile/configs/app_configs.dart';

class DateFormatHelper {
  DateFormatHelper._();

  static String dateToString(DateTime date) {
    return AppConfigs.format.format(date);
  }

  static DateTime stringToDate(String dateString) {
    return AppConfigs.format.parse(dateString);
  }

  static String dateToTimeString(DateTime date) {
    return AppConfigs.timeFormat.format(date);
  }

  static DateTime stringToTime(String timeString) {
    return AppConfigs.timeFormat.parse(timeString);
  }
}
