import 'package:client/data/remote/requests/create_review_request.dart';
import 'package:curl_logger_dio_interceptor/curl_logger_dio_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../core/common/app_config.dart';
import '../../network/exceptions/api_exception.dart';
import '../../network/interceptors/auth_interceptor.dart';
import '../requests/update_review_request.dart';

@lazySingleton
class ReviewService {
  final String _reviewPath = 'users/reviews';

  final Dio _dio = Dio(BaseOptions(baseUrl: AppConfig.baseUrl))
    ..interceptors.addAll([CurlLoggerDioInterceptor(printOnSuccess: true), AuthInterceptor()]);

  Future<void> createReview(CreateReviewRequest request) async {
    try {
      await _dio.post(_reviewPath, data: request.toJson());
    } on ApiException {
      rethrow;
    }
  }

  Future<void> updateReview(String id, UpdateReviewRequest request) async {
    try {
      await _dio.patch('$_reviewPath/$id', data: request.toJson());
    } on ApiException {
      rethrow;
    }
  }

  Future<void> removeReview(String id) async {
    try {
      await _dio.delete('$_reviewPath/$id');
    } on ApiException {
      rethrow;
    }
  }
}
