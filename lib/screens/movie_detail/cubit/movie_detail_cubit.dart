import 'package:client/data/network/exceptions/api_exception.dart';
import 'package:client/data/remote/responses/pagination_response.dart';
import 'package:client/data/repositories/movie_repository.dart';
import 'package:client/data/model/cinema_model.dart';
import 'package:client/data/repositories/review_repository.dart';
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
          selectedCinemaId: response.isNotEmpty ? response.first.id : null,
        ),
      );
    } on ApiException catch (e) {
      emit(state.copyWith(cinemasStatus: StatusEnum.failure, errorMessage: e.errorMessage));
    }
  }

  void selectCinema(String cinemaId) {
    if (!state.cinemas.any((cinema) => cinema.id == cinemaId)) {
      return;
    }
    emit(state.copyWith(selectedCinemaId: cinemaId));
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

  Future<void> addReview({
    required String movieId,
    required int rating,
    required String comment,
  }) async {
    emit(state.copyWith(submitReviewStatus: StatusEnum.processing));
    try {
      final request = CreateReviewRequest(movieId: movieId, rating: rating, comment: comment);
      await _reviewRepository.createReview(request);
      await getReviews(movieId);
      emit(state.copyWith(submitReviewStatus: StatusEnum.success));
    } on ApiException catch (e) {
      emit(state.copyWith(submitReviewStatus: StatusEnum.failure, errorMessage: e.errorMessage));
    }
  }
}
