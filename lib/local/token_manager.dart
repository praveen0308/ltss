import 'package:shared_preferences/shared_preferences.dart';

class TokenManager {
  static Future<void> saveToken(SharedPreferences prefs,String token) async {
    await prefs.setString("auth_token", token);
  }

  static String getToken(SharedPreferences prefs){
    return prefs.getString("auth_token") ?? "";
  }
}
