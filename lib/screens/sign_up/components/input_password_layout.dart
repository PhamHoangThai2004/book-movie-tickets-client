import 'package:client/core/common/register_cubit.dart';
import 'package:client/screens/sign_up/cubit/sign_up_cubit.dart';
import 'package:client/screens/sign_up/cubit/sign_up_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/customs/text_field_custom.dart';
import '../../../generated/assets.gen.dart';

class InputPasswordLayout extends StatelessWidget {
  final TextEditingController _passwordController = TextEditingController();

  InputPasswordLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
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
          onClickSuffix: context.signUpCubit.togglePasswordVisibility,
          errorText: state.passwordError,
          onChanged: context.signUpCubit.onPasswordChanged,
        );
      },
    );
  }
}
