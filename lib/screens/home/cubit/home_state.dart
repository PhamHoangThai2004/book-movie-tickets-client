part of 'home_cubit.dart';

class HomeState {
  final List<MoviePreviewModel> nowPlayingMovies;
  final List<MoviePreviewModel> comingSoonMovies;
  final List<MoviePosterPreviewModel> previewMovies;
  final String errorMessage;
  final bool isNowPlayingLoading;
  final bool isComingSoonLoading;
  final bool isPreviewLoading;
  final MovieModel? movie;
  final StatusEnum status;

  HomeState({
    this.nowPlayingMovies = const [],
    this.comingSoonMovies = const [],
    this.previewMovies = const [],
    this.errorMessage = '',
    this.isNowPlayingLoading = true,
    this.isComingSoonLoading = true,
    this.isPreviewLoading = true,
    this.movie,
    this.status = StatusEnum.initial,
  });

  HomeState copyWith({
    List<MoviePreviewModel>? nowPlayingMovies,
    List<MoviePreviewModel>? comingSoonMovies,
    List<MoviePosterPreviewModel>? previewMovies,
    String? errorMessage,
    bool? isNowPlayingLoading,
    bool? isComingSoonLoading,
    bool? isPreviewLoading,
    MovieModel? movie,
    StatusEnum? status,
  }) {
    return HomeState(
      nowPlayingMovies: nowPlayingMovies ?? this.nowPlayingMovies,
      comingSoonMovies: comingSoonMovies ?? this.comingSoonMovies,
      previewMovies: previewMovies ?? this.previewMovies,
      errorMessage: errorMessage ?? this.errorMessage,
      isNowPlayingLoading: isNowPlayingLoading ?? this.isNowPlayingLoading,
      isComingSoonLoading: isComingSoonLoading ?? this.isComingSoonLoading,
      isPreviewLoading: isPreviewLoading ?? this.isPreviewLoading,
      movie: movie ?? this.movie,
      status: status ?? this.status,
    );
  }
}
