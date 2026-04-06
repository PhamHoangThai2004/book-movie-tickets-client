import '../enums/showtime_format_enum.dart';
import '../enums/showtime_status_enum.dart';

class ShowtimePreviewModel {
  String id;
  String startTime;
  String endTime;
  String showDate;
  String? subtitle;
  ShowtimeFormatEnum format;
  ShowtimeStatusEnum status;

  ShowtimePreviewModel({
    required this.id,
    required this.startTime,
    required this.endTime,
    required this.showDate,
    required this.subtitle,
    required this.format,
    required this.status,
  });

  factory ShowtimePreviewModel.fromJson(Map<String, dynamic> json) => ShowtimePreviewModel(
    id: json["id"],
    startTime: json["startTime"],
    endTime: json["endTime"],
    showDate: json["showDate"],
    subtitle: json["subtitle"],
    format: ShowtimeFormatEnumX.fromKey(json["format"]),
    status: ShowtimeStatusEnumX.fromKey(json["status"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "startTime": startTime,
    "endTime": endTime,
    "showDate": showDate,
    "subtitle": subtitle,
    "format": format,
    "status": status,
  };
}
