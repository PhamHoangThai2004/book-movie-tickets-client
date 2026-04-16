import 'package:client/core/common/register_cubit.dart';
import 'package:client/core/customs/dialogs/dialog_custom.dart';
import 'package:client/core/utils/validator.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../data/local/preferences.dart';
import '../navigation/navigation_service.dart';

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

  static String validationPhoneNumber(String phoneNumber) {
    final value = phoneNumber.trim();
    if (value.isEmpty) {
      return 'phone_number_empty_error'.tr();
    } else {
      return Validator.isValidPhoneNumber(value) ? '' : 'phone_number_fail'.tr();
    }
  }

  static String validationNewPassword(String newPassword) {
    final value = newPassword.trim();
    if (value.isEmpty) {
      return 'new_password_empty_error'.tr();
    } else if (value.length > 50) {
      return 'new_password_too_long_error'.tr();
    } else {
      return Validator.isValidPassword(value) ? '' : 'new_password_fail'.tr();
    }
  }

  static bool isLoggedIn() {
    return Preferences.instance.accessToken.isNotEmpty;
  }

  static void requestLogin({required BuildContext context}) {
    showDialogCustom(
      context: context,
      title: 'sign_in'.tr(),
      message: 'please_login_message'.tr(),
      acceptTitle: 'sign_in'.tr(),
      acceptAction: () {
        context.push(NavigationService.signIn);
      },
    );
  }

  static void logout(BuildContext context) {
    context.dashboardCubit.logout();
    Preferences.instance.clearCurrentUserData();
    context.go(NavigationService.auth);
  }

  static void openLink(String link) async {
    debugPrint('openLink:  $link');
    final uri = Uri.parse(link);
    if (await canLaunchUrl(uri)) {
      final success = await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );
      if (!success) {
        await launchUrl(uri, mode: LaunchMode.inAppWebView);
      }
    } else {
      await launchUrl(uri, mode: LaunchMode.inAppWebView);
    }
  }
}
