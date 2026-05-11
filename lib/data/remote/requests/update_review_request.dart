class UpdateReviewRequest {
  final int rating;
  final String comment;

  UpdateReviewRequest({required this.rating, required this.comment});

  Map<String, dynamic> toJson() => {'rating': rating, 'comment': comment};
}
