part of 'search_cubit.dart';

class SearchState {
  final PaginationResponse<MoviePreviewModel>? searchResult;
  final String searchQuery;
  final StatusEnum status;
  final String errorMessage;
  final bool isLoadingMore;
  final MovieStatusEnum? selectedStatus;
  final GenreModel? selectedGenre;
  final bool showFilters;
  final List<GenreModel> genres;
  final StatusEnum loadStatus;
  final MovieModel? movie;

  SearchState({
    this.searchQuery = '',
    this.status = StatusEnum.initial,
    this.errorMessage = '',
    this.isLoadingMore = false,
    this.selectedStatus,
    this.selectedGenre,
    this.showFilters = false,
    this.genres = const [],
    this.searchResult,
    this.loadStatus = StatusEnum.initial,
    this.movie,
  });

  int get page => searchResult?.page ?? 1;
  bool get hasMore => searchResult?.hasMore ?? false;

  SearchState copyWith({
    PaginationResponse<MoviePreviewModel>? searchResult,
    String? searchQuery,
    StatusEnum? status,
    String? errorMessage,
    bool? isLoadingMore,
    MovieStatusEnum? selectedStatus,
    GenreModel? selectedGenre,
    List<String>? availableGenres,
    bool? showFilters,
    List<GenreModel>? genres,
    StatusEnum? loadStatus,
    MovieModel? movie,
  }) {
    return SearchState(
      searchQuery: searchQuery ?? this.searchQuery,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      selectedStatus: selectedStatus ?? this.selectedStatus,
      selectedGenre: selectedGenre ?? this.selectedGenre,
      showFilters: showFilters ?? this.showFilters,
      genres: genres ?? this.genres,
      searchResult: searchResult ?? this.searchResult,
      loadStatus: loadStatus ?? this.loadStatus,
      movie: movie ?? this.movie,
    );
  }

  SearchState setFilter(MovieStatusEnum? selectedStatus, GenreModel? selectedGenre) {
    return SearchState(
      searchQuery: searchQuery,
      status: status,
      errorMessage: errorMessage,
      isLoadingMore: isLoadingMore,
      selectedStatus: selectedStatus,
      selectedGenre: selectedGenre,
      showFilters: showFilters,
      genres: genres,
      searchResult: searchResult,
      loadStatus: loadStatus,
      movie: movie,
    );
  }
}
