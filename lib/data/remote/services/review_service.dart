import 'package:client/data/model/review_model.dart';
import 'package:client/data/remote/requests/create_review_request.dart';
import 'package:curl_logger_dio_interceptor/curl_logger_dio_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../core/common/app_config.dart';
import '../../network/exceptions/api_exception.dart';
import '../../network/interceptors/auth_interceptor.dart';
import '../requests/update_review_request.dart';
import '../responses/model_response.dart';

@lazySingleton
class ReviewService {
  final String _reviewPath = 'users/reviews';

  final Dio _dio = Dio(BaseOptions(baseUrl: AppConfig.baseUrl))
    ..interceptors.addAll([CurlLoggerDioInterceptor(printOnSuccess: true), AuthInterceptor()]);

  Future<ReviewModel> createReview(CreateReviewRequest request) async {
    try {
      final response = await _dio.post(_reviewPath, data: request.toJson());
      final result = ModelResponse.fromJson(
        response.data,
        (json) => ReviewModel.fromJson(json as Map<String, dynamic>),
      );
      return result.data;
    } on ApiException {
      rethrow;
    }
  }

  Future<ReviewModel> updateReview(String id, UpdateReviewRequest request) async {
    try {
      final response = await _dio.patch('$_reviewPath/$id', data: request.toJson());
      final result = ModelResponse.fromJson(
        response.data,
        (json) => ReviewModel.fromJson(json as Map<String, dynamic>),
      );
      return result.data;
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
