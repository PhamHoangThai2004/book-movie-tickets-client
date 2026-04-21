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
  });

  SearchState copyWith({
    PaginationResponse<MoviePreviewModel>? searchResult,
    List<MoviePreviewModel>? searchResults,
    String? searchQuery,
    StatusEnum? status,
    String? errorMessage,
    int? currentPage,
    int? totalPages,
    bool? hasMore,
    bool? isLoadingMore,
    MovieStatusEnum? selectedStatus,
    GenreModel? selectedGenre,
    List<String>? availableGenres,
    bool? showFilters,
    List<GenreModel>? genres,
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
    );
  }
}
