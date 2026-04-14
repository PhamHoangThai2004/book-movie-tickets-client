import 'package:client/data/enums/payment_status_enum.dart';

class PaymentPreviewModel {
  final String id;
  final String bookingId;
  final String paymentMethod;
  final int totalAmount;
  final PaymentStatusEnum status;
  final String? transactionId;
  final String? paymentDate;
  final dynamic paymentUrl;
  final String createdAt;

  PaymentPreviewModel({
    required this.id,
    required this.bookingId,
    required this.paymentMethod,
    required this.totalAmount,
    required this.status,
    required this.transactionId,
    required this.paymentDate,
    required this.paymentUrl,
    required this.createdAt,
  });

  factory PaymentPreviewModel.fromJson(Map<String, dynamic> json) => PaymentPreviewModel(
    id: json["id"],
    bookingId: json["bookingId"],
    paymentMethod: json["paymentMethod"],
    totalAmount: json["totalAmount"],
    status: PaymentStatusEnumX.fromKey(json["status"]),
    transactionId: json["transactionId"],
    paymentDate: json["paymentDate"],
    paymentUrl: json["paymentUrl"],
    createdAt: json["createdAt"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "bookingId": bookingId,
    "paymentMethod": paymentMethod,
    "totalAmount": totalAmount,
    "status": status,
    "transactionId": transactionId,
    "paymentDate": paymentDate,
    "paymentUrl": paymentUrl,
    "createdAt": createdAt,
  };
}
