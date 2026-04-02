import 'package:easy_localization/easy_localization.dart';

enum AgeRatingEnum { p, k, t13, t16, t18 }

extension AgeRatingEnumX on AgeRatingEnum {
  bool get isP => this == AgeRatingEnum.p;

  bool get isK => this == AgeRatingEnum.k;

  bool get isT13 => this == AgeRatingEnum.t13;

  bool get isT16 => this == AgeRatingEnum.t16;

  bool get isT18 => this == AgeRatingEnum.t18;

  static AgeRatingEnum fromKey(String status) {
    switch (status) {
      case 'p':
        return AgeRatingEnum.p;
      case 'k':
        return AgeRatingEnum.k;
      case 't_13':
        return AgeRatingEnum.t13;
      case 't_16':
        return AgeRatingEnum.t16;
      case 't_18':
        return AgeRatingEnum.t18;
      default:
        throw Exception('Invalid movie status: $status');
    }
  }

  String get displayName {
    switch (this) {
      case AgeRatingEnum.p:
        return 'popular_all_ages'.tr();
      case AgeRatingEnum.k:
        return 'children_under_13_with_parent'.tr();
      case AgeRatingEnum.t13:
        return 'audiences_under_X_years_old'.tr(namedArgs: {'age': '13'});
      case AgeRatingEnum.t16:
        return 'audiences_under_X_years_old'.tr(namedArgs: {'age': '16'});
      case AgeRatingEnum.t18:
        return 'audiences_under_X_years_old'.tr(namedArgs: {'age': '18'});
    }
  }
}
