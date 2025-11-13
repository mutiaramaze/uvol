import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uvol/model/user_model.dart';

class PreferenceHandler {
  static const String isLogin = "isLogin";
  static const String userKey = "userData";

  // Simpan status login
  static Future<void> saveLogin(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(isLogin, value);
  }

  // Ambil status login
  static Future<bool> getLogin() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(isLogin) ?? false;
  }

  // Simpan data user (dalam JSON)
  static Future<void> saveUser(UserModel user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(userKey, user.toJson());
  }

  // Ambil data user dari penyimpanan
  static Future<UserModel?> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(userKey);
    if (jsonString == null) return null;
    return UserModel.fromJson(jsonString);
  }

  // Hapus data login dan user (logout)
  static Future<void> removeLogin() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(isLogin);
    await prefs.remove(userKey);
  }
}
