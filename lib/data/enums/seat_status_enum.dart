import 'dart:ui';

import 'package:client/core/themes/app_colors.dart';
import 'package:client/data/enums/seat_type_enum.dart';
import 'package:easy_localization/easy_localization.dart';

enum SeatStatusEnum { available, reserved, booked, disabled }

extension SeatStatusEnumX on SeatStatusEnum {
  bool get isAvailable => this == SeatStatusEnum.available;

  bool get isReserved => this == SeatStatusEnum.reserved;

  bool get isBooked => this == SeatStatusEnum.booked;

  bool get isDisabled => this == SeatStatusEnum.disabled;

  static SeatStatusEnum fromKey(String seatStatus) {
    switch (seatStatus) {
      case 'available':
        return SeatStatusEnum.available;
      case 'reserved':
        return SeatStatusEnum.reserved;
      case 'booked':
        return SeatStatusEnum.booked;
      case 'disabled':
        return SeatStatusEnum.disabled;
      default:
        throw Exception('Invalid seat status: $seatStatus');
    }
  }

  String name(SeatTypeEnum seatType) {
    switch (this) {
      case SeatStatusEnum.available:
        if (seatType.isNormal) return seatType.name;
        return seatType.name;
      case SeatStatusEnum.reserved:
        return 'selected'.tr();
      case SeatStatusEnum.booked:
        return 'booked'.tr();
      case SeatStatusEnum.disabled:
        return 'locked'.tr();
    }
  }

  Color background(SeatTypeEnum seatType) {
    switch (this) {
      case SeatStatusEnum.available:
        if (seatType.isNormal) return AppColors.obsidian;
        return AppColors.amberYellow.withValues(alpha: 0.1);
      case SeatStatusEnum.reserved:
        return AppColors.amberYellow;
      case SeatStatusEnum.booked:
        return AppColors.amberYellow.withValues(alpha: 0.5);
      case SeatStatusEnum.disabled:
        return AppColors.black;
    }
  }

  Color color(SeatTypeEnum seatType) {
    switch (this) {
      case SeatStatusEnum.available:
        if (seatType.isNormal) return AppColors.silverGray;
        return AppColors.amberYellow;
      case SeatStatusEnum.reserved:
        return AppColors.black;
      case SeatStatusEnum.booked:
        return AppColors.amberYellow;
      case SeatStatusEnum.disabled:
        return AppColors.black;
    }
  }
}
