import 'package:client/data/local/preferences.dart';
import 'package:client/data/model/movie_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/enums/status_enum.dart';
import '../../../data/model/movie_poster_preview_model.dart';
import '../../../data/network/exceptions/api_exception.dart';
import '../../../data/repositories/movie_repository.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final MovieRepository _movieRepository;

  AuthCubit({required MovieRepository movieRepository})
    : _movieRepository = movieRepository,
      super(AuthState());

  void _loadCachedPosters() {
    try {
      final cachedPosters = Preferences.instance.getAuthMoviePosters();
      if (cachedPosters.isNotEmpty) {
        emit(state.copyWith(movies: cachedPosters));
      }
    } catch (e) {
      debugPrint('Error loading cached posters: $e');
    }
  }

  Future<void> getMoviePreviews() async {
    _loadCachedPosters();
    try {
      final response = await _movieRepository.getMoviePreviews(5);

      await Preferences.instance.saveAuthMoviePosters(response);

      emit(state.copyWith(movies: response));
    } catch (e) {
      emit(state.copyWith(movies: []));
    }
  }

  Future<void> getMovieDetail(String id) async {
    emit(state.copyWith(status: StatusEnum.processing));
    try {
      final response = await _movieRepository.getMovieById(id);
      emit(state.copyWith(movie: response, status: StatusEnum.success));
    } on ApiException catch (e) {
      emit(state.copyWith(status: StatusEnum.failure, errorMessage: e.errorMessage));
    }
  }
}
