import 'package:client/data/enums/movie_status_enum.dart';
import 'package:client/data/enums/status_enum.dart';
import 'package:client/data/model/genre_model.dart';
import 'package:client/data/model/movie_preview_model.dart';
import 'package:client/data/network/exceptions/api_exception.dart';
import 'package:client/data/remote/requests/movie_preview_request.dart';
import 'package:client/data/remote/responses/pagination_response.dart';
import 'package:client/data/repositories/movie_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../data/model/movie_model.dart';

part 'search_state.dart';

@injectable
class SearchCubit extends Cubit<SearchState> {
  final MovieRepository _movieRepository;

  SearchCubit(this._movieRepository) : super(SearchState());

  Future<void> searchMovies(String query) async {
    if (query.isEmpty) {
      emit(state.copyWith(searchQuery: '', searchResult: null, status: StatusEnum.initial));
      return;
    }

    emit(state.copyWith(status: StatusEnum.processing, searchQuery: query));

    try {
      debugPrint('🔍 Searching: "$query" - Page 1');
      final request = MoviePreviewRequest(
        search: query,
        genre: state.selectedGenre?.name,
        status: state.selectedStatus?.toKey,
        page: 1,
        size: 10,
      );
      final response = await _movieRepository.getMovies(request);

      debugPrint('✅ Found ${response.items.length} results');
      emit(state.copyWith(searchResult: response, status: StatusEnum.initial));
    } on ApiException catch (e) {
      debugPrint('❌ Search error: ${e.errorMessage}');
      emit(state.copyWith(status: StatusEnum.failure, errorMessage: e.errorMessage));
    }
  }

  void setFilter(MovieStatusEnum? status, GenreModel? genre) {
    debugPrint('🎬 Filter changed - Status: $status, Genre: ${genre?.name}');
    emit(
      state
          .setFilter(status, genre)
          .copyWith(
            searchResult: null, // Reset results when filter changes
          ),
    );
  }

  void toggleFilters() {
    emit(state.copyWith(showFilters: !state.showFilters));
  }

  Future<void> loadMoreResults() async {
    if (state.isLoadingMore || state.searchResult == null || !state.hasMore) return;

    emit(state.copyWith(isLoadingMore: true));

    try {
      final nextPage = state.searchResult!.page + 1;
      final request = MoviePreviewRequest(
        search: state.searchQuery,
        genre: state.selectedGenre?.name,
        status: state.selectedStatus?.toKey,
        page: nextPage,
        size: 10,
      );
      final response = await _movieRepository.getMovies(request);
      final mergedResults = [...state.searchResult!.items, ...response.items];
      emit(
        state.copyWith(
          searchResult: state.searchResult!.copyWith(
            items: mergedResults,
            page: nextPage,
            hasMore: response.hasMore,
          ),
          isLoadingMore: false,
        ),
      );
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

  void getGenres() async {
    try {
      final genres = await _movieRepository.getGenres();
      emit(state.copyWith(genres: genres));
    } on ApiException catch (e) {
      debugPrint(e.errorMessage);
    }
  }

  Future<void> getMovieDetail(String movieId) async {
    emit(state.copyWith(loadStatus: StatusEnum.processing));
    try {
      final response = await _movieRepository.getMovieById(movieId);
      emit(state.copyWith(loadStatus: StatusEnum.success, movie: response));
    } on ApiException catch (e) {
      emit(state.copyWith(loadStatus: StatusEnum.failure, errorMessage: e.errorMessage));
    }
  }
}
