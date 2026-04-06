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
}
