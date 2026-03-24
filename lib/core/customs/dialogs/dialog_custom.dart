import 'package:client/core/customs/buttons/button_custom.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../generated/assets.gen.dart';
import '../../size_config/app_dimen.dart';
import '../../size_config/dimens.dart';
import '../../size_config/size_config.dart';
import '../../styles/app_text_styles.dart';
import '../../themes/app_colors.dart';
import '../../themes/app_themes.dart';
import '../buttons/cupertino_button_custom.dart';

Future<void> showDialogCustom({
  required BuildContext context,
  required String title,
  String? subTitle,
  required String message,
  required Function() acceptAction,
  String? acceptTitle,
  String? cancelTitle,
  Function()? cancelAction,
  bool isHideCancel = false,
  Widget? icon,
  bool barrierDismissible = false,
  bool isShowCloseButton = false,
}) async {
  await showDialog(
    context: context,
    barrierColor: AppColors.black.withValues(alpha: 0.5),
    barrierDismissible: barrierDismissible,
    useSafeArea: true,
    builder: (context) => _DialogCustom(
      title: title,
      subTitle: subTitle,
      message: message,
      acceptAction: acceptAction,
      acceptTitle: acceptTitle,
      isHideCancel: isHideCancel,
      cancelTitle: cancelTitle,
      cancelAction: cancelAction,
      icon: icon,
      isShowCloseButton: isShowCloseButton,
    ),
  );
}

class _DialogCustom extends StatefulWidget {
  const _DialogCustom({
    required this.title,
    this.subTitle,
    required this.message,
    required this.acceptAction,
    required this.isHideCancel,
    this.acceptTitle,
    this.cancelTitle,
    this.cancelAction,
    this.icon,
    required this.isShowCloseButton,
  });

  final String title;
  final String message;
  final String? subTitle;
  final Function() acceptAction;
  final bool isHideCancel;
  final String? acceptTitle;
  final String? cancelTitle;
  final Function()? cancelAction;
  final Widget? icon;
  final bool isShowCloseButton;

  @override
  State<StatefulWidget> createState() => _DialogCustomState();
}

class _DialogCustomState extends State<_DialogCustom> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: SizeConfig.appDefaultPadding),
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: SizeConfig.appDefaultPadding),
            decoration: BoxDecoration(
              color: AppColors.darkCharcoal,
              borderRadius: BorderRadius.all(Radius.circular(Dimens.d15.responsive())),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                VerticalSpacing(of: Dimens.d14.responsive()),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(widget.title, style: AppTextStyles.style.s18.w700.whiteColor),
                ),
                VerticalSpacing(of: Dimens.d12.responsive()),
                widget.icon ?? Assets.images.imgNameApp.image(
                    width: Dimens.d300.responsive(),
                    height: Dimens.d100.responsive(),
                ),
                VerticalSpacing(of: Dimens.d16.responsive()),
                if (widget.subTitle != null) ...[
                  Text(
                    widget.subTitle ?? "",
                    style: AppTextStyles.style.s20.w500.whiteColor,
                    textAlign: TextAlign.center,
                  ),
                ],
                Text(
                  widget.message,
                  style: AppTextStyles.style.s16.w300.silverColor,
                  textAlign: TextAlign.center,
                ),
                VerticalSpacing(of: Dimens.d24.responsive()),
                _buildButtons(),
                VerticalSpacing(of: Dimens.d20.responsive()),
              ],
            ),
          ),
          if (widget.isShowCloseButton)
            Positioned(
              top: Dimens.d12.responsive(),
              right: Dimens.d12.responsive(),
              child: CupertinoButtonCustom(
                padding: EdgeInsets.zero,
                onPressed: () => context.pop(),
                child: Container(
                  padding: EdgeInsets.all(Dimens.d8.responsive()),
                  decoration: BoxDecoration(
                    color: AppColors.white.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Assets.svgs.icClose.svg(
                    width: Dimens.d12.responsive(),
                    colorFilter: const ColorFilter.mode(AppColors.white, BlendMode.srcIn),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildButtons() {
    return Row(
      spacing: Dimens.d10.responsive(),
      children: [
        if (!widget.isHideCancel) ...{
          Expanded(
            child: ButtonCustom(
              title: widget.cancelTitle ?? 'cancel'.tr(),
              titleStyle: AppTextStyles.style.w600.s17.whiteColor,
              buttonStyle: AppThemes.disabledButtonStyle,
              onPressed: () {
                context.pop();
                if (widget.cancelAction != null) {
                  widget.cancelAction!();
                }
              },
            ),
          ),
        },
        Expanded(
          child: ButtonCustom(
            title: widget.acceptTitle ?? 'accept'.tr(),
            titleStyle: AppTextStyles.style.w600.s17.blackColor,
            onPressed: () {
              widget.acceptAction();
              context.pop();
            },
          ),
        ),
      ],
    );
  }
}
