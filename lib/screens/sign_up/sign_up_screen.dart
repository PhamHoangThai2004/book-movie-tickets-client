import 'package:client/core/themes/app_colors.dart';
import 'package:client/screens/sign_up/components/register_form_layout.dart';
import 'package:client/screens/sign_up/components/register_otp_verify_layout.dart';
import 'package:client/screens/sign_up/cubit/sign_up_cubit.dart';
import 'package:client/screens/sign_up/cubit/sign_up_state.dart';
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

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return KeyboardDismissOnTap(
      child: Scaffold(
        backgroundColor: AppColors.amberYellow.withValues(alpha: 0.1),
        resizeToAvoidBottomInset: false,
        body: BlocListener<SignUpCubit, SignUpState>(
          listenWhen: (previous, current) => previous.status != current.status,
          listener: (context, state) {
            if (state.status.isProcessing) {
              LoadingCustom.show();
            } else if (state.status.isFailure) {
              LoadingCustom.hideLoading();
              ToastCustom.show(message: state.errorMessage);
            } else if (state.status.isSuccess) {
              LoadingCustom.hideLoading();
              ToastCustom.show(message: 'register_success'.tr(), type: ToastType.success);
              context.pushReplacement(NavigationService.signIn);
            } else {
              LoadingCustom.hideLoading();
            }
          },
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: SizeConfig.appDefaultPadding),
              child: BlocBuilder<SignUpCubit, SignUpState>(
                buildWhen: (previous, current) => previous.signInStep != current.signInStep,
                builder: (context, state) {
                  if (state.signInStep == SignInStep.inputForm) {
                    return const RegisterFormLayout();
                  } else {
                    return const RegisterOtpVerifyLayout();
                  }
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
