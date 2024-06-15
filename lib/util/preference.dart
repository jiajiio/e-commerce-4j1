import 'package:shared_preferences/shared_preferences.dart';

class Preference {
  static Future<String> getPreferenceEmail() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString('email') ?? '';
  }

  static getPreferencePassword() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString('password') ?? '';
  }

  static setPreference({
    required String email,
    required String password,
  }) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString('email', email);
    sharedPreferences.setString('password', password);
  }
}
