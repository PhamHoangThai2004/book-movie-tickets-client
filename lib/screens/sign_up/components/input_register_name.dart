import 'package:client/screens/sign_up/cubit/sign_up_cubit.dart';
import 'package:client/screens/sign_up/cubit/sign_up_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/common/register_cubit.dart';
import '../../../core/customs/inputs/text_field_custom.dart';
import '../../../generated/assets.gen.dart';

class InputRegisterName extends StatelessWidget {
  final TextEditingController _nameController = TextEditingController();

  InputRegisterName({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) => previous.fullName != current.fullName,
      builder: (context, state) {
        return TextFieldCustom(
          controller: _nameController,
          hintText: 'enter_your_name'.tr(),
          errorText: state.fullNameError,
          prefix: Assets.svgs.icEdit,
          labelText: 'full_name'.tr(),
          inputType: TextInputType.name,
          onChanged: context.signUpCubit.onFullNameChanged,
        );
      },
    );
  }
}
