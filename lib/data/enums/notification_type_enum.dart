enum NotificationTypeEnum { notiPayment }

extension NotificationTypeEnumX on NotificationTypeEnum {
  bool get isNotiPayment => this == NotificationTypeEnum.notiPayment;

  static NotificationTypeEnum fromKey(String type) {
    switch (type) {
      case 'noti_payment':
        return NotificationTypeEnum.notiPayment;
      default:
        throw Exception('Invalid notification type: $type');
    }
  }
}
