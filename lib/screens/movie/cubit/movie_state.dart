import 'package:client/data/enums/status_enum.dart';
import 'package:client/data/model/movie_preview_model.dart';
import 'package:client/data/remote/responses/pagination_response.dart';
import 'package:equatable/equatable.dart';

import '../../../data/model/movie_model.dart';

class MovieState extends Equatable {
  final bool isNowPlaying;
  final PaginationResponse<MoviePreviewModel>? nowPlayingMovies;
  final PaginationResponse<MoviePreviewModel>? comingSoonMovies;
  final StatusEnum status;
  final String errorMessage;
  final bool isLoadingMore;
  final MovieModel? movie;
  final StatusEnum movieStatus;

  const MovieState({
    this.isNowPlaying = true,
    this.nowPlayingMovies,
    this.comingSoonMovies,
    this.status = StatusEnum.initial,
    this.errorMessage = '',
    this.isLoadingMore = false,
    this.movie,
    this.movieStatus = StatusEnum.initial,
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
    MovieModel? movie,
    StatusEnum? movieStatus,
  }) {
    return MovieState(
      isNowPlaying: isNowPlaying ?? this.isNowPlaying,
      nowPlayingMovies: nowPlayingMovies ?? this.nowPlayingMovies,
      comingSoonMovies: comingSoonMovies ?? this.comingSoonMovies,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      movie: movie ?? this.movie,
      movieStatus: movieStatus ?? this.movieStatus,
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
    movie,
    movieStatus,
  ];
}
