class ShowtimeRequest {
  final String cinemaId;
  final String movieId;

  ShowtimeRequest({required this.cinemaId, required this.movieId});

  Map<String, String> toJson() => {'cinemaId': cinemaId, 'movieId': movieId};
}
