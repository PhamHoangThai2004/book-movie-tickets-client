import 'package:client/core/common/register_cubit.dart';
import 'package:client/core/customs/buttons/cupertino_button_custom.dart';
import 'package:client/screens/sign_up/cubit/sign_up_cubit.dart';
import 'package:client/screens/sign_up/cubit/sign_up_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../core/customs/app_bars/header_custom.dart';
import '../../../core/customs/buttons/button_custom.dart';
import '../../../core/size_config/app_dimen.dart';
import '../../../core/size_config/dimens.dart';
import '../../../core/size_config/size_config.dart';
import '../../../core/styles/app_text_styles.dart';
import '../../../core/themes/app_colors.dart';

class RegisterOtpVerifyLayout extends StatelessWidget {
  const RegisterOtpVerifyLayout({super.key});

  @override
  Widget build(BuildContext context) {
    final keyboardInset = MediaQuery.of(context).viewInsets.bottom;

    return SizedBox.expand(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  VerticalSpacing(of: SizeConfig.getSpaceWithAppBarHeight()),
                  HeaderCustom(
                    title: 'otp_code_verification'.tr(),
                    backAction: context.signUpCubit.backToInputForm,
                  ),
                  VerticalSpacing(of: Dimens.d40.responsive()),
                  Text(
                    'confirm_otp_message'.tr(namedArgs: {'email': context.signUpCubit.state.email}),
                    style: AppTextStyles.style.s16.w400.whiteSmokeColor,
                  ),
                  VerticalSpacing(of: Dimens.d30.responsive()),
                  LayoutBuilder(
                    builder: (context, constraints) {
                      const otpLength = 6;
                      final spacing = Dimens.d8.responsive();
                      final cellWidth =
                          ((constraints.maxWidth - (otpLength - 1) * spacing) / otpLength).clamp(
                            40.0,
                            64.0,
                          );

                      return MaterialPinField(
                        length: otpLength,
                        onChanged: context.signUpCubit.onOtpChanged,
                        keyboardType: TextInputType.number,
                        enabled: true,
                        theme: MaterialPinTheme(
                          shape: MaterialPinShape.outlined,
                          cellSize: Size(cellWidth, Dimens.d70.responsive()),
                          spacing: spacing,
                          animationDuration: Duration(milliseconds: 300),
                          textStyle: AppTextStyles.style.s32.w700.whiteSmokeColor,
                          disabledBorderColor: AppColors.white,
                          filledBorderColor: AppColors.amberYellow,
                          focusedBorderColor: AppColors.amberYellow,
                          errorBorderColor: AppColors.red,
                          cursorColor: AppColors.amberYellow,
                          fillColor: AppColors.amberYellow.withValues(alpha: 0.2),
                          filledFillColor: AppColors.amberYellow.withValues(alpha: 0.2),
                          followingFillColor: AppColors.amberYellow.withValues(alpha: 0.2),
                          focusedFillColor: AppColors.amberYellow.withValues(alpha: 0.2),
                        ),
                      );
                    },
                  ),
                  VerticalSpacing(of: Dimens.d20.responsive()),
                  Align(alignment: Alignment.topRight, child: _countdownOrResendText()),
                ],
              ),
            ),
          ),
          AnimatedPadding(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeOut,
            padding: EdgeInsets.only(bottom: keyboardInset + Dimens.d20.responsive()),
            child: _confirmButton(),
          ),
        ],
      ),
    );
  }

  Widget _countdownOrResendText() {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) => previous.otpCountdownSeconds != current.otpCountdownSeconds,
      builder: (context, state) {
        if (state.isOtpExpired) {
          return CupertinoButtonCustom(
            onPressed: () => context.signUpCubit.resendOtp(),
            child: Text('resend_code'.tr(), style: AppTextStyles.style.w700.s20.amberYellowColor),
          );
        }

        final duration = Duration(seconds: state.otpCountdownSeconds);
        final minutes = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
        final seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');

        return Text('$minutes:$seconds', style: AppTextStyles.style.w700.s20.whiteSmokeColor);
      },
    );
  }

  Widget _confirmButton() {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) => previous.canVerifyOtp != current.canVerifyOtp,
      builder: (context, state) {
        return ButtonCustom(
          title: 'confirm'.tr(),
          onPressed: state.canVerifyOtp ? () => context.signUpCubit.verifyOtp() : null,
        );
      },
    );
  }
}
