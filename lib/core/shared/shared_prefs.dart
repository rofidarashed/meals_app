import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static SharedPreferences? sharedPreferences;

  static Future init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static setBool({required String key, required bool value}) {
    return sharedPreferences?.setBool(key, value);
  }

  static getBool({required String key}) {
    return sharedPreferences?.getBool(key);
  }
}
