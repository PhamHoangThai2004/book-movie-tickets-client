import 'package:client/core/themes/app_colors.dart';
import 'package:flutter/material.dart';

import '../../../generated/assets.gen.dart';
import '../../size_config/app_dimen.dart';
import '../../size_config/dimens.dart';
import '../../size_config/size_config.dart';
import '../../styles/app_text_styles.dart';
import '../../themes/app_themes.dart';
import '../buttons/cupertino_button_custom.dart';

class TextFieldCustom extends StatefulWidget {
  final TextEditingController? controller;
  final TextStyle? textStyle;
  final TextInputType? inputType;
  final String hintText;
  final TextStyle? hintStyle;
  final String? labelText;
  final TextStyle? labelStyle;
  final String errorText;
  final TextStyle? errorStyle;
  final SvgGenImage? suffix;
  final SvgGenImage? prefix;
  final FocusNode? focusNode;
  final Function(String) onChanged;
  final Function()? onClickSuffix;

  const TextFieldCustom({
    super.key,
    this.controller,
    this.textStyle,
    required this.hintText,
    this.hintStyle,
    this.labelText,
    this.labelStyle,
    required this.errorText,
    this.errorStyle,
    this.suffix,
    this.prefix,
    this.focusNode,
    required this.onChanged,
    this.onClickSuffix,
    this.inputType,
  });

  @override
  State<StatefulWidget> createState() => _TextFieldCustomState();
}

class _TextFieldCustomState extends State<TextFieldCustom> {
  late TextEditingController _textEditingController;
  late final FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _textEditingController = widget.controller ?? TextEditingController();
    _focusNode = widget.focusNode ?? FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    _textEditingController.dispose();
    _focusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textStyleBuild = widget.textStyle ?? AppTextStyles.style.s16.w500.whiteColor;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.labelText != null) ...[
          Text(
            widget.labelText!,
            style: widget.labelStyle ?? AppTextStyles.style.s16.w600.whiteColor,
          ),
        ],
        VerticalSpacing(of: Dimens.d8.responsive()),
        TextField(
          controller: _textEditingController,
          focusNode: _focusNode,
          keyboardType: widget.inputType ?? TextInputType.text,
          onChanged: widget.onChanged,
          style: textStyleBuild,
          obscureText: widget.inputType == TextInputType.visiblePassword ? true : false,
          obscuringCharacter: '✶',
          cursorColor: AppColors.white,
          cursorErrorColor: AppColors.red,
          decoration: InputDecoration(
            hintText: widget.hintText,
            hintStyle: widget.hintStyle ?? AppTextStyles.style.s14.w400.coolGrayColor,
            border: AppThemes.inputDefaultBorder,
            enabledBorder: AppThemes.inputDefaultBorder,
            errorBorder: AppThemes.inputErrorBorder,
            focusedErrorBorder: AppThemes.inputErrorBorder,
            focusedBorder: AppThemes.inputFocusedBorder,
            errorText: widget.errorText.isEmpty ? null : widget.errorText,
            prefixIcon: widget.prefix != null
                ? Container(
                    padding: EdgeInsets.only(
                      left: Dimens.d15.responsive(),
                      right: Dimens.d12.responsive(),
                    ),
                    child: ValueListenableBuilder<TextEditingValue>(
                      valueListenable: _textEditingController,
                      builder: (context, value, child) {
                        return widget.prefix!.svg(
                          width: Dimens.d20.responsive(),
                          colorFilter: value.text.isNotEmpty
                              ? ColorFilter.mode(AppColors.white, BlendMode.srcIn)
                              : null,
                        );
                      },
                    ),
                  )
                : null,
            suffixIcon: widget.suffix != null
                ? CupertinoButtonCustom(
                    onPressed: widget.onClickSuffix,
                    child: ValueListenableBuilder<TextEditingValue>(
                      valueListenable: _textEditingController,
                      builder: (context, value, child) {
                        return widget.suffix!.svg(
                          width: Dimens.d20.responsive(),
                          colorFilter: value.text.isNotEmpty
                              ? ColorFilter.mode(AppColors.white, BlendMode.srcIn)
                              : null,
                        );
                      },
                    ),
                  )
                : null,
            errorMaxLines: 2,
            errorStyle: widget.errorStyle ?? AppTextStyles.style.s14.w400.redColor,
            fillColor: AppColors.white.withValues(alpha: 0.1),
            filled: true,
          ),
        ),
      ],
    );
  }
}
