import '../enums/seat_status_enum.dart';
import '../enums/seat_type_enum.dart';
import '../enums/showtime_format_enum.dart';
import '../enums/showtime_status_enum.dart';

class ShowtimeModel {
  final String id;
  final String startTime;
  final String endTime;
  final int price;
  final String showDate;
  final String? subtitle;
  final ShowtimeFormatEnum format;
  final ShowtimeStatusEnum status;
  final List<Seat> seats;

  ShowtimeModel({
    required this.id,
    required this.startTime,
    required this.endTime,
    required this.price,
    required this.showDate,
    required this.subtitle,
    required this.format,
    required this.status,
    required this.seats,
  });

  ShowtimeModel copyWith({
    String? id,
    String? startTime,
    String? endTime,
    int? price,
    String? showDate,
    String? subtitle,
    ShowtimeFormatEnum? format,
    ShowtimeStatusEnum? status,
    List<Seat>? seats,
  }) {
    return ShowtimeModel(
      id: id ?? this.id,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      price: price ?? this.price,
      showDate: showDate ?? this.showDate,
      subtitle: subtitle ?? this.subtitle,
      format: format ?? this.format,
      status: status ?? this.status,
      seats: seats ?? this.seats,
    );
  }

  factory ShowtimeModel.fromJson(Map<String, dynamic> json) => ShowtimeModel(
    id: json["id"],
    startTime: json["startTime"],
    endTime: json["endTime"],
    price: json["price"],
    showDate: json["showDate"],
    subtitle: json["subtitle"],
    format: ShowtimeFormatEnumX.fromKey(json["format"]),
    status: ShowtimeStatusEnumX.fromKey(json["status"]),
    seats: List<Seat>.from(json["seats"].map((x) => Seat.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "startTime": startTime,
    "endTime": endTime,
    "price": price,
    "showDate": showDate,
    "subtitle": subtitle,
    "format": format,
    "status": status,
    "seats": List<dynamic>.from(seats.map((x) => x.toJson())),
  };
}

class Seat {
  final String id;
  final String seatCode;
  final SeatTypeEnum seatType;
  final int price;
  final SeatStatusEnum status;

  Seat({
    required this.id,
    required this.seatCode,
    required this.seatType,
    required this.price,
    required this.status,
  });

  Seat copyWith({
    String? id,
    String? seatCode,
    SeatTypeEnum? seatType,
    int? price,
    SeatStatusEnum? status,
  }) {
    return Seat(
      id: id ?? this.id,
      seatCode: seatCode ?? this.seatCode,
      seatType: seatType ?? this.seatType,
      price: price ?? this.price,
      status: status ?? this.status,
    );
  }

  factory Seat.fromJson(Map<String, dynamic> json) => Seat(
    id: json["id"],
    seatCode: json["seatCode"],
    seatType: SeatTypeEnumX.fromKey(json["seatType"]),
    price: json["price"],
    status: SeatStatusEnumX.fromKey(json["status"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "seatCode": seatCode,
    "seatType": seatType,
    "price": price,
    "status": status,
  };
}
