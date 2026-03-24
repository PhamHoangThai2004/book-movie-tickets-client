class UserModel {
  String id;
  String email;
  String? phoneNumber;
  String name;
  String? avatar;
  String? dateOfBirth;
  String gender;
  bool isVerified;
  bool isLocked;
  bool isDeleted;
  String createdAt;

  UserModel({
    required this.id,
    required this.email,
    required this.phoneNumber,
    required this.name,
    required this.avatar,
    required this.dateOfBirth,
    required this.gender,
    required this.isVerified,
    required this.isLocked,
    required this.isDeleted,
    required this.createdAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json["id"],
    email: json["email"],
    phoneNumber: json["phoneNumber"],
    name: json["name"],
    avatar: json["avatar"],
    dateOfBirth: json["dateOfBirth"],
    gender: json["gender"],
    isVerified: json["isVerified"],
    isLocked: json["isLocked"],
    isDeleted: json["isDeleted"],
    createdAt: json["createdAt"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "email": email,
    "phoneNumber": phoneNumber,
    "name": name,
    "avatar": avatar,
    "dateOfBirth": dateOfBirth,
    "gender": gender,
    "isVerified": isVerified,
    "isLocked": isLocked,
    "isDeleted": isDeleted,
    "createdAt": createdAt,
  };
}
