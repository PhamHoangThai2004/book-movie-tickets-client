import 'package:easy_localization/easy_localization.dart';

class DateTimeUtils {
  static String fromIso8601(String? isoDate,
      {String targetFormat = 'dd/MM/yyyy'}) {
    if (isoDate == null || isoDate.isEmpty) return '';
    try {
      final dateTime = DateTime.parse(isoDate);
      final newFormat = DateFormat(targetFormat);
      return newFormat.format(dateTime);
    } catch (_) {
      return '';
    }
  }

  static String toIso8601(String? date, {String sourceFormat = 'yyyy/MM/dd'}) {
    if (date == null || date.isEmpty) return '';
    try {
      final format = DateFormat(sourceFormat);
      final dateTime = format.parse(date);
      return dateTime.toIso8601String();
    } catch (_) {
      return '';
    }
  }

  static String convertDuration(int duration) {
    return '${duration ~/ 60} ${'hours'.tr()} ${duration % 60} ${'minutes'.tr()}';
  }
}