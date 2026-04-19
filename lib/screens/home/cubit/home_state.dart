part of 'home_cubit.dart';

class HomeState {
  final List<MoviePreviewModel> nowPlayingMovies;
  final List<MoviePreviewModel> comingSoonMovies;
  final String errorMessage;
  final bool isNowPlayingLoading;
  final bool isComingSoonLoading;

  HomeState({
    this.nowPlayingMovies = const [],
    this.comingSoonMovies = const [],
    this.errorMessage = '',
    this.isNowPlayingLoading = true,
    this.isComingSoonLoading = true,
  });

  HomeState copyWith({
    List<MoviePreviewModel>? nowPlayingMovies,
    List<MoviePreviewModel>? comingSoonMovies,
    String? errorMessage,
    bool? isNowPlayingLoading,
    bool? isComingSoonLoading,
  }) {
    return HomeState(
      nowPlayingMovies: nowPlayingMovies ?? this.nowPlayingMovies,
      comingSoonMovies: comingSoonMovies ?? this.comingSoonMovies,
      errorMessage: errorMessage ?? this.errorMessage,
      isNowPlayingLoading: isNowPlayingLoading ?? this.isNowPlayingLoading,
      isComingSoonLoading: isComingSoonLoading ?? this.isComingSoonLoading,
    );
  }
}
