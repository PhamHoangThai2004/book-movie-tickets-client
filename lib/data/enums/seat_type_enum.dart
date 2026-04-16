import 'package:easy_localization/easy_localization.dart';

enum SeatTypeEnum { normal, vip }

extension SeatTypeEnumX on SeatTypeEnum {
  bool get isNormal => this == SeatTypeEnum.normal;

  bool get isVip => this == SeatTypeEnum.vip;

  static SeatTypeEnum fromKey(String seatType) {
    switch (seatType) {
      case 'normal':
        return SeatTypeEnum.normal;
      case 'vip':
        return SeatTypeEnum.vip;
      default:
        throw Exception('Invalid seat type: $seatType');
    }
  }

  String get name {
    switch (this) {
      case SeatTypeEnum.normal:
        return 'standard'.tr();
      case SeatTypeEnum.vip:
        return 'vip'.tr();
    }
  }
}
