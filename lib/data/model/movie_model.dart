class MovieModel {
  final String title;
  final String posterUrl;
  final double? rating;
  final int? voteCount;
  final String? duration;
  final List<String> genres;
  final String? releaseDate;
  final bool isNowPlaying;

  MovieModel({
    required this.title,
    required this.posterUrl,
    this.rating,
    this.voteCount,
    this.duration,
    required this.genres,
    this.releaseDate,
    this.isNowPlaying = true,
  });
}
