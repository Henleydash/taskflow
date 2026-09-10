import 'package:intl/intl.dart';

/// Isolated so formatting rules are unit-testable without a widget tree.
class DateFormatter {
  DateFormatter._();

  static String short(DateTime date, String localeCode) {
    return DateFormat.yMMMd(localeCode).format(date);
  }

  static bool isToday(DateTime date) {
    final now = DateTime.now();
    return date.year == now.year &&
        date.month == now.month &&
        date.day == now.day;
  }
}
