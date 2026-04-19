class MoviePosterPreviewModel {
  final String id;
  final String poster;

  MoviePosterPreviewModel({required this.id, required this.poster});

  factory MoviePosterPreviewModel.fromJson(Map<String, dynamic> json) =>
      MoviePosterPreviewModel(id: json["id"], poster: json["poster"]);

  Map<String, dynamic> toJson() => {"id": id, "poster": poster};
}
