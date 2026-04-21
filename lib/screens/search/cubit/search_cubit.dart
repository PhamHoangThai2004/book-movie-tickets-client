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

part 'search_state.dart';

@injectable
class SearchCubit extends Cubit<SearchState> {
  final MovieRepository _movieRepository;

  SearchCubit(this._movieRepository) : super(SearchState());

  Future<void> searchMovies(String query) async {
    if (query.isEmpty) {
      emit(state.copyWith(searchResults: [], searchQuery: '', status: StatusEnum.initial));
      return;
    }

    emit(
      state.copyWith(
        status: StatusEnum.processing,
        searchQuery: query,
        currentPage: 1,
        searchResults: [],
      ),
    );

    try {
      final request = MoviePreviewRequest(
        search: query,
        genre: state.selectedGenre?.name,
        status: state.selectedStatus?.toKey,
        page: state.searchResult?.page ?? 1,
        size: 10,
      );
      final response = await _movieRepository.getMovies(request);

      emit(state.copyWith(searchResult: response, status: StatusEnum.initial));
    } on ApiException catch (e) {
      emit(state.copyWith(status: StatusEnum.failure, errorMessage: e.errorMessage));
    }
  }

  void setFilter(MovieStatusEnum? status, GenreModel? genre) {
    emit(state.setFilter(status, genre));
  }

  void toggleFilters() {
    emit(state.copyWith(showFilters: !state.showFilters));
  }

  Future<void> loadMoreResults() async {
    if (state.status.isProcessing || state.isLoadingMore || state.searchResult == null) return;
    if (!state.searchResult!.hasMore) return;

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
          searchResults: mergedResults,
          currentPage: response.page,
          totalPages: response.totalPages,
          hasMore: response.hasMore,
          status: StatusEnum.success,
          isLoadingMore: false,
          errorMessage: '',
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
}
