import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:uvol/dummy/detail_events.dart';

class PreferenceHandler {
  static const String isLogin = "isLogin";
  static const String isId = "isId";
  static const String storedEvents = "registered_events";

  //Save data login pada saat login
  static saveLogin(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(isLogin, value);
  }

  //Save data user ID saat login
  static Future<void> saveUserId(int id) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt("isId", id);
  }

  //Ambil data user ID saat login
  static Future<int?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt("isId");
  }

  //Ambil data login pada saat mau login / ke dashboard
  static getLogin() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(isLogin);
  }

  //Hapus data login pada saat logout
  static removeLogin() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(isLogin);
  }
}
