import '../enums/payment_status_enum.dart';

class PaymentModel {
  final String id;
  final BookingInfo booking;
  final String movieName;
  final String cinemaName;
  final String cinemaAddress;
  final String paymentMethod;
  final int totalAmount;
  final PaymentStatusEnum status;
  final String? transactionId;
  final String? paymentDate;
  final String? paymentUrl;
  final String createdAt;
  final ShowtimeInfo showtime;
  final List<TicketInfo> tickets;

  PaymentModel({
    required this.id,
    required this.booking,
    required this.movieName,
    required this.cinemaName,
    required this.cinemaAddress,
    required this.paymentMethod,
    required this.totalAmount,
    required this.status,
    required this.transactionId,
    required this.paymentDate,
    required this.paymentUrl,
    required this.createdAt,
    required this.showtime,
    required this.tickets,
  });

  factory PaymentModel.fromJson(Map<String, dynamic> json) => PaymentModel(
    id: json["id"],
    booking: BookingInfo.fromJson(json["booking"]),
    movieName: json["movieName"],
    cinemaName: json["cinemaName"],
    cinemaAddress: json["cinemaAddress"],
    paymentMethod: json["paymentMethod"],
    totalAmount: json["totalAmount"],
    status: PaymentStatusEnumX.fromKey(json["status"]),
    transactionId: json["transactionId"],
    paymentDate: json["paymentDate"],
    paymentUrl: json["paymentUrl"],
    createdAt: json["createdAt"],
    showtime: ShowtimeInfo.fromJson(json["showtime"]),
    tickets: List<TicketInfo>.from(json["tickets"].map((x) => TicketInfo.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "booking": booking.toJson(),
    "movieName": movieName,
    "cinemaName": cinemaName,
    "cinemaAddress": cinemaAddress,
    "paymentMethod": paymentMethod,
    "totalAmount": totalAmount,
    "status": status,
    "transactionId": transactionId,
    "paymentDate": paymentDate,
    "paymentUrl": paymentUrl,
    "createdAt": createdAt,
    "showtime": showtime.toJson(),
    "tickets": List<TicketInfo>.from(tickets.map((x) => x.toJson())),
  };
}

class BookingInfo {
  final String id;
  final String bookingCode;

  BookingInfo({
    required this.id,
    required this.bookingCode,
  });

  factory BookingInfo.fromJson(Map<String, dynamic> json) => BookingInfo(
    id: json["id"],
    bookingCode: json["bookingCode"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "bookingCode": bookingCode,
  };
}

class ShowtimeInfo {
  final String id;
  final String startTime;
  final String showDate;
  final String roomName;

  ShowtimeInfo({
    required this.id,
    required this.startTime,
    required this.showDate,
    required this.roomName,
  });

  factory ShowtimeInfo.fromJson(Map<String, dynamic> json) => ShowtimeInfo(
    id: json["id"],
    startTime: json["startTime"],
    showDate: json["showDate"],
    roomName: json["roomName"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "startTime": startTime,
    "showDate": showDate,
    "roomName": roomName,
  };
}

class TicketInfo {
  final String id;
  final String ticketCode;
  final int price;
  final String seatCode;

  TicketInfo({
    required this.id,
    required this.ticketCode,
    required this.price,
    required this.seatCode,
  });

  factory TicketInfo.fromJson(Map<String, dynamic> json) => TicketInfo(
    id: json["id"],
    ticketCode: json["ticketCode"],
    price: json["price"],
    seatCode: json["seatCode"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "ticketCode": ticketCode,
    "price": price,
    "seatCode": seatCode,
  };
}
