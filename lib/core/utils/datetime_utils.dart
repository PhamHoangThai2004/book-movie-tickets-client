import 'package:easy_localization/easy_localization.dart';

class DatetimeUtils {
  static String fromIso8601(String? isoDate,
      {String targetFormat = 'dd/MM/yyyy'}) {
    if (isoDate == null || isoDate.isEmpty) return '';
    try {
      final dateTime = DateTime.parse(isoDate).toLocal();
      final newFormat = DateFormat(targetFormat);
      return newFormat.format(dateTime);
    } catch (_) {
      return '';
    }
  }

  static String toIso8601(String? date, {String sourceFormat = 'dd/MM/yyyy'}) {
    if (date == null || date.isEmpty) return '';
    try {
      final format = DateFormat(sourceFormat);
      final dateTime = format.parse(date);
      return dateTime.toIso8601String();
    } catch (_) {
      return '';
    }
  }
}