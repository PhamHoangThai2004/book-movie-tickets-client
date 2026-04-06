enum ShowtimeFormatEnum { twoD, threeD, imax, imax3D, fourDX, screenX, dolbyCinema }

extension ShowtimeFormatEnumX on ShowtimeFormatEnum {
  bool get isTwoD => this == ShowtimeFormatEnum.twoD;

  bool get isThreeD => this == ShowtimeFormatEnum.threeD;

  bool get isImax => this == ShowtimeFormatEnum.imax;

  bool get isImax3D => this == ShowtimeFormatEnum.imax3D;

  bool get isFourDX => this == ShowtimeFormatEnum.fourDX;

  bool get isScreenX => this == ShowtimeFormatEnum.screenX;

  bool get isDolbyCinema => this == ShowtimeFormatEnum.dolbyCinema;

  static ShowtimeFormatEnum fromKey(String format) {
    switch (format) {
      case '2_d':
        return ShowtimeFormatEnum.twoD;
      case '3_d':
        return ShowtimeFormatEnum.threeD;
      case 'imax':
        return ShowtimeFormatEnum.imax;
      case 'imax_3_d':
        return ShowtimeFormatEnum.imax3D;
      case '4_d_x':
        return ShowtimeFormatEnum.fourDX;
      case 'screen_x':
        return ShowtimeFormatEnum.screenX;
      case 'dolby_cinema':
        return ShowtimeFormatEnum.dolbyCinema;
      default:
        throw Exception('Invalid showtime format: $format');
    }
  }
}
