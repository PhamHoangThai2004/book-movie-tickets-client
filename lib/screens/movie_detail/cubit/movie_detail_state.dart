part of 'movie_detail_cubit.dart';

class MovieDetailState {
  final List<CinemaModel> cinemas;
  final StatusEnum cinemasStatus;
  final String errorMessage;

  const MovieDetailState({
    this.cinemas = const [],
    this.cinemasStatus = StatusEnum.initial,
    this.errorMessage = '',
  });

  MovieDetailState copyWith({
    List<CinemaModel>? cinemas,
    StatusEnum? cinemasStatus,
    String? errorMessage,
  }) {
    return MovieDetailState(
      cinemas: cinemas ?? this.cinemas,
      cinemasStatus: cinemasStatus ?? this.cinemasStatus,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
