import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';

import '../../core/themes/app_colors.dart';

enum PaymentStatusEnum { pending, success, failed, cancelled }

extension PaymentStatusEnumX on PaymentStatusEnum {
  bool get isPending => this == PaymentStatusEnum.pending;

  bool get isSuccess => this == PaymentStatusEnum.success;

  bool get isFailed => this == PaymentStatusEnum.failed;

  bool get isCancelled => this == PaymentStatusEnum.cancelled;

  static PaymentStatusEnum fromKey(String status) {
    switch (status) {
      case 'pending':
        return PaymentStatusEnum.pending;
      case 'success':
        return PaymentStatusEnum.success;
      case 'failed':
        return PaymentStatusEnum.failed;
      case 'cancelled':
        return PaymentStatusEnum.cancelled;
      default:
        throw Exception('Invalid movie status: $status');
    }
  }

  String get displayStatus {
    switch (this) {
      case PaymentStatusEnum.pending:
        return 'unpaid'.tr();
      case PaymentStatusEnum.success:
        return 'paid'.tr();
      case PaymentStatusEnum.failed:
        return 'failure'.tr();
      case PaymentStatusEnum.cancelled:
        return 'cancel_short'.tr();
    }
  }

  Color get background {
    switch (this) {
      case PaymentStatusEnum.pending:
        return AppColors.amberYellow;
      case PaymentStatusEnum.success:
        return AppColors.green;
      case PaymentStatusEnum.failed:
        return AppColors.red;
      case PaymentStatusEnum.cancelled:
        return AppColors.red;
    }
  }
}
