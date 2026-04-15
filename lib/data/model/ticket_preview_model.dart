import 'package:client/data/enums/ticket_status_enum.dart';

class TicketPreviewModel {
  final String id;
  final TicketStatusEnum status;
  final String movieTitle;
  final String expiredAt;
  final String? moviePoster;
  final String cinemaName;
  final String showtimeStart;
  final String showtimeShowDate;
  final String createdAt;

  TicketPreviewModel({
    required this.id,
    required this.status,
    required this.movieTitle,
    required this.expiredAt,
    required this.moviePoster,
    required this.cinemaName,
    required this.showtimeStart,
    required this.showtimeShowDate,
    required this.createdAt,
  });

  factory TicketPreviewModel.fromJson(Map<String, dynamic> json) => TicketPreviewModel(
    id: json["id"],
    status: TicketStatusEnumX.fromKey(json["status"]),
    movieTitle: json["movieTitle"],
    expiredAt: json["expiredAt"],
    moviePoster: json["moviePoster"],
    cinemaName: json["cinemaName"],
    showtimeStart: json["showtimeStart"],
    showtimeShowDate: json["showtimeShowDate"],
    createdAt: json["createdAt"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "status": status,
    "movieTitle": movieTitle,
    "expiredAt": expiredAt,
    "moviePoster": moviePoster,
    "cinemaName": cinemaName,
    "showtimeStart": showtimeStart,
    "showtimeShowDate": showtimeShowDate,
    "createdAt": createdAt,
  };
}
