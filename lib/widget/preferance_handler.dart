import 'package:shared_preferences/shared_preferences.dart';

class PreferanceHandler {
  static const String isLogin = "isLogin";

  // save login saat login
  static saveLogin(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(isLogin, value);
  }

  // ambil data saat mau login
  static getlogin() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(isLogin);
  }

  // hapus data saat logout
  static removeLogin() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(isLogin);
  }
}
