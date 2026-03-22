import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../size_config/app_dimen.dart';
import '../../size_config/dimens.dart';
import '../../styles/app_text_styles.dart';
import '../../themes/app_colors.dart';

class OtpFieldCustom extends StatelessWidget {
  final Function(String) onOtpChanged;

  const OtpFieldCustom({super.key, required this.onOtpChanged});

  @override
  Widget build(BuildContext context) => LayoutBuilder(
    builder: (context, constraints) {
      const otpLength = 6;
      final spacing = Dimens.d8.responsive();
      final cellWidth = ((constraints.maxWidth - (otpLength - 1) * spacing) / otpLength).clamp(
        40.0,
        64.0,
      );

      return MaterialPinField(
        length: otpLength,
        onChanged: onOtpChanged,
        keyboardType: TextInputType.number,
        theme: MaterialPinTheme(
          shape: MaterialPinShape.outlined,
          cellSize: Size(cellWidth, Dimens.d70.responsive()),
          spacing: spacing,
          animationDuration: Duration(milliseconds: 300),
          textStyle: AppTextStyles.style.s32.w700.whiteSmokeColor,
          filledBorderColor: AppColors.amberYellow,
          focusedBorderColor: AppColors.amberYellow,
          errorBorderColor: AppColors.red,
          cursorColor: AppColors.amberYellow,
          borderColor: AppColors.whiteSmoke,
          filledFillColor: AppColors.amberYellow.withValues(alpha: 0.2),
          followingFillColor: AppColors.transparent,
          focusedFillColor: AppColors.amberYellow.withValues(alpha: 0.2),
        ),
      );
    },
  );
}
