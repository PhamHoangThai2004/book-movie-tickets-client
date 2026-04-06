import 'package:easy_localization/easy_localization.dart';

class StringUtils {
  static String formatVND(int value) {
    final formatter = NumberFormat('#,##0', 'vi_VN');
    return '${formatter.format(value).replaceAll(',', '.')} VND';
  }
}