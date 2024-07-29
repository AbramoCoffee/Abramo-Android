import 'package:intl/intl.dart';

class DateFormatter {
  static String convertDateTimeDisplay(
    String date,
    String format,
  ) {
    final DateFormat displayFormater = DateFormat('dd-MM-yy HH:mm:ss');
    final DateFormat serverFormater = DateFormat(format);
    final DateTime displayDate = displayFormater.parse(date);
    final String formatted = serverFormater.format(displayDate);
    return formatted;
  }
}
