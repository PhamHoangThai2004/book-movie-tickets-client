import 'package:client/data/enums/status_enum.dart';
import 'package:client/data/model/movie_preview_model.dart';
import 'package:client/data/remote/responses/pagination_response.dart';
import 'package:equatable/equatable.dart';

class MovieState extends Equatable {
  final bool isNowPlaying;
  final PaginationResponse<MoviePreviewModel>? nowPlayingMovies;
  final PaginationResponse<MoviePreviewModel>? comingSoonMovies;
  final StatusEnum status;
  final String errorMessage;
  final bool isLoadingMore;

  const MovieState({
    this.isNowPlaying = true,
    this.nowPlayingMovies,
    this.comingSoonMovies,
    this.status = StatusEnum.initial,
    this.errorMessage = '',
    this.isLoadingMore = false,
  });

  List<MoviePreviewModel> get currentMovies =>
      isNowPlaying ? nowPlayingMovies?.items ?? [] : comingSoonMovies?.items ?? [];

  MovieState copyWith({
    bool? isNowPlaying,
    PaginationResponse<MoviePreviewModel>? nowPlayingMovies,
    PaginationResponse<MoviePreviewModel>? comingSoonMovies,
    StatusEnum? status,
    String? errorMessage,
    bool? isLoadingMore,
  }) {
    return MovieState(
      isNowPlaying: isNowPlaying ?? this.isNowPlaying,
      nowPlayingMovies: nowPlayingMovies ?? this.nowPlayingMovies,
      comingSoonMovies: comingSoonMovies ?? this.comingSoonMovies,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    );
  }

  @override
  List<Object?> get props => [
    isNowPlaying,
    nowPlayingMovies,
    comingSoonMovies,
    status,
    errorMessage,
    isLoadingMore,
  ];
}
