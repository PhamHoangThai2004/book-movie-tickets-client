part of 'movie_detail_cubit.dart';

class MovieDetailState {
  final List<CinemaModel> cinemas;
  final StatusEnum cinemasStatus;
  final String errorMessage;
  final String? selectedCinemaId;
  final bool isPlaying;

  const MovieDetailState({
    this.cinemas = const [],
    this.cinemasStatus = StatusEnum.initial,
    this.errorMessage = '',
    this.selectedCinemaId,
    this.isPlaying = false,
  });

  MovieDetailState copyWith({
    List<CinemaModel>? cinemas,
    StatusEnum? cinemasStatus,
    String? errorMessage,
    String? selectedCinemaId,
    bool? isPlaying,
  }) {
    return MovieDetailState(
      cinemas: cinemas ?? this.cinemas,
      cinemasStatus: cinemasStatus ?? this.cinemasStatus,
      errorMessage: errorMessage ?? this.errorMessage,
      selectedCinemaId: selectedCinemaId ?? this.selectedCinemaId,
      isPlaying: isPlaying ?? this.isPlaying,
    );
  }
}
