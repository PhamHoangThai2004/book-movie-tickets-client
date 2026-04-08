class ShowtimeRequest {
  final String cinemaId;
  final String movieId;
  final String? date;
  final int page;
  final int size;

  ShowtimeRequest({
    required this.cinemaId,
    required this.movieId,
    this.date,
    this.page = 1,
    this.size = 10,
  });

  Map<String, dynamic> toJson() => {
    'cinemaId': cinemaId,
    'movieId': movieId,
    if (date != null) 'date': date,
    'page': page,
    'size': size,
  };
}
