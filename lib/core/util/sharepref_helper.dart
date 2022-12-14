import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceHelper {
  static Future<bool> setString(String key, String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(key, value);
  }

  static Future<String?> getString(
    String key,
  ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.getString(key);
  }

  static Future<bool> clear() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.clear();
  }
}
