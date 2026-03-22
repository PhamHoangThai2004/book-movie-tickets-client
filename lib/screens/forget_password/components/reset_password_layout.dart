import 'package:client/core/customs/app_bars/header_custom.dart';
import 'package:client/core/customs/buttons/button_custom.dart';
import 'package:client/core/customs/inputs/text_field_custom.dart';
import 'package:client/core/size_config/app_dimen.dart';
import 'package:client/core/size_config/dimens.dart';
import 'package:client/core/size_config/size_config.dart';
import 'package:client/core/styles/app_text_styles.dart';
import 'package:client/core/themes/app_themes.dart';
import 'package:client/generated/assets.gen.dart';
import 'package:client/screens/forget_password/cubit/forget_password_cubit.dart';
import 'package:client/screens/forget_password/cubit/forget_password_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResetPasswordLayout extends StatelessWidget {
  final TextEditingController _passwordController = TextEditingController();

  ResetPasswordLayout({super.key});

  @override
  Widget build(BuildContext context) {
    final keyboardInset = MediaQuery.of(context).viewInsets.bottom;

    return SizedBox.expand(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  VerticalSpacing(of: SizeConfig.getSpaceWithAppBarHeight()),
                  HeaderCustom(
                    title: 'reset_password'.tr(),
                    backAction: context.read<ForgetPasswordCubit>().backToOtpVerify,
                  ),
                  VerticalSpacing(of: Dimens.d40.responsive()),
                  BlocBuilder<ForgetPasswordCubit, ForgetPasswordState>(
                    buildWhen: (previous, current) =>
                        previous.passwordError != current.passwordError ||
                        previous.password != current.password,
                    builder: (context, state) {
                      return TextFieldCustom(
                        controller: _passwordController,
                        hintText: 'enter_new_password'.tr(),
                        labelText: 'new_password'.tr(),
                        inputType: TextInputType.visiblePassword,
                        prefix: Assets.svgs.icPassword,
                        errorText: state.passwordError,
                        onChanged: context.read<ForgetPasswordCubit>().onPasswordChanged,
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          AnimatedPadding(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeOut,
            padding: EdgeInsets.only(bottom: keyboardInset + Dimens.d20.responsive()),
            child: BlocBuilder<ForgetPasswordCubit, ForgetPasswordState>(
              buildWhen: (previous, current) =>
                  previous.isResetPasswordValid != current.isResetPasswordValid,
              builder: (context, state) {
                return ButtonCustom(
                  title: 'confirm'.tr(),
                  onPressed: state.isResetPasswordValid
                      ? context.read<ForgetPasswordCubit>().submitResetPassword
                      : null,
                  titleStyle: state.isResetPasswordValid
                      ? null
                      : AppTextStyles.style.w700.s20.whiteColor,
                  buttonStyle: state.isResetPasswordValid
                      ? AppThemes.yellowButtonStyle
                      : AppThemes.disabledButtonStyle,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
