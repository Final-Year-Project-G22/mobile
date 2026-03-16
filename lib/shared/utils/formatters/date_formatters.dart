import 'package:intl/intl.dart';

class DateFormatters {
  DateFormatters._();

  static final _fullDate = DateFormat('MMMM dd, yyyy');
  static final _shortDate = DateFormat('MMM dd, yyyy');
  static final _numericDate = DateFormat('dd/MM/yyyy');
  static final _time = DateFormat('HH:mm');
  static final _time12 = DateFormat('hh:mm a');
  static final _dateTime = DateFormat('MMM dd, yyyy HH:mm');
  static final _dateTime12 = DateFormat('MMM dd, yyyy hh:mm a');
  static final _monthYear = DateFormat('MMMM yyyy');
  static final _dayMonth = DateFormat('dd MMM');
  static final _iso = DateFormat('yyyy-MM-dd');

  static String fullDate(DateTime date) => _fullDate.format(date);
  static String shortDate(DateTime date) => _shortDate.format(date);
  static String numericDate(DateTime date) => _numericDate.format(date);
  static String time(DateTime date) => _time.format(date);
  static String time12(DateTime date) => _time12.format(date);
  static String dateTime(DateTime date) => _dateTime.format(date);
  static String dateTime12(DateTime date) => _dateTime12.format(date);
  static String monthYear(DateTime date) => _monthYear.format(date);
  static String dayMonth(DateTime date) => _dayMonth.format(date);
  static String iso(DateTime date) => _iso.format(date);

  static String custom(DateTime date, String pattern) {
    return DateFormat(pattern).format(date);
  }
}
