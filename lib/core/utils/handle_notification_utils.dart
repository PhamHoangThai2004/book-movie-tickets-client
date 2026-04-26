import 'package:client/core/customs/toasts/loading_custom.dart';
import 'package:client/data/network/exceptions/api_exception.dart';
import 'package:go_router/go_router.dart';

import '../../data/repositories/notification_repository.dart';
import '../../data/repositories/payment_repository.dart';
import '../customs/toasts/toast_custom.dart';
import '../di/injection.dart';
import '../navigation/navigation_service.dart';

class HandleNotificationUtils {
  static final _paymentRepository = getIt<PaymentRepository>();
  static final _notificationRepository = getIt<NotificationRepository>();

  static void openPayment(String notificationId,String paymentId) async {
    try {
      LoadingCustom.show();
      await _notificationRepository.markNotification(notificationId);
      final result = await _paymentRepository.getPaymentById(paymentId);
      LoadingCustom.hideLoading();
      final context = NavigationService.rootNavigatorKey.currentState!.context;
      if (!context.mounted) return;
      context.pushNamed(NavigationService.paymentDetail, extra: result);
    } on ApiException catch (e) {
      LoadingCustom.hideLoading();
      ToastCustom.show(message: e.errorMessage);
    }
  }
}
