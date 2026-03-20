import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';

import '../size_config/app_dimen.dart';
import '../size_config/dimens.dart';
import '../themes/app_colors.dart';

class LoadingCustom {
  static final LoadingCustom _instance = LoadingCustom.internal();

  factory LoadingCustom() => _instance;

  LoadingCustom.internal();

  static int referenceCount = 0;

  static void show({bool clickClose = false}) {
    if (referenceCount == 0) {
      BotToast.showCustomLoading(
        clickClose: clickClose,
        allowClick: false,
        backButtonBehavior: BackButtonBehavior.none,
        ignoreContentClick: true,
        animationDuration: const Duration(milliseconds: 200),
        animationReverseDuration: const Duration(milliseconds: 200),
        align: Alignment.center,
        backgroundColor: AppColors.black.withValues(alpha: 0.6),
        toastBuilder: (cancelFunc) {
          return CupertinoActivityIndicator(
            radius: Dimens.d15.responsive(),
            color: AppColors.white,
          );
        },
      );
    }
    referenceCount += 1;
  }

  static void hideLoading() {
    if (referenceCount > 0) {
      referenceCount -= 1;
      if (referenceCount == 0) {
        BotToast.closeAllLoading();
      }
    }
  }

  static void forceHide() {
    referenceCount = 0;
    BotToast.closeAllLoading();
  }
}
