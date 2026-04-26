class MoviePreviewRequest {
  final String? search;
  final String? genre;
  final String? status;
  final int page;
  final int size;

  MoviePreviewRequest({
    this.search,
    this.genre,
    this.status,
    required this.page,
    required this.size,
  });

  Map<String, dynamic> toJson() => {
    'page': page,
    'size': size,
    if (search != null) 'search': search,
    if (genre != null) 'genre': genre,
    if (status != null) 'status': status,
  };
}
