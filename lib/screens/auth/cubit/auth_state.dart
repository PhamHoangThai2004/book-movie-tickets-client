part of 'auth_cubit.dart';

class AuthState {
  final List<MoviePosterPreviewModel> movies;
  final MovieModel? movie;
  final StatusEnum status;
  final String errorMessage;

  AuthState({
    this.movies = const [],
    this.movie,
    this.status = StatusEnum.initial,
    this.errorMessage = '',
  });

  AuthState copyWith({
    List<MoviePosterPreviewModel>? movies,
    MovieModel? movie,
    StatusEnum? status,
    String? errorMessage,
  }) {
    return AuthState(
      movies: movies ?? this.movies,
      movie: movie ?? this.movie,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
