class BookingModel {
  final String id;
  final String bookingCode;
  final int totalAmount;
  final String status;
  final String createdAt;
  final String updatedAt;
  final MovieInfo movie;
  final ShowtimeInfo showtime;
  final CinemaInfo cinema;
  final List<SeatBookings> seatBookings;

  BookingModel({
    required this.id,
    required this.bookingCode,
    required this.totalAmount,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.movie,
    required this.showtime,
    required this.cinema,
    required this.seatBookings,
  });

  factory BookingModel.fromJson(Map<String, dynamic> json) => BookingModel(
    id: json["id"],
    bookingCode: json["bookingCode"],
    totalAmount: json["totalAmount"],
    status: json["status"],
    createdAt: json["createdAt"],
    updatedAt: json["updatedAt"],
    movie: MovieInfo.fromJson(json["movie"]),
    showtime: ShowtimeInfo.fromJson(json["showtime"]),
    cinema: CinemaInfo.fromJson(json["cinema"]),
    seatBookings: List<SeatBookings>.from(json["seatBookings"].map((x) => SeatBookings.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "bookingCode": bookingCode,
    "totalAmount": totalAmount,
    "status": status,
    "createdAt": createdAt,
    "updatedAt": updatedAt,
    "movie": movie.toJson(),
    "showtime": showtime.toJson(),
    "cinema": cinema.toJson(),
    "seatBookings": List<dynamic>.from(seatBookings.map((x) => x.toJson())),
  };
}

class CinemaInfo {
  final String id;
  final String name;
  final String address;

  CinemaInfo({required this.id, required this.name, required this.address});

  factory CinemaInfo.fromJson(Map<String, dynamic> json) =>
      CinemaInfo(id: json["id"], name: json["name"], address: json["address"]);

  Map<String, dynamic> toJson() => {"id": id, "name": name, "address": address};
}

class MovieInfo {
  final String id;
  final String title;
  final String? poster;
  final int duration;
  final List<GenreInfo> genres;

  MovieInfo({
    required this.id,
    required this.title,
    required this.poster,
    required this.genres,
    required this.duration,
  });

  factory MovieInfo.fromJson(Map<String, dynamic> json) => MovieInfo(
    id: json["id"],
    title: json["title"],
    poster: json["poster"],
    duration: json["duration"],
    genres: List<GenreInfo>.from(json["genres"].map((x) => GenreInfo.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "poster": poster,
    "duration": duration,
    "genres": List<dynamic>.from(genres.map((x) => x.toJson())),
  };
}

class GenreInfo {
  final String id;
  final String name;

  GenreInfo({required this.id, required this.name});

  factory GenreInfo.fromJson(Map<String, dynamic> json) =>
      GenreInfo(id: json["id"], name: json["name"]);

  Map<String, dynamic> toJson() => {"id": id, "name": name};
}

class ShowtimeInfo {
  final String id;
  final String startTime;
  final String showDate;

  ShowtimeInfo({required this.id, required this.startTime, required this.showDate});

  factory ShowtimeInfo.fromJson(Map<String, dynamic> json) =>
      ShowtimeInfo(id: json["id"], startTime: json["startTime"], showDate: json["showDate"]);

  Map<String, dynamic> toJson() => {"id": id, "startTime": startTime, "showDate": showDate};
}

class SeatBookings {
  final String id;
  final int price;
  final String holdExpiredAt;
  final String seatCode;

  SeatBookings({
    required this.id,
    required this.price,
    required this.holdExpiredAt,
    required this.seatCode,
  });

  factory SeatBookings.fromJson(Map<String, dynamic> json) => SeatBookings(
    id: json["id"],
    price: json["price"],
    holdExpiredAt: json["holdExpiredAt"],
    seatCode: json["seatCode"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "price": price,
    "holdExpiredAt": holdExpiredAt,
    "seatCode": seatCode,
  };
}
