class MoviePosterPreviewModel {
  final String id;
  final String title;
  final String description;
  final String poster;

  MoviePosterPreviewModel({
    required this.id,
    required this.poster,
    required this.title,
    required this.description,
  });

  factory MoviePosterPreviewModel.fromJson(Map<String, dynamic> json) => MoviePosterPreviewModel(
    id: json["id"],
    poster: json["poster"],
    title: json["title"],
    description: json["description"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "poster": poster,
    "title": title,
    "description": description,
  };
}
