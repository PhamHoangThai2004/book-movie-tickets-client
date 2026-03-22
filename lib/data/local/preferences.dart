import 'package:shared_preferences/shared_preferences.dart';

class _PreferencesKey {
  static const accessToken = 'ACCESS_TOKEN_KEY';
  static const refreshToken = 'REFRESH_TOKEN_KEY';
}

class Preferences {
  Preferences._();

  static final instance = Preferences._();

  late final SharedPreferences _myPref;

  Future<void> init() async {
    _myPref = await SharedPreferences.getInstance();
  }

  /// Save accessToken
  String get accessToken {
    return _myPref.getString(_PreferencesKey.accessToken) ?? '';
  }

  Future<bool> saveAccessToken(String token) {
    return _myPref.setString(_PreferencesKey.accessToken, token);
  }

  /// Save refreshToken
  String get refreshToken {
    return _myPref.getString(_PreferencesKey.refreshToken) ?? '';
  }

  Future<bool> saveRefreshToken(String token) {
    return _myPref.setString(_PreferencesKey.refreshToken, token);
  }
}
