import 'dart:convert';
import 'package:client/data/model/movie_poster_preview_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class _PreferencesKey {
  static const accessToken = 'ACCESS_TOKEN_KEY';
  static const refreshToken = 'REFRESH_TOKEN_KEY';
  static const moviePreviews = 'MOVIE_PREVIEWS_KEY';
  static const deviceToken = 'DEVICE_TOKEN_KEY';
}

class Preferences {
  Preferences._();

  static final instance = Preferences._();

  late final SharedPreferences _myPref;

  Future<void> init() async {
    _myPref = await SharedPreferences.getInstance();
  }

  /// Save, get accessToken
  String get accessToken {
    return _myPref.getString(_PreferencesKey.accessToken) ?? '';
  }

  Future<bool> saveAccessToken(String token) {
    return _myPref.setString(_PreferencesKey.accessToken, token);
  }

  /// Save, get refreshToken
  String get refreshToken {
    return _myPref.getString(_PreferencesKey.refreshToken) ?? '';
  }

  Future<bool> saveRefreshToken(String token) {
    return _myPref.setString(_PreferencesKey.refreshToken, token);
  }

  /// Save, get movie posters
  Future<bool> saveAuthMoviePosters(List<MoviePosterPreviewModel> posters) {
    try {
      final jsonString = jsonEncode(posters.map((poster) => poster.toJson()).toList());
      return _myPref.setString(_PreferencesKey.moviePreviews, jsonString);
    } catch (e) {
      return Future.value(false);
    }
  }

  List<MoviePosterPreviewModel> getAuthMoviePosters() {
    try {
      final cachedJson = _myPref.getString(_PreferencesKey.moviePreviews);
      if (cachedJson != null && cachedJson.isNotEmpty) {
        final List<dynamic> jsonList = jsonDecode(cachedJson);
        return jsonList
            .map((json) => MoviePosterPreviewModel.fromJson(json as Map<String, dynamic>))
            .toList();
      }
      return [];
    } catch (e) {
      return [];
    }
  }

  /// Save, get device token
  Future<bool> saveDeviceToken(String token) {
    return _myPref.setString(_PreferencesKey.deviceToken, token);
  }

  String get deviceToken => _myPref.getString(_PreferencesKey.deviceToken) ?? '';

  /// Remove data
  Future<void> clearCurrentUserData() async {
    await Future.wait([
      _myPref.remove(_PreferencesKey.accessToken),
      _myPref.remove(_PreferencesKey.refreshToken),
      _myPref.remove(_PreferencesKey.deviceToken),
    ]);
  }

  Future<bool> clearAllData() async {
    return await _myPref.clear();
  }
}
