class ReviewModel {
  final String id;
  final int rating;
  final String comment;
  final String createdAt;
  final String updatedAt;
  final UserInfo user;

  ReviewModel({
    required this.id,
    required this.rating,
    required this.comment,
    required this.createdAt,
    required this.updatedAt,
    required this.user,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) => ReviewModel(
    id: json["id"],
    rating: json["rating"],
    comment: json["comment"],
    createdAt: json["createdAt"],
    updatedAt: json["updatedAt"],
    user: UserInfo.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "rating": rating,
    "comment": comment,
    "createdAt": createdAt,
    "updatedAt": updatedAt,
    "user": user.toJson(),
  };
}

class UserInfo {
  final String id;
  final String name;
  final String? avatar;

  UserInfo({required this.id, required this.name, required this.avatar});

  factory UserInfo.fromJson(Map<String, dynamic> json) =>
      UserInfo(id: json["id"], name: json["name"], avatar: json["avatar"]);

  Map<String, dynamic> toJson() => {"id": id, "name": name, "avatar": avatar};
}
