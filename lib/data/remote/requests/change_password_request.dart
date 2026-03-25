class ChangePasswordRequest {
  final String oldPassword;
  final String newPassword;

  ChangePasswordRequest({required this.oldPassword, required this.newPassword});

  Map<String, String> toJson() => {
    'oldPassword': oldPassword,
    'newPassword': newPassword,
  };
}

