import '../enums/movie_status_enum.dart';

class MoviePreviewModel {
  String id;
  String title;
  int duration;
  String releaseDate;
  String? poster;
  double rating;
  int reviewCount;
  MovieStatusEnum status;
  List<GenreName> genres;

  MoviePreviewModel({
    required this.id,
    required this.title,
    required this.duration,
    required this.releaseDate,
    required this.poster,
    required this.rating,
    required this.reviewCount,
    required this.status,
    required this.genres,
  });

  factory MoviePreviewModel.fromJson(Map<String, dynamic> json) => MoviePreviewModel(
    id: json["id"],
    title: json["title"],
    duration: json["duration"],
    releaseDate: json["releaseDate"],
    poster: json["poster"],
    rating: (json["rating"] as num).toDouble(),
    reviewCount: json["reviewCount"],
    status: MovieStatusEnumX.fromKey(json["status"]),
    genres: List<GenreName>.from(json["genres"].map((x) => GenreName.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "duration": duration,
    "releaseDate": releaseDate,
    "poster": poster,
    "rating": rating,
    "reviewCount": reviewCount,
    "status": status,
    "genres": List<dynamic>.from(genres.map((x) => x.toJson())),
  };
}

class GenreName {
  String name;

  GenreName({required this.name});

  factory GenreName.fromJson(Map<String, dynamic> json) => GenreName(name: json["name"]);

  Map<String, dynamic> toJson() => {"name": name};
}
