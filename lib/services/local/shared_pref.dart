import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static const String checkAccessKey = 'checkAccessKey';
  static const String themeKey = 'themeKey';
  static const String languageKey = 'languageKey';

  static late SharedPreferences _prefs;

  static Future<void> initialization() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static bool get isAccessed {
    return _prefs.getBool(checkAccessKey) ?? false;
  }

  static set isAccessed(bool value) => _prefs.setBool(checkAccessKey, value);

  static bool get isDark {
    return _prefs.getBool(themeKey) ?? false;
  }

  static set isDark(bool value) => _prefs.setBool(themeKey, value);

  static bool get isVietnamese {
    return _prefs.getBool(languageKey) ?? false;
  }

  static set isVietnamese(bool value) => _prefs.setBool(languageKey, value);
}
