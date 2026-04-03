import 'package:client/data/enums/age_rating_enum.dart';

class MovieModel {
  String id;
  String title;
  String description;
  int duration;
  String releaseDate;
  String? endDate;
  String? poster;
  String director;
  String cast;
  String? trailer;
  String languages;
  String subtitles;
  String producer;
  String country;
  AgeRatingEnum ageRating;
  String format;
  double rating;
  int reviewCount;
  String status;
  List<GenreInfo> genres;

  MovieModel({
    required this.id,
    required this.title,
    required this.description,
    required this.duration,
    required this.releaseDate,
    required this.endDate,
    required this.poster,
    required this.director,
    required this.cast,
    required this.trailer,
    required this.languages,
    required this.subtitles,
    required this.producer,
    required this.country,
    required this.ageRating,
    required this.format,
    required this.rating,
    required this.reviewCount,
    required this.status,
    required this.genres,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) => MovieModel(
    id: json["id"],
    title: json["title"],
    description: json["description"],
    duration: json["duration"],
    releaseDate: json["releaseDate"],
    endDate: json["endDate"],
    poster: json["poster"],
    director: json["director"],
    cast: json["cast"],
    trailer: json["trailer"],
    languages: json["languages"],
    subtitles: json["subtitles"],
    producer: json["producer"],
    country: json["country"],
    ageRating: AgeRatingEnumX.fromKey(json["ageRating"]),
    format: json["format"],
    rating: (json["rating"] as num).toDouble(),
    reviewCount: json["reviewCount"],
    status: json["status"],
    genres: List<GenreInfo>.from(json["genres"].map((x) => GenreInfo.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "description": description,
    "duration": duration,
    "releaseDate": releaseDate,
    "endDate": endDate,
    "poster": poster,
    "director": director,
    "cast": cast,
    "trailer": trailer,
    "languages": languages,
    "subtitles": subtitles,
    "producer": producer,
    "country": country,
    "ageRating": ageRating,
    "format": format,
    "rating": rating,
    "reviewCount": reviewCount,
    "status": status,
    "genres": List<dynamic>.from(genres.map((x) => x.toJson())),
  };
}

class GenreInfo {
  String id;
  String name;

  GenreInfo({required this.id, required this.name});

  factory GenreInfo.fromJson(Map<String, dynamic> json) =>
      GenreInfo(id: json["id"], name: json["name"]);

  Map<String, dynamic> toJson() => {"id": id, "name": name};
}
