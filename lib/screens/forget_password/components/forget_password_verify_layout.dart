import 'package:client/core/customs/app_bars/header_custom.dart';
import 'package:client/core/customs/buttons/button_custom.dart';
import 'package:client/core/customs/buttons/cupertino_button_custom.dart';
import 'package:client/core/size_config/app_dimen.dart';
import 'package:client/core/size_config/dimens.dart';
import 'package:client/core/size_config/size_config.dart';
import 'package:client/core/styles/app_text_styles.dart';
import 'package:client/screens/forget_password/cubit/forget_password_cubit.dart';
import 'package:client/screens/forget_password/cubit/forget_password_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/customs/inputs/pin_code_otp_field.dart';
import '../../../core/themes/app_themes.dart';

class ForgetPasswordVerifyLayout extends StatelessWidget {
  const ForgetPasswordVerifyLayout({super.key});

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
                    backAction: context.read<ForgetPasswordCubit>().backToInputForm,
                  ),
                  VerticalSpacing(of: Dimens.d40.responsive()),
                  Text(
                    'confirm_otp_message'.tr(namedArgs: {'email': context.read<ForgetPasswordCubit>().state.email}),
                    style: AppTextStyles.style.s16.w400.whiteSmokeColor,
                  ),
                  VerticalSpacing(of: Dimens.d30.responsive()),
                  OtpFieldCustom(onOtpChanged: context.read<ForgetPasswordCubit>().onOtpChanged),
                  VerticalSpacing(of: Dimens.d20.responsive()),
                  Align(alignment: Alignment.topRight, child: _buildCountdownOrResendText()),
                ],
              ),
            ),
          ),
          AnimatedPadding(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeOut,
            padding: EdgeInsets.only(bottom: keyboardInset + Dimens.d20.responsive()),
            child: _buildConfirmButton(),
          ),
        ],
      ),
    );
  }

  Widget _buildCountdownOrResendText() {
    return BlocBuilder<ForgetPasswordCubit, ForgetPasswordState>(
      buildWhen: (previous, current) => previous.otpCountdownSeconds != current.otpCountdownSeconds,
      builder: (context, state) {
        if (state.isOtpExpired) {
          return CupertinoButtonCustom(
            onPressed: context.read<ForgetPasswordCubit>().resendOtp,
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

  Widget _buildConfirmButton() {
    return BlocBuilder<ForgetPasswordCubit, ForgetPasswordState>(
      buildWhen: (previous, current) => previous.canVerifyOtp != current.canVerifyOtp,
      builder: (context, state) {
        return ButtonCustom(
          title: 'continue'.tr(),
          onPressed: state.canVerifyOtp ? context.read<ForgetPasswordCubit>().verifyOtp : null,
          titleStyle: state.canVerifyOtp ? null : AppTextStyles.style.w700.s20.whiteColor,
          buttonStyle: state.canVerifyOtp ? AppThemes.yellowButtonStyle : AppThemes.disabledButtonStyle,
        );
      },
    );
  }
}


