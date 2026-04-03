enum MovieStatusEnum { comingSoon, nowShowing, ended }

extension MovieStatusEnumX on MovieStatusEnum {
  bool get isComingSoon => this == MovieStatusEnum.comingSoon;

  bool get isNowShowing => this == MovieStatusEnum.nowShowing;

  bool get isEnded => this == MovieStatusEnum.ended;

  static MovieStatusEnum fromKey(String status) {
    switch (status) {
      case 'coming_soon':
        return MovieStatusEnum.comingSoon;
      case 'now_showing':
        return MovieStatusEnum.nowShowing;
      case 'ended':
        return MovieStatusEnum.ended;
      default:
        throw Exception('Invalid movie status: $status');
    }
  }

  String get toKey  {
    switch (this) {
      case MovieStatusEnum.comingSoon:
        return 'coming_soon';
      case MovieStatusEnum.nowShowing:
        return 'now_showing';
      case MovieStatusEnum.ended:
        return 'ended';
    }
  }
}
