class Validator {
  static const emailRegex = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
  static const passwordRegex = r'^(?=.*[!@#$%^&*(),.?":{}|<>])[A-Za-z\d!@#$%^&*(),.?":{}|<>]{8,}$';
  static const nameRegex = r'^[a-zA-ZÀ-ỹ\s]+$';
  static const phoneNumberRegex = r'^0(3|5|7|8|9)[0-9]{8}$';

  static bool isValidEmail(String email) {
    final emailRegExp = RegExp(emailRegex);
    return emailRegExp.hasMatch(email);
  }

  static bool isValidPassword(String password) {
    final passwordRegExp = RegExp(passwordRegex);
    return passwordRegExp.hasMatch(password);
  }

  static bool isValidName(String name) {
    final nameRegExp = RegExp(nameRegex);
    return nameRegExp.hasMatch(name);
  }

  static bool isValidPhoneNumber(String phoneNumber) {
    final phoneNumberRegExp = RegExp(phoneNumberRegex);
    return phoneNumberRegExp.hasMatch(phoneNumber);
  }
}
