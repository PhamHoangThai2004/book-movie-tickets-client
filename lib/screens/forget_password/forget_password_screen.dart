import 'package:client/core/themes/app_colors.dart';
import 'package:client/screens/forget_password/components/forget_password_form_layout.dart';
import 'package:client/screens/forget_password/components/forget_password_verify_layout.dart';
import 'package:client/screens/forget_password/components/reset_password_layout.dart';
import 'package:client/screens/forget_password/cubit/forget_password_cubit.dart';
import 'package:client/screens/forget_password/cubit/forget_password_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:go_router/go_router.dart';

import '../../core/customs/toasts/loading_custom.dart';
import '../../core/customs/toasts/toast_custom.dart';
import '../../core/navigation/navigation_service.dart';
import '../../core/size_config/size_config.dart';
import '../../data/enums/status_enum.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return KeyboardDismissOnTap(
      child: Scaffold(
        backgroundColor: AppColors.amberYellow.withValues(alpha: 0.1),
        resizeToAvoidBottomInset: false,
        body: BlocListener<ForgetPasswordCubit, ForgetPasswordState>(
          listenWhen: (previous, current) => previous.status != current.status,
          listener: (context, state) {
            if (state.status.isProcessing) {
              LoadingCustom.show();
            } else if (state.status.isFailure) {
              LoadingCustom.hideLoading();
              ToastCustom.show(message: state.errorMessage);
            } else if (state.status.isSuccess) {
              LoadingCustom.hideLoading();
              ToastCustom.show(
                message: 'password_reset_success'.tr(),
                type: ToastType.success,
              );
              context.pushReplacement(NavigationService.signIn);
            } else {
              LoadingCustom.hideLoading();
            }
          },
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: SizeConfig.appDefaultPadding),
              child: BlocBuilder<ForgetPasswordCubit, ForgetPasswordState>(
                buildWhen: (previous, current) => previous.step != current.step,
                builder: (context, state) {
                  if (state.step == ForgetPasswordStep.inputForm) {
                    return ForgetPasswordFormLayout();
                  } else if (state.step == ForgetPasswordStep.otpVerify) {
                    return const ForgetPasswordVerifyLayout();
                  }
                  return ResetPasswordLayout();
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

