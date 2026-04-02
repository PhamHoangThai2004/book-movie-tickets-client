import 'package:client/data/enums/movie_status_enum.dart';
import 'package:client/data/network/exceptions/api_exception.dart';
import 'package:client/data/repositories/movie_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/enums/status_enum.dart';
import '../../../data/remote/requests/movie_preview_request.dart';
import 'movie_state.dart';

class MovieCubit extends Cubit<MovieState> {
  final MovieRepository movieRepository;

  MovieCubit({required this.movieRepository}) : super(const MovieState());

  void onTabChanged(bool isNowPlaying) {
    if (state.isNowPlaying == isNowPlaying) return;

    emit(state.copyWith(isNowPlaying: isNowPlaying));

    final hasData = isNowPlaying ? state.nowPlayingMovies != null : state.comingSoonMovies != null;
    if (!hasData) {
      fetchMovies();
    }
  }

  Future<void> fetchMovies() async {
    emit(state.copyWith(status: StatusEnum.processing));
    try {
      final request = MoviePreviewRequest(
        search: null,
        genre: null,
        status: state.isNowPlaying
            ? MovieStatusEnum.nowShowing.toKey
            : MovieStatusEnum.comingSoon.toKey,
        page: state.isNowPlaying
            ? state.nowPlayingMovies?.page ?? 1
            : state.comingSoonMovies?.page ?? 1,
        size: 10,
      );
      final response = await movieRepository.getMovies(request);

      state.isNowPlaying
          ? emit(state.copyWith(nowPlayingMovies: response, status: StatusEnum.initial))
          : emit(state.copyWith(comingSoonMovies: response, status: StatusEnum.initial));
    } on ApiException catch (e) {
      emit(state.copyWith(status: StatusEnum.failure, errorMessage: e.errorMessage));
    }
  }

  Future<void> refreshMovies() async {
    emit(state.copyWith(status: StatusEnum.processing));
    try {
      final request = MoviePreviewRequest(
        search: null,
        genre: null,
        status: state.isNowPlaying
            ? MovieStatusEnum.nowShowing.toKey
            : MovieStatusEnum.comingSoon.toKey,
        page: 1,
        size: 10,
      );
      final response = await movieRepository.getMovies(request);

      state.isNowPlaying
          ? emit(state.copyWith(nowPlayingMovies: response, status: StatusEnum.initial))
          : emit(state.copyWith(comingSoonMovies: response, status: StatusEnum.initial));
    } on ApiException catch (e) {
      emit(state.copyWith(status: StatusEnum.failure, errorMessage: e.errorMessage));
    }
  }

  Future<void> loadMoreMovies() async {
    if (state.status == StatusEnum.processing || state.isLoadingMore) return;

    final currentData = state.isNowPlaying ? state.nowPlayingMovies : state.comingSoonMovies;
    if (currentData == null) return;

    if (!currentData.hasMore || currentData.page >= currentData.totalPages) return;

    emit(state.copyWith(isLoadingMore: true));

    try {
      final nextPage = currentData.page + 1;
      final request = MoviePreviewRequest(
        search: null,
        genre: null,
        status: state.isNowPlaying
            ? MovieStatusEnum.nowShowing.toKey
            : MovieStatusEnum.comingSoon.toKey,
        page: nextPage,
        size: 10,
      );
      final response = await movieRepository.getMovies(request);

      if (state.isNowPlaying) {
        final mergedData = currentData.copyWith(
          items: [...currentData.items, ...response.items],
          page: response.page,
          hasMore: response.hasMore,
        );
        emit(
          state.copyWith(
            nowPlayingMovies: mergedData,
            status: StatusEnum.initial,
            isLoadingMore: false,
          ),
        );
      } else {
        final mergedData = currentData.copyWith(
          items: [...currentData.items, ...response.items],
          page: response.page,
          hasMore: response.hasMore,
        );
        emit(
          state.copyWith(
            comingSoonMovies: mergedData,
            status: StatusEnum.initial,
            isLoadingMore: false,
          ),
        );
      }
    } on ApiException catch (e) {
      emit(
        state.copyWith(
          status: StatusEnum.failure,
          errorMessage: e.errorMessage,
          isLoadingMore: false,
        ),
      );
    }
  }

  Future<void> getMovieDetail(String movieId) async {
    emit(state.copyWith(movieStatus: StatusEnum.processing, errorMessage: ''));
    try {
      final response = await movieRepository.getMovieById(movieId);
      emit(state.copyWith(movie: response, movieStatus: StatusEnum.success));
    } on ApiException catch (e) {
      emit(state.copyWith(movieStatus: StatusEnum.failure, errorMessage: e.errorMessage));
    }
  }
}
