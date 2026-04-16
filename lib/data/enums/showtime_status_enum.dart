enum ShowtimeStatusEnum { upcoming, ongoing, finished }

extension ShowtimeStatusEnumX on ShowtimeStatusEnum {
  bool get isUpcoming => this == ShowtimeStatusEnum.upcoming;

  bool get isOngoing => this == ShowtimeStatusEnum.ongoing;

  bool get isFinished => this == ShowtimeStatusEnum.finished;

  static ShowtimeStatusEnum fromKey(String status) {
    switch (status) {
      case 'upcoming':
        return ShowtimeStatusEnum.upcoming;
      case 'ongoing':
        return ShowtimeStatusEnum.ongoing;
      case 'finished':
        return ShowtimeStatusEnum.finished;
      default:
        throw Exception('Invalid showtime status: $status');
    }
  }
}
