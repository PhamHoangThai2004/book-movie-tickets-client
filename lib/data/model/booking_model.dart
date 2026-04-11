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
  final List<TicketInfo> tickets;

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
    required this.tickets,
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
    tickets: List<TicketInfo>.from(json["tickets"].map((x) => TicketInfo.fromJson(x))),
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
    "tickets": List<dynamic>.from(tickets.map((x) => x.toJson())),
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
  final String poster;
  final List<GenreInfo> genres;

  MovieInfo({required this.id, required this.title, required this.poster, required this.genres});

  factory MovieInfo.fromJson(Map<String, dynamic> json) => MovieInfo(
    id: json["id"],
    title: json["title"],
    poster: json["poster"],
    genres: List<GenreInfo>.from(json["genres"].map((x) => GenreInfo.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "poster": poster,
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

class TicketInfo {
  final String id;
  final String ticketCode;
  final int price;
  final String expiredAt;
  final String status;
  final String seatCode;

  TicketInfo({
    required this.id,
    required this.ticketCode,
    required this.price,
    required this.expiredAt,
    required this.status,
    required this.seatCode,
  });

  factory TicketInfo.fromJson(Map<String, dynamic> json) => TicketInfo(
    id: json["id"],
    ticketCode: json["ticketCode"],
    price: json["price"],
    expiredAt: json["expiredAt"],
    status: json["status"],
    seatCode: json["seatCode"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "ticketCode": ticketCode,
    "price": price,
    "expiredAt": expiredAt,
    "status": status,
    "seatCode": seatCode,
  };
}
