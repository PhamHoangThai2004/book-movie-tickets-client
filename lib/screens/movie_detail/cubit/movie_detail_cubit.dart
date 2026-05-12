import 'package:client/core/utils/app_utils.dart';
import 'package:client/data/network/exceptions/api_exception.dart';
import 'package:client/data/remote/responses/pagination_response.dart';
import 'package:client/data/repositories/movie_repository.dart';
import 'package:client/data/model/cinema_model.dart';
import 'package:client/data/repositories/review_repository.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../data/enums/status_enum.dart';
import '../../../data/model/review_model.dart';
import '../../../data/remote/requests/create_review_request.dart';

part 'movie_detail_state.dart';

@injectable
class MovieDetailCubit extends Cubit<MovieDetailState> {
  final MovieRepository _movieRepository;
  final ReviewRepository _reviewRepository;

  MovieDetailCubit(this._movieRepository, this._reviewRepository) : super(const MovieDetailState());

  Future<void> getCinemas(String movieId) async {
    if (state.cinemasStatus.isProcessing) return;

    emit(state.copyWith(cinemasStatus: StatusEnum.processing, errorMessage: ''));
    try {
      final response = await _movieRepository.getCinemasByMovieId(movieId);
      emit(
        state.copyWith(
          cinemas: response,
          cinemasStatus: StatusEnum.success,
          selectedCinema: response.isNotEmpty ? response.first : null,
        ),
      );
    } on ApiException catch (e) {
      emit(state.copyWith(cinemasStatus: StatusEnum.failure, errorMessage: e.errorMessage));
    }
  }

  void selectCinema(CinemaModel selectedCinema) {
    if (state.selectedCinema?.id == selectedCinema.id) return;
    emit(state.copyWith(selectedCinema: selectedCinema));
  }

  void setIsPlaying(bool isPlaying) {
    emit(state.copyWith(isPlaying: isPlaying));
  }

  Future<void> getReviews(String movieId) async {
    emit(state.copyWith(reviewsStatus: StatusEnum.processing));
    try {
      final response = await _movieRepository.getReviews(movieId);
      emit(state.copyWith(reviews: response, reviewsStatus: StatusEnum.success));
    } on ApiException catch (e) {
      emit(state.copyWith(reviewsStatus: StatusEnum.failure, errorMessage: e.errorMessage));
    }
  }

  Future<void> addReview(String movieId) async {
    final errorRating = AppUtils.validationRating(state.rating);
    final errorComment = AppUtils.validationComment(state.comment);

    if (errorRating.isNotEmpty && errorComment.isNotEmpty) {
      emit(state.copyWith(errorMessage: 'pls_enter_review'.tr()));
      return;
    }

    if (errorRating.isNotEmpty) {
      emit(state.copyWith(errorMessage: errorRating));
      return;
    }

    if (errorComment.isNotEmpty) {
      emit(state.copyWith(errorMessage: errorComment));
      return;
    }

    emit(state.copyWith(submitReviewStatus: StatusEnum.processing));
    try {
      final request = CreateReviewRequest(
        movieId: movieId,
        rating: state.rating,
        comment: state.comment,
      );
      await _reviewRepository.createReview(request);
      emit(state.copyWith(submitReviewStatus: StatusEnum.success, rating: 0, comment: ''));
    } on ApiException catch (e) {
      emit(state.copyWith(submitReviewStatus: StatusEnum.failure, errorMessage: e.errorMessage));
    }
  }

  void setRating(int rating) {
    emit(state.copyWith(rating: rating));
  }

  void setComment(String comment) {
    final value = comment.trim();
    emit(state.copyWith(comment: value));
  }
}
