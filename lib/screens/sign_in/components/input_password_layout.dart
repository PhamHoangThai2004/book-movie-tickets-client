import 'package:client/core/common/register_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/customs/text_field_custom.dart';
import '../../../generated/assets.gen.dart';
import '../cubit/sign_in_cubit.dart';
import '../cubit/sign_in_state.dart';

class InputPasswordLayout extends StatelessWidget {
  final TextEditingController _passwordController = TextEditingController();

  InputPasswordLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignInCubit, SignInState>(
      buildWhen: (previous, current) =>
          previous.password != current.password ||
          previous.isPasswordVisible != current.isPasswordVisible,
      builder: (context, state) {
        return TextFieldCustom(
          controller: _passwordController,
          hintText: 'enter_your_password'.tr(),
          labelText: 'password'.tr(),
          inputType: state.isPasswordVisible ? TextInputType.text : TextInputType.visiblePassword,
          prefix: Assets.svgs.icPassword,
          suffix: state.isPasswordVisible ? Assets.svgs.icEyesOpen : Assets.svgs.icEyesClosed,
          onClickSuffix: context.signInCubit.togglePasswordVisibility,
          errorText: state.passwordError,
          onChanged: context.signInCubit.onPasswordChanged,
        );
      },
    );
  }
}
