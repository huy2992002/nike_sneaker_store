import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefServices {
  SharedPrefServices({required this.sharedPreferences});

  final Future<SharedPreferences> sharedPreferences;

  final String accessTokenKey = 'accessTokenKey';
  final String refreshTokenKey = 'refreshTokenKey';

  Future<void> saveAccessToken(String accessToken) async {
    final _pref = await sharedPreferences;
    _pref.setString(accessTokenKey, accessToken);
  }

  Future<String?> getAccessToken() async {
    final _pref = await sharedPreferences;
    return _pref.getString(accessTokenKey);
  }

  Future<void> saveRefreshToken(String refreshToken) async {
    final _pref = await sharedPreferences;
    _pref.setString(refreshTokenKey, refreshToken);
  }

  Future<String?> getRefreshToken() async {
    final _pref = await sharedPreferences;
    return _pref.getString(refreshTokenKey);
  }

  Future<void> removeToken() async {
    final _pref = await sharedPreferences;
    _pref
      ..remove(accessTokenKey)
      ..remove(refreshTokenKey);
  }
}
