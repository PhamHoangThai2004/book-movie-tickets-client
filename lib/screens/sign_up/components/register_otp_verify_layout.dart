import 'package:client/core/common/register_cubit.dart';
import 'package:client/core/customs/buttons/cupertino_button_custom.dart';
import 'package:client/screens/sign_up/cubit/sign_up_cubit.dart';
import 'package:client/screens/sign_up/cubit/sign_up_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/customs/app_bars/header_custom.dart';
import '../../../core/customs/buttons/button_custom.dart';
import '../../../core/customs/inputs/pin_code_otp_field.dart';
import '../../../core/size_config/app_dimen.dart';
import '../../../core/size_config/dimens.dart';
import '../../../core/size_config/size_config.dart';
import '../../../core/styles/app_text_styles.dart';
import '../../../core/themes/app_themes.dart';

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
                  OtpFieldCustom(onOtpChanged: context.signUpCubit.onOtpChanged),
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
          titleStyle: state.canVerifyOtp ? null : AppTextStyles.style.w700.s20.whiteColor,
          buttonStyle: state.canVerifyOtp
              ? AppThemes.yellowButtonStyle
              : AppThemes.disabledButtonStyle,
        );
      },
    );
  }
}
