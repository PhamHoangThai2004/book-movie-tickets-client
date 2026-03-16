import 'package:client/core/utils/validator.dart';
import 'package:easy_localization/easy_localization.dart';

class AppUtils {
  static String validationEmail(String email) {
    final value = email.trim();
    if (value.isEmpty) {
      return 'email_empty_error'.tr();
    } else if (value.length > 50) {
      return 'email_too_long_error'.tr();
    } else {
      return Validator.isValidEmail(value) ? '' : 'email_fail'.tr();
    }
  }

  static String validationPassword(String password) {
    final value = password.trim();
    if (value.isEmpty) {
      return 'password_empty_error'.tr();
    } else if (value.length > 50) {
      return 'password_too_long_error'.tr();
    } else {
      return Validator.isValidPassword(value) ? '' : 'password_fail'.tr();
    }
  }

  static String validationName(String name) {
    final value = name.trim();
    if (value.isEmpty) {
      return 'name_empty_error'.tr();
      } else if (value.length > 50) {
      return 'name_too_long_error'.tr();
      } else {
      return Validator.isValidName(value) ? '' : 'name_fail'.tr();
    }
  }
}
