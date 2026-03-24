class UpdateProfileRequest {
  final String phoneNumber;
  final String name;
  final String dateOfBirth;
  final String gender;

  UpdateProfileRequest({
    required this.phoneNumber,
    required this.name,
    required this.dateOfBirth,
    required this.gender,
  });

  Map<String, String> toJson() => {
    'phoneNumber': phoneNumber,
    'name': name,
    'dateOfBirth': dateOfBirth,
    'gender': gender,
  };
}
