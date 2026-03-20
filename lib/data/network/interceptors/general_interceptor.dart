import 'dart:io';
import 'package:dio/dio.dart';

class GeneralInterceptor extends InterceptorsWrapper {
  @override
  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    options.headers['Accept-Language'] = 'vi';
    handler.next(options);
  }

  @override
  Future<void> onError(DioException err, ErrorInterceptorHandler handler) async {

    if (err.type == DioExceptionType.connectionTimeout ||
        err.type == DioExceptionType.receiveTimeout) {
      handler.next(err);
      return;
    }

    if (err.error is SocketException) {
      handler.next(err);
      return;
    }
    handler.next(err);
  }
}
