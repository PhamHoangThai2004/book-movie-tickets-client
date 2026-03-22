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

import '../../../core/customs/app_bars/header_custom.dart';

class ForgetPasswordFormLayout extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();

  ForgetPasswordFormLayout({super.key});

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
                  HeaderCustom(title: 'forgot_password'.tr()),
                  VerticalSpacing(of: Dimens.d40.responsive()),
                  BlocBuilder<ForgetPasswordCubit, ForgetPasswordState>(
                    buildWhen: (previous, current) => previous.email != current.email,
                    builder: (context, state) {
                      return TextFieldCustom(
                        controller: _emailController,
                        hintText: 'enter_your_email'.tr(),
                        prefix: Assets.svgs.icEmail,
                        labelText: 'email'.tr(),
                        inputType: TextInputType.emailAddress,
                        onChanged: context.read<ForgetPasswordCubit>().onEmailChanged,
                        errorText: state.emailError,
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
            child: _buildConfirmButton(),
          ),
        ],
      ),
    );
  }

  Widget _buildConfirmButton() {
    return BlocBuilder<ForgetPasswordCubit, ForgetPasswordState>(
      buildWhen: (previous, current) => previous.isFormValid != current.isFormValid,
      builder: (context, state) {
        return ButtonCustom(
          title: 'continue'.tr(),
          onPressed: state.isFormValid
              ? context.read<ForgetPasswordCubit>().requestResetPassword
              : null,
          titleStyle: state.isFormValid ? null : AppTextStyles.style.w700.s20.whiteColor,
          buttonStyle: state.isFormValid
              ? AppThemes.yellowButtonStyle
              : AppThemes.disabledButtonStyle,
        );
      },
    );
  }
}
