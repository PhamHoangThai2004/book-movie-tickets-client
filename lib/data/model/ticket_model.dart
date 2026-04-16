import '../enums/age_rating_enum.dart';
import '../enums/seat_type_enum.dart';
import '../enums/ticket_status_enum.dart';

class TicketModel {
  final String id;
  final String ticketCode;
  final int price;
  final TicketStatusEnum status;
  final String expiredAt;
  final String createdAt;
  final SeatInfo seat;
  final MovieInfo movie;
  final ShowtimeInfo showtime;
  final RoomInfo room;
  final CinemaInfo cinema;

  TicketModel({
    required this.id,
    required this.ticketCode,
    required this.price,
    required this.status,
    required this.expiredAt,
    required this.createdAt,
    required this.seat,
    required this.movie,
    required this.showtime,
    required this.room,
    required this.cinema,
  });

  factory TicketModel.fromJson(Map<String, dynamic> json) => TicketModel(
    id: json["id"],
    ticketCode: json["ticketCode"],
    price: json["price"],
    status: TicketStatusEnumX.fromKey(json["status"]),
    expiredAt: json["expiredAt"],
    createdAt: json["createdAt"],
    seat: SeatInfo.fromJson(json["seat"]),
    movie: MovieInfo.fromJson(json["movie"]),
    showtime: ShowtimeInfo.fromJson(json["showtime"]),
    room: RoomInfo.fromJson(json["room"]),
    cinema: CinemaInfo.fromJson(json["cinema"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "ticketCode": ticketCode,
    "price": price,
    "status": status,
    "expiredAt": expiredAt,
    "createdAt": createdAt,
    "seat": seat.toJson(),
    "movie": movie.toJson(),
    "showtime": showtime.toJson(),
    "room": room.toJson(),
    "cinema": cinema.toJson(),
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
  final int duration;
  final AgeRatingEnum ageRating;
  final String? poster;

  MovieInfo({
    required this.id,
    required this.title,
    required this.duration,
    required this.ageRating,
    required this.poster,
  });

  factory MovieInfo.fromJson(Map<String, dynamic> json) => MovieInfo(
    id: json["id"],
    title: json["title"],
    duration: json["duration"],
    ageRating: AgeRatingEnumX.fromKey(json["ageRating"]),
    poster: json["poster"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "duration": duration,
    "ageRating": ageRating,
    "poster": poster,
  };
}

class RoomInfo {
  final String id;
  final String name;

  RoomInfo({required this.id, required this.name});

  factory RoomInfo.fromJson(Map<String, dynamic> json) =>
      RoomInfo(id: json["id"], name: json["name"]);

  Map<String, dynamic> toJson() => {"id": id, "name": name};
}

class SeatInfo {
  final String id;
  final String seatCode;
  final SeatTypeEnum seatType;

  SeatInfo({required this.id, required this.seatCode, required this.seatType});

  factory SeatInfo.fromJson(Map<String, dynamic> json) => SeatInfo(
    id: json["id"],
    seatCode: json["seatCode"],
    seatType: SeatTypeEnumX.fromKey(json["seatType"]),
  );

  Map<String, dynamic> toJson() => {"id": id, "seatCode": seatCode, "seatType": seatType};
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
