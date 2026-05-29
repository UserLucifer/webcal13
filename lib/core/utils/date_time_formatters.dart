import 'package:intl/intl.dart';

class DateTimeFormatters {
  static final _dateTime = DateFormat('yyyy-MM-dd HH:mm');
  static final _date = DateFormat('yyyy-MM-dd');

  static String compact(String? value) {
    if (value == null || value.isEmpty) {
      return '--';
    }
    final parsed = DateTime.tryParse(value);
    if (parsed == null) {
      return value;
    }
    return _dateTime.format(parsed.toLocal());
  }

  static String date(String? value) {
    if (value == null || value.isEmpty) {
      return '--';
    }
    final parsed = DateTime.tryParse(value);
    if (parsed == null) {
      return value;
    }
    return _date.format(parsed.toLocal());
  }
}
