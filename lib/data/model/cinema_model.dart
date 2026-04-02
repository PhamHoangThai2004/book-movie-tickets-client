class CinemaModel {
  String id;
  String name;
  String address;

  CinemaModel({required this.id, required this.name, required this.address});

  factory CinemaModel.fromJson(Map<String, dynamic> json) =>
      CinemaModel(id: json["id"], name: json["name"], address: json["address"]);

  Map<String, dynamic> toJson() => {"id": id, "name": name, "address": address};
}
