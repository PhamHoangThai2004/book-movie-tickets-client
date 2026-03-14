import 'package:client/core/customs/cupertino_button_custom.dart';
import 'package:flutter/cupertino.dart';

import '../size_config/app_dimen.dart';
import '../size_config/dimens.dart';
import '../size_config/size_config.dart';
import '../styles/app_text_styles.dart';
import '../themes/app_colors.dart';
import '../themes/app_themes.dart';

class ButtonCustom extends StatelessWidget {
  final String title;
  final TextStyle? titleStyle;
  final double? width;
  final Widget? startIcon;
  final Widget? endIcon;
  final Function()? onPressed;
  final BoxDecoration? buttonStyle;

  const ButtonCustom({
    super.key,
    required this.title,
    this.titleStyle,
    this.width,
    this.startIcon,
    this.endIcon,
    this.onPressed,
    this.buttonStyle,
  });

  @override
  Widget build(BuildContext context) {
    final titleStyleBuild = titleStyle ?? AppTextStyles.style.s20.w700.blackColor;

    var buttonStyleBuild = buttonStyle ?? AppThemes.yellowButtonStyle;

    final isDisable = onPressed == null;

    return CupertinoButtonCustom(
      onPressed: onPressed,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        decoration: buttonStyleBuild.copyWith(color: isDisable ? AppColors.grey : null),
        width: width ?? SizeConfig.screenWidth,
        padding: EdgeInsets.symmetric(vertical: Dimens.d14.responsive()),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (startIcon != null) ...[startIcon!, HorizontalSpacing(of: Dimens.d10.responsive())],
            Text(title, style: titleStyleBuild),
            if (endIcon != null) ...[HorizontalSpacing(of: Dimens.d10.responsive()), endIcon!],
          ],
        ),
      ),
    );
  }
}
