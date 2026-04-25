import 'dart:async';
import 'dart:io';
import 'package:client/core/common/app_config.dart';
import 'package:curl_logger_dio_interceptor/curl_logger_dio_interceptor.dart';
import 'package:dio/dio.dart';

import '../../local/preferences.dart';

class AuthInterceptor extends InterceptorsWrapper {
  Completer<String>? _refreshTokenCompleter;

  bool isForceLogout = false;

  final String _refreshTokenPath = 'auth/refresh-token';

  @override
  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final accessToken = Preferences.instance.accessToken;

    options.headers['Accept-Language'] = 'vi';
    options.headers['Authorization'] = 'Bearer $accessToken';
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

    if (err.response?.statusCode == HttpStatus.unauthorized) {
      isForceLogout = true;
      try {
        final newToken = await _handleRefreshToken(err.requestOptions);
        final response = await _retryRequest(newToken, err.requestOptions);
        handler.resolve(response);
      } catch (error) {
        if (isForceLogout) {
          isForceLogout = false;
          await _forceLogout(err);
        }
        handler.next(err);
      }
      return;
    }

    handler.next(err);
  }

  Future<String> _handleRefreshToken(RequestOptions options) async {
    if (_refreshTokenCompleter != null) {
      return _refreshTokenCompleter!.future;
    }

    _refreshTokenCompleter = Completer();

    try {
      final newToken = await _refreshToken();
      _refreshTokenCompleter?.complete(newToken);
      _refreshTokenCompleter = null;
      return newToken;
    } catch (e) {
      _refreshTokenCompleter?.completeError(e);
      _refreshTokenCompleter = null;
      rethrow;
    }
  }

  Future<String> _refreshToken() async {
    final refreshToken = Preferences.instance.refreshToken;
    if (refreshToken.isEmpty) {
      throw Exception('Không thể lấy refresh token!');
    }

    final Dio dio = Dio(BaseOptions(baseUrl: AppConfig.baseUrl))
      ..interceptors.addAll([CurlLoggerDioInterceptor(printOnSuccess: true)]);
    try {
      final response = await dio.post(_refreshTokenPath, data: {'refreshToken': refreshToken});
      final newToken = response.data['data']['accessToken'] as String;
      await Preferences.instance.saveAccessToken(newToken);
      return newToken;
    } on Exception catch (e) {
      throw Exception('Không thể ấy accessToken! $e');
    }
  }

  Future<Response<dynamic>> _retryRequest(String accessToken, RequestOptions requestOptions) async {
    final Dio dioClient = Dio(BaseOptions(baseUrl: AppConfig.baseUrl))
      ..interceptors.addAll([CurlLoggerDioInterceptor(printOnSuccess: true)]);
    requestOptions.headers['Authorization'] = 'Bearer $accessToken';

    return dioClient.request(
      requestOptions.path,
      data: requestOptions.data,
      queryParameters: requestOptions.queryParameters,
      options: Options(method: requestOptions.method, headers: requestOptions.headers),
    );
  }

  Future<void> _forceLogout(DioException error) async {
    // AppUtils.shared.showSessionExpiredDialog();
  }
}
