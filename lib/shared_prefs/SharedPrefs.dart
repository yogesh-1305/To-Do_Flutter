import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static Future<void> saveUserEmailAndPassword(
      String mail, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('mail', mail);
    prefs.setString('password', password);
  }

  static Future<String?> getMail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('mail');
  }

  static Future<String?> getPassword() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('password');
  }

  static Future<void> saveGuestUser(bool isGuestUser) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('guest', isGuestUser);
  }

  static Future<bool?> getGuestUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('guest');
  }
}
