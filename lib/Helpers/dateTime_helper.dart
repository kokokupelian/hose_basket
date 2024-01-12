import 'package:intl/intl.dart';

DateTime? StringToDate(String? dateTime) {
  if (dateTime == null) return null;

  return DateFormat("yyyy-MM-dd HH:mm:ss").parse(dateTime);
}
