part of 'movie_detail_cubit.dart';

class MovieDetailState {
  final List<CinemaModel> cinemas;
  final StatusEnum cinemasStatus;
  final String errorMessage;
  final String? selectedCinemaId;
  final bool isPlaying;
  final StatusEnum reviewsStatus;
  final PaginationResponse<ReviewModel>? reviews;
  final StatusEnum submitReviewStatus;
  final int rating;
  final String comment;

  const MovieDetailState({
    this.cinemas = const [],
    this.cinemasStatus = StatusEnum.initial,
    this.errorMessage = '',
    this.selectedCinemaId,
    this.isPlaying = false,
    this.reviewsStatus = StatusEnum.initial,
    this.reviews,
    this.submitReviewStatus = StatusEnum.initial,
    this.rating = 0,
    this.comment = '',
  });

  bool get isValid => rating > 0 && rating <= 10 && comment.isNotEmpty;

  MovieDetailState copyWith({
    List<CinemaModel>? cinemas,
    StatusEnum? cinemasStatus,
    String? errorMessage,
    String? selectedCinemaId,
    bool? isPlaying,
    StatusEnum? reviewsStatus,
    PaginationResponse<ReviewModel>? reviews,
    StatusEnum? submitReviewStatus,
    int? rating,
    String? comment,
  }) {
    return MovieDetailState(
      cinemas: cinemas ?? this.cinemas,
      cinemasStatus: cinemasStatus ?? this.cinemasStatus,
      errorMessage: errorMessage ?? this.errorMessage,
      selectedCinemaId: selectedCinemaId ?? this.selectedCinemaId,
      isPlaying: isPlaying ?? this.isPlaying,
      reviewsStatus: reviewsStatus ?? this.reviewsStatus,
      reviews: reviews ?? this.reviews,
      submitReviewStatus: submitReviewStatus ?? this.submitReviewStatus,
      rating: rating ?? this.rating,
      comment: comment ?? this.comment,
    );
  }
}
