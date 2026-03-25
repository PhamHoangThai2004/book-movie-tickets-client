import 'package:client/core/customs/app_bars/header_custom.dart';
import 'package:client/core/customs/buttons/button_custom.dart';
import 'package:client/core/customs/toasts/toast_custom.dart';
import 'package:client/core/size_config/app_dimen.dart';
import 'package:client/core/size_config/dimens.dart';
import 'package:client/core/size_config/size_config.dart';
import 'package:client/core/styles/app_text_styles.dart';
import 'package:client/core/themes/app_colors.dart';
import 'package:client/core/themes/app_themes.dart';
import 'package:client/data/remote/requests/update_profile_request.dart';
import 'package:client/screens/update_profile/components/input_profile_name.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:go_router/go_router.dart';

import '../../core/common/register_cubit.dart';
import '../../core/customs/toasts/loading_custom.dart';
import '../../core/utils/datetime_utils.dart';
import '../../data/enums/status_enum.dart';
import 'components/input_profile_phone.dart';
import 'cubit/update_profile_cubit.dart';
import 'cubit/update_profile_state.dart';

class UpdateProfileScreen extends StatefulWidget {
  final UpdateProfileRequest? initialValue;
  final ValueChanged<UpdateProfileRequest>? onSubmit;

  const UpdateProfileScreen({super.key, this.initialValue, this.onSubmit});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  static const List<String> _genderOptions = ['male', 'female', 'other'];

  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _dateOfBirthController = TextEditingController();
  final DateFormat _requestDateFormat = DateFormat('yyyy-MM-dd');

  String _gender = _genderOptions.first;

  @override
  void initState() {
    super.initState();
    context.updateProfileCubit.initialize();
  }

  @override
  void dispose() {
    _dateOfBirthController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardDismissOnTap(
      child: Scaffold(
        backgroundColor: AppColors.warmBlack,
        resizeToAvoidBottomInset: false,
        body: Container(
          decoration: AppThemes.mainBackground,
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: SizeConfig.appDefaultPadding),
              child: MultiBlocListener(
                listeners: [
                  BlocListener<UpdateProfileCubit, UpdateProfileState>(
                    listenWhen: (p, c) => p.status != c.status,
                    listener: (context, state) {
                      if (state.status == StatusEnum.success) {
                        LoadingCustom.hideLoading();
                        ToastCustom.show(
                          message: 'update_profile_success'.tr(),
                          type: ToastType.success,
                        );
                        context.pop();
                      } else if (state.status == StatusEnum.failure) {
                        LoadingCustom.hideLoading();
                        ToastCustom.show(message: state.errorMessage);
                      } else if (state.status == StatusEnum.processing) {
                        LoadingCustom.show();
                      } else {
                        LoadingCustom.hideLoading();
                      }
                    },
                  ),

                  BlocListener<UpdateProfileCubit, UpdateProfileState>(
                    listenWhen: (p, c) => p.initUser != c.initUser,
                    listener: (context, state) {
                      if (state.initUser != null) {
                        if (!mounted) {
                          return;
                        }
                        setState(() {
                          _phoneController.text = state.initUser?.phoneNumber ?? '';
                          _nameController.text = state.initUser?.name ?? '';
                          _dateOfBirthController.text = DatetimeUtils.fromIso8601(
                            state.initUser?.dateOfBirth,
                          );
                          _gender = _normalizeGender(state.initUser?.gender);
                        });
                      }
                    },
                  ),
                ],
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    VerticalSpacing(of: SizeConfig.getSpaceWithAppBarHeight()),
                    HeaderCustom(title: 'update_profile'.tr()),
                    VerticalSpacing(of: Dimens.d32.responsive()),
                    InputProfileName(nameController: _nameController),
                    VerticalSpacing(of: Dimens.d16.responsive()),
                    InputProfilePhone(phoneController: _phoneController),
                    VerticalSpacing(of: Dimens.d16.responsive()),
                    _buildTextField(
                      label: 'date_of_birth'.tr(),
                      hintText: 'yyyy-MM-dd',
                      controller: _dateOfBirthController,
                      readOnly: true,
                      onTap: _pickDateOfBirth,
                    ),
                    VerticalSpacing(of: Dimens.d16.responsive()),
                    _buildGenderDropdown(),
                    VerticalSpacing(of: Dimens.d32.responsive()),
                    _buildButtonSave(),
                    VerticalSpacing(of: Dimens.d20.responsive()),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required String hintText,
    required TextEditingController controller,
    TextInputType keyboardType = TextInputType.text,
    bool readOnly = false,
    VoidCallback? onTap,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTextStyles.style.s16.w600.whiteColor),
        VerticalSpacing(of: Dimens.d8.responsive()),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          readOnly: readOnly,
          onTap: onTap,
          style: AppTextStyles.style.s16.w500.whiteColor,
          cursorColor: AppColors.white,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: AppTextStyles.style.s14.w400.coolGrayColor,
            border: AppThemes.inputDefaultBorder,
            enabledBorder: AppThemes.inputDefaultBorder,
            focusedBorder: AppThemes.inputFocusedBorder,
            errorBorder: AppThemes.inputErrorBorder,
            focusedErrorBorder: AppThemes.inputErrorBorder,
            errorStyle: AppTextStyles.style.s14.w400.redColor,
            filled: true,
            fillColor: AppColors.white.withValues(alpha: 0.1),
          ),
        ),
      ],
    );
  }

  Widget _buildGenderDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('gender'.tr(), style: AppTextStyles.style.s16.w600.whiteColor),
        VerticalSpacing(of: Dimens.d8.responsive()),
        DropdownButtonFormField<String>(
          initialValue: _genderOptions.contains(_gender) ? _gender : _genderOptions.first,
          dropdownColor: AppColors.darkCharcoal,
          iconEnabledColor: AppColors.whiteSmoke,
          style: AppTextStyles.style.s16.w500.whiteColor,
          decoration: InputDecoration(
            border: AppThemes.inputDefaultBorder,
            enabledBorder: AppThemes.inputDefaultBorder,
            focusedBorder: AppThemes.inputFocusedBorder,
            errorBorder: AppThemes.inputErrorBorder,
            focusedErrorBorder: AppThemes.inputErrorBorder,
            errorStyle: AppTextStyles.style.s14.w400.redColor,
            filled: true,
            fillColor: AppColors.white.withValues(alpha: 0.1),
          ),
          items: [
            DropdownMenuItem(value: 'male', child: Text('male'.tr())),
            DropdownMenuItem(value: 'female', child: Text('female'.tr())),
            DropdownMenuItem(value: 'other', child: Text('other'.tr())),
          ],
          onChanged: (value) {
            if (value == null) return;

            setState(() {
              _gender = value;
            });

            context.updateProfileCubit.onGenderChanged(value);
          },
          validator: (value) =>
              (value == null || value.trim().isEmpty) ? 'Vui lòng chọn giới tính' : null,
        ),
      ],
    );
  }

  Widget _buildButtonSave() {
    return BlocBuilder<UpdateProfileCubit, UpdateProfileState>(
      buildWhen: (previous, current) =>
          previous.status != current.status ||
          previous.initUser != current.initUser ||
          previous.name != current.name ||
          previous.phoneNumber != current.phoneNumber ||
          previous.dateOfBirth != current.dateOfBirth ||
          previous.gender != current.gender ||
          previous.nameError != current.nameError ||
          previous.phoneNumberError != current.phoneNumberError ||
          previous.dateOfBirthError != current.dateOfBirthError ||
          previous.genderError != current.genderError,
      builder: (context, state) {
        final initialName = state.initUser?.name.trim() ?? '';
        final initialPhoneNumber = state.initUser?.phoneNumber?.trim() ?? '';
        final initialDateOfBirth = state.initUser?.dateOfBirth?.trim() ?? '';
        final initialGender = _normalizeGender(state.initUser?.gender);

        final currentName = state.name.trim();
        final currentPhoneNumber = state.phoneNumber.trim();
        final currentDateOfBirth = state.dateOfBirth.trim();
        final currentGender = _normalizeGender(state.gender);

        final isEdit =
            currentName != initialName ||
            currentPhoneNumber != initialPhoneNumber ||
            currentDateOfBirth != initialDateOfBirth ||
            currentGender != initialGender;
        return ButtonCustom(
          title: 'save_change'.tr(),
          buttonStyle: (state.isValid && isEdit)
              ? AppThemes.yellowButtonStyle
              : AppThemes.disabledButtonStyle,
          titleStyle: (state.isValid && isEdit)
              ? AppTextStyles.style.s16.w600.whiteColor
              : AppTextStyles.style.s16.w600.coolGrayColor,
          onPressed: (state.isValid && isEdit)
              ? () => context.updateProfileCubit.submitUpdateProfile()
              : null,
        );
      },
    );
  }

  Future<void> _pickDateOfBirth() async {
    final initialDate = _tryParseDate(_dateOfBirthController.text) ?? DateTime(2000, 1, 1);

    final pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (pickedDate == null || !mounted) {
      return;
    }

    setState(() {
      _dateOfBirthController.text = _requestDateFormat.format(pickedDate);
    });
    context.updateProfileCubit.onDateOfBirthChanged(_dateOfBirthController.text);
  }

  DateTime? _tryParseDate(String value) {
    try {
      return _requestDateFormat.parseStrict(value);
    } catch (_) {
      return null;
    }
  }

  String _normalizeGender(String? value) {
    final gender = (value ?? '').trim().toLowerCase();

    switch (gender) {
      case 'nam':
      case 'male':
        return 'male';

      case 'nữ':
      case 'nu':
      case 'female':
        return 'female';

      case 'khác':
      case 'khac':
      case 'other':
        return 'other';

      default:
        return _genderOptions.contains(gender) ? gender : _genderOptions.first;
    }
  }
}
