import 'package:bot_toast/bot_toast.dart';
import 'package:client/core/themes/app_colors.dart';
import 'package:flutter/cupertino.dart';

import '../../generated/assets.gen.dart';
import '../size_config/app_dimen.dart';
import '../size_config/dimens.dart';
import '../size_config/size_config.dart';
import '../styles/app_text_styles.dart';
import 'cupertino_button_custom.dart';

mixin ToastCustom {
  static void show({
    ToastType type = ToastType.error,
    required String message,
    int durationMilliseconds = 3000,
  }) {
    BotToast.cleanAll();
    late CancelFunc cancel;

    cancel = BotToast.showCustomNotification(
      animationDuration: const Duration(milliseconds: 300),
      animationReverseDuration: const Duration(milliseconds: 300),
      duration: Duration(milliseconds: durationMilliseconds),
      backButtonBehavior: BackButtonBehavior.close,
      toastBuilder: (_) {
        return Container(
          margin: EdgeInsets.symmetric(horizontal: Dimens.d20.responsive()),
          padding: EdgeInsets.all(Dimens.d12.responsive()),
          decoration: BoxDecoration(
            color: type.backgroundColor,
            borderRadius: BorderRadius.circular(Dimens.d10.responsive()),
          ),
          child: Row(
            children: [
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Assets.svgs.icExclamationCircle.svg(),
                    HorizontalSpacing(of: Dimens.d8.responsive()),
                    Flexible(child: Text(message, style: AppTextStyles.style.s14.w400.whiteColor)),
                  ],
                ),
              ),
              CupertinoButtonCustom(
                onPressed: () {
                  cancel();
                },
                child: Container(
                  padding: EdgeInsets.all(Dimens.d4.responsive()),
                  child: Assets.svgs.icClose.svg(width: Dimens.d8.responsive()),
                ),
              ),
            ],
          ),
        );
      },
      enableSlideOff: true,
      onlyOne: true,
      crossPage: true,
      useSafeArea: true,
    );
  }
}

enum ToastType { success, error, info }

extension ToastTypeX on ToastType {
  Color get backgroundColor {
    switch (this) {
      case ToastType.success:
        return AppColors.green;
      case ToastType.error:
        return AppColors.red;
      case ToastType.info:
        return AppColors.blue;
    }
  }
}
