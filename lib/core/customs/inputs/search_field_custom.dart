import 'package:client/core/themes/app_colors.dart';
import 'package:flutter/material.dart';

import '../../../generated/assets.gen.dart';
import '../../size_config/app_dimen.dart';
import '../../size_config/dimens.dart';
import '../../styles/app_text_styles.dart';
import '../../themes/app_themes.dart';
import '../buttons/cupertino_button_custom.dart';

class SearchFieldCustom extends StatefulWidget {
  final TextEditingController? controller;
  final TextStyle? textStyle;
  final String hintText;
  final TextStyle? hintStyle;
  final SvgGenImage? prefix;
  final Function(String) onChanged;
  final Function()? onClickSuffix;

  const SearchFieldCustom({
    super.key,
    this.controller,
    this.textStyle,
    required this.hintText,
    this.hintStyle,
    this.prefix,
    required this.onChanged,
    this.onClickSuffix,
  });

  @override
  State<SearchFieldCustom> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchFieldCustom> {
  late TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = widget.controller ?? TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _searchController,
      keyboardType: TextInputType.text,
      onChanged: widget.onChanged,
      style: widget.textStyle ?? AppTextStyles.style.s16.w500.whiteColor,
      cursorColor: AppColors.amberYellow,
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: widget.hintStyle ?? AppTextStyles.style.s14.w400.coolGrayColor,
        border: AppThemes.inputDefaultBorder,
        enabledBorder: AppThemes.inputDefaultBorder,
        focusedBorder: AppThemes.inputDefaultBorder,
        prefixIcon: widget.prefix != null
            ? Container(
                padding: EdgeInsets.only(
                  left: Dimens.d15.responsive(),
                  right: Dimens.d12.responsive(),
                ),
                child: ValueListenableBuilder<TextEditingValue>(
                  valueListenable: _searchController,
                  builder: (context, value, child) {
                    return widget.prefix!.svg(
                      width: Dimens.d20.responsive(),
                      colorFilter: value.text.isNotEmpty ? const ColorFilter.mode(AppColors.white, BlendMode.srcIn) : null,
                    );
                  },
                ),
              )
            : null,
        suffixIcon: ValueListenableBuilder<TextEditingValue>(
          valueListenable: _searchController,
          builder: (context, value, child) {
            if (value.text.isEmpty) return const SizedBox.shrink();
            return CupertinoButtonCustom(
              onPressed: () {
                _searchController.clear();
                widget.onChanged('');
                widget.onClickSuffix?.call();
              },
              child: Container(
                padding: EdgeInsets.all(Dimens.d10.responsive()),
                width: Dimens.d28.responsive(),
                height: Dimens.d28.responsive(),
                decoration: BoxDecoration(
                  color: AppColors.white.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Assets.svgs.icClose.svg(
                  width: Dimens.d5.responsive(),
                  height: Dimens.d5.responsive(),
                  colorFilter: const ColorFilter.mode(AppColors.white, BlendMode.srcIn),
                ),
              ),
            );
          },
        ),
        fillColor: AppColors.white.withValues(alpha: 0.1),
        filled: true,
      ),
    );
  }
}
