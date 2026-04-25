import '../enums/notification_type_enum.dart';

class NotificationModel {
  final String id;
  final String title;
  final String content;
  final NotificationTypeEnum notificationType;
  final String keyId;
  final String createdAt;
  final String sentAt;
  final String? seenAt;

  NotificationModel({
    required this.id,
    required this.title,
    required this.content,
    required this.notificationType,
    required this.keyId,
    required this.createdAt,
    required this.sentAt,
    required this.seenAt,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) => NotificationModel(
    id: json["id"],
    title: json["title"],
    content: json["content"],
    notificationType: NotificationTypeEnumX.fromKey(json["notificationType"]),
    keyId: json["keyId"],
    createdAt: json["createdAt"],
    sentAt: json["sentAt"],
    seenAt: _parseNullableString(json["seenAt"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "content": content,
    "notificationType": notificationType,
    "keyId": keyId,
    "createdAt": createdAt,
    "sentAt": sentAt,
    "seenAt": seenAt,
  };

  static String? _parseNullableString(dynamic value) {
    if (value == null || value.toString().trim().isEmpty) return null;
    return value.toString();
  }
}
