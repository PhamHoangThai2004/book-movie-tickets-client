class LoginModel {
  String accessToken;
  UserInfo user;
  String refreshToken;

  LoginModel({required this.accessToken, required this.user, required this.refreshToken});

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
    accessToken: json["accessToken"],
    user: UserInfo.fromJson(json["user"]),
    refreshToken: json["refreshToken"],
  );

  Map<String, dynamic> toJson() => {
    "accessToken": accessToken,
    "user": user.toJson(),
    "refreshToken": refreshToken,
  };
}

class UserInfo {
  String id;
  String email;
  String name;
  String role;

  UserInfo({required this.id, required this.email, required this.name, required this.role});

  factory UserInfo.fromJson(Map<String, dynamic> json) =>
      UserInfo(id: json["id"], email: json["email"], name: json["name"], role: json["role"]);

  Map<String, dynamic> toJson() => {"id": id, "email": email, "name": name, "role": role};
}
