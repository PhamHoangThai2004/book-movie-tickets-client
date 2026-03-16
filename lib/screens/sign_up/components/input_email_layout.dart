import 'package:client/screens/sign_up/cubit/sign_up_cubit.dart';
import 'package:client/screens/sign_up/cubit/sign_up_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/common/register_cubit.dart';
import '../../../core/customs/text_field_custom.dart';
import '../../../generated/assets.gen.dart';

class InputEmailLayout extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();

  InputEmailLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return TextFieldCustom(
          controller: _emailController,
          hintText: 'enter_your_email'.tr(),
          prefix: Assets.svgs.icEmail,
          errorText: state.emailError,
          labelText: 'email'.tr(),
          inputType: TextInputType.emailAddress,
          onChanged: context.signUpCubit.onEmailChanged,
        );
      },
    );
  }
}
