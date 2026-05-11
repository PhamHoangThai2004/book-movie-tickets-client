import 'package:client/data/model/review_model.dart';
import 'package:injectable/injectable.dart';

import '../network/exceptions/api_exception.dart';
import '../remote/requests/create_review_request.dart';
import '../remote/requests/update_review_request.dart';
import '../remote/services/review_service.dart';

abstract class ReviewRepository {
  Future<ReviewModel> createReview(CreateReviewRequest request);

  Future<ReviewModel> updateReview(String id, UpdateReviewRequest request);

  Future<void> removeReview(String id);
}

@LazySingleton(as: ReviewRepository)
class ReviewRepositoryImpl implements ReviewRepository {
  final ReviewService _reviewService;

  ReviewRepositoryImpl({required ReviewService reviewService}) : _reviewService = reviewService;

  @override
  Future<ReviewModel> createReview(CreateReviewRequest request) async {
    try {
      final response = await _reviewService.createReview(request);
      return response;
    } catch (e) {
      throw ApiException.error(e);
    }
  }

  @override
  Future<void> removeReview(String id) async {
    try {
      await _reviewService.removeReview(id);
    } catch (e) {
      throw ApiException.error(e);
    }
  }

  @override
  Future<ReviewModel> updateReview(String id, UpdateReviewRequest request) async {
    try {
      final response = await _reviewService.updateReview(id, request);
      return response;
    } catch (e) {
      throw ApiException.error(e);
    }
  }
}
