import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

import '../../../generated/assets.gen.dart';
import '../../size_config/app_dimen.dart';
import '../../size_config/dimens.dart';
import '../../size_config/size_config.dart';
import '../../styles/app_text_styles.dart';
import '../../themes/app_colors.dart';
import '../buttons/cupertino_button_custom.dart';

class HeaderCustom extends StatelessWidget {
  final String title;
  final SvgGenImage? backIcon;
  final Function()? backAction;
  final SvgGenImage? extraIcon;
  final Function()? extraAction;

  const HeaderCustom({
    super.key,
    required this.title,
    this.backIcon,
    this.backAction,
    this.extraIcon,
    this.extraAction,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CupertinoButtonCustom(
          onPressed: backAction ?? context.pop,
          child: backIcon != null
              ? backIcon!.svg(
                  width: Dimens.d40.responsive(),
                  height: Dimens.d40.responsive(),
                  colorFilter: const ColorFilter.mode(AppColors.white, BlendMode.srcIn),
                )
              : Assets.svgs.icArrowLeft.svg(
                  width: Dimens.d40.responsive(),
                  height: Dimens.d40.responsive(),
                  colorFilter: const ColorFilter.mode(AppColors.white, BlendMode.srcIn),
                ),
        ),
        Expanded(
          child: Text(
            title,
            style: AppTextStyles.style.w700.s28.whiteSmokeColor,
            textAlign: TextAlign.center,
          ),
        ),
        if (extraIcon != null)
          CupertinoButtonCustom(
            onPressed: extraAction,
            child: extraIcon!.svg(
              width: Dimens.d25.responsive(),
              height: Dimens.d25.responsive(),
              colorFilter: const ColorFilter.mode(AppColors.white, BlendMode.srcIn),
            ),
          )
        else
          HorizontalSpacing(of: Dimens.d34.responsive()),
      ],
    );
  }
}
