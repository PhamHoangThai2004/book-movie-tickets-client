import 'package:client/data/enums/movie_status_enum.dart';
import 'package:client/data/enums/status_enum.dart';
import 'package:client/data/model/movie_model.dart';
import 'package:client/data/model/movie_preview_model.dart';
import 'package:client/data/model/movie_poster_preview_model.dart';
import 'package:client/data/network/exceptions/api_exception.dart';
import 'package:client/data/remote/requests/movie_preview_request.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../data/repositories/movie_repository.dart';

part 'home_state.dart';

@injectable
class HomeCubit extends Cubit<HomeState> {
  final MovieRepository _movieRepository;

  HomeCubit(this._movieRepository) : super(HomeState());

  Future<void> getMovies(MovieStatusEnum status) async {
    try {
      if (status.isComingSoon) {
        emit(state.copyWith(isComingSoonLoading: true));
      } else if (status.isNowShowing) {
        emit(state.copyWith(isNowPlayingLoading: true));
      }

      final request = MoviePreviewRequest(status: status.toKey, page: 1, size: 10);
      final response = await _movieRepository.getMovies(request);
      if (status.isComingSoon) {
        emit(state.copyWith(comingSoonMovies: response.items, isComingSoonLoading: false));
      } else if (status.isNowShowing) {
        emit(state.copyWith(nowPlayingMovies: response.items, isNowPlayingLoading: false));
      }
    } on ApiException catch (e) {
      emit(state.copyWith(errorMessage: e.errorMessage));
    }
  }

  Future<void> getMoviePreviews(int limit) async {
    try {
      emit(state.copyWith(isPreviewLoading: true));
      final response = await _movieRepository.getMoviePreviews(limit);
      emit(state.copyWith(previewMovies: response, isPreviewLoading: false));
    } on ApiException catch (e) {
      emit(state.copyWith(errorMessage: e.errorMessage));
    }
  }

  Future<void> getMovieDetail(String id) async {
    try {
      emit(state.copyWith(status: StatusEnum.processing));
      final response = await _movieRepository.getMovieById(id);
      emit(state.copyWith(movie: response, status: StatusEnum.success));
    } on ApiException catch (e) {
      emit(state.copyWith(errorMessage: e.errorMessage));
    }
  }
}
