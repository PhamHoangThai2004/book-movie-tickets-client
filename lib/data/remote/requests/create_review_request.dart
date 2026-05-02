class CreateReviewRequest {
  final String movieId;
  final int rating;
  final String comment;

  CreateReviewRequest({required this.movieId, required this.rating, required this.comment});

  Map<String, dynamic> toJson() => {'movieId': movieId, 'rating': rating, 'comment': comment};
}
