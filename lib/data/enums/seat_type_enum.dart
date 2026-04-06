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
}
