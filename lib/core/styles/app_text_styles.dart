import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../size_config/app_dimen.dart';
import '../size_config/dimens.dart';
import '../themes/app_colors.dart';

abstract class AppTextStyles {
  static TextStyle style = GoogleFonts.beVietnamPro(
    fontSize: Dimens.d16.responsive(),
    fontWeight: FontWeight.w400,
    color: AppColors.black,
  );
}

extension FontWeightCustom on TextStyle {
  /// FontWeight.w300 / light
  TextStyle get w300 => copyWith(fontWeight: FontWeight.w300);

  /// FontWeight.w400 / regular
  TextStyle get w400 => copyWith(fontWeight: FontWeight.w400);

  /// FontWeight.w500 / medium
  TextStyle get w500 => copyWith(fontWeight: FontWeight.w500);

  /// FontWeight.w600 / semi-bold
  TextStyle get w600 => copyWith(fontWeight: FontWeight.w600);

  /// FontWeight.w700 / bold
  TextStyle get w700 => copyWith(fontWeight: FontWeight.w700);

  /// FontWeight.w800 / heavy
  TextStyle get w800 => copyWith(fontWeight: FontWeight.w800);

  /// FontWeight.w900 / black
  TextStyle get w900 => copyWith(fontWeight: FontWeight.w900);
}

extension FontSizeCustom on TextStyle {
  /// fontSize: 10
  TextStyle get s10 => copyWith(fontSize: Dimens.d10.responsive());

  /// fontSize: 11
  TextStyle get s11 => copyWith(fontSize: Dimens.d11.responsive());

  /// fontSize: 12
  TextStyle get s12 => copyWith(fontSize: Dimens.d12.responsive());

  /// fontSize: 13
  TextStyle get s13 => copyWith(fontSize: Dimens.d13.responsive());

  /// fontSize: 14
  TextStyle get s14 => copyWith(fontSize: Dimens.d14.responsive());

  /// fontSize: 15
  TextStyle get s15 => copyWith(fontSize: Dimens.d15.responsive());

  /// fontSize: 16
  TextStyle get s16 => copyWith(fontSize: Dimens.d16.responsive());

  /// fontSize: 17
  TextStyle get s17 => copyWith(fontSize: Dimens.d17.responsive());

  /// fontSize: 18
  TextStyle get s18 => copyWith(fontSize: Dimens.d18.responsive());

  /// fontSize: 19
  TextStyle get s19 => copyWith(fontSize: Dimens.d19.responsive());

  /// fontSize: 20
  TextStyle get s20 => copyWith(fontSize: Dimens.d20.responsive());

  /// fontSize: 22
  TextStyle get s22 => copyWith(fontSize: Dimens.d22.responsive());

  /// fontSize: 24
  TextStyle get s24 => copyWith(fontSize: Dimens.d24.responsive());

  /// fontSize: 25
  TextStyle get s25 => copyWith(fontSize: Dimens.d25.responsive());

  /// fontSize: 28
  TextStyle get s28 => copyWith(fontSize: Dimens.d28.responsive());

  /// fontSize: 32
  TextStyle get s32 => copyWith(fontSize: Dimens.d32.responsive());

  /// fontSize: s40
  TextStyle get s40 => copyWith(fontSize: Dimens.d40.responsive());

  /// fontSize: s40
  TextStyle get s48 => copyWith(fontSize: Dimens.d48.responsive());

  /// fontSize: 90
  TextStyle get s90 => copyWith(fontSize: Dimens.d90.responsive());
}

extension FontColorCustom on TextStyle {
  /// color: white
  TextStyle get whiteColor => copyWith(color: AppColors.white);

  /// color: black
  TextStyle get blackColor => copyWith(color: AppColors.black);

  /// color: whiteSmoke
  TextStyle get whiteSmokeColor => copyWith(color: AppColors.whiteSmoke);

  /// color: silver
  TextStyle get silverColor => copyWith(color: AppColors.silver);
}

extension FontStyleCustom on TextStyle {
  TextStyle get italic => copyWith(fontStyle: FontStyle.italic);
}

extension FontDecorationCustom on TextStyle {
  /// decoration: TextDecoration.overline,
  TextStyle get overline => copyWith(decoration: TextDecoration.overline);

  /// decoration: TextDecoration.underline,
  TextStyle get underline => copyWith(decoration: TextDecoration.underline);
}
