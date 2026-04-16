import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';

enum TicketStatusEnum { waiting, issued, used, cancelled, expired }

extension TicketStatusEnumX on TicketStatusEnum {
  bool get isWaiting => this == TicketStatusEnum.waiting;

  bool get isIssued => this == TicketStatusEnum.issued;

  bool get isUsed => this == TicketStatusEnum.used;

  bool get isCanceled => this == TicketStatusEnum.cancelled;

  bool get isExpired => this == TicketStatusEnum.expired;

  static TicketStatusEnum fromKey(String status) {
    switch (status) {
      case 'waiting':
        return TicketStatusEnum.waiting;
      case 'issued':
        return TicketStatusEnum.issued;
      case 'used':
        return TicketStatusEnum.used;
      case 'cancelled':
        return TicketStatusEnum.cancelled;
      case 'expired':
        return TicketStatusEnum.expired;
      default:
        throw Exception('Invalid ticket status: $status');
    }
  }

  String get title {
    switch (this) {
      case TicketStatusEnum.waiting:
        return '';
      case TicketStatusEnum.issued:
        return 'issued'.tr();
      case TicketStatusEnum.used:
        return 'checked_in'.tr();
      case TicketStatusEnum.cancelled:
        return 'cancelled'.tr();
      case TicketStatusEnum.expired:
        return 'expired'.tr();
    }
  }

  Color get background {
    switch (this) {
      case TicketStatusEnum.waiting:
        return const Color(0xFFFFB800);
      case TicketStatusEnum.issued:
        return const Color(0xFFFFB800);
      case TicketStatusEnum.used:
        return const Color(0xFF00C853);
      case TicketStatusEnum.cancelled:
        return const Color(0xFFF44336);
      case TicketStatusEnum.expired:
        return const Color(0xFFF44336);
    }
  }
}
