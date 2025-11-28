import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uvol/database/firebase/models/aboutme_firebase_model.dart';
import 'package:uvol/database/firebase/models/user_firebase_model.dart';
import 'package:uvol/database/model/user_model.dart';

class PreferenceHandler {
  static const String isLogin = "isLogin";
  static const String userKey = "userData";
  static const String isToken = "isToken";
  static const String aboutKey = "aboutMe";
  static const String userRole = "userRole";
  static const String userIDKey = "userID";

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

  static Future<void> saveUserFirebase(UserFirebaseModel user) async {
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

  static Future<UserFirebaseModel?> getUserFirebase() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(userKey);
    if (jsonString == null) return null;
    return UserFirebaseModel.fromJson(jsonString);
  }

  // Hapus data login dan user (logout)
  static Future<void> removeLogin() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(isLogin);
    await prefs.remove(userKey);
  }

  static saveToken(String value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(isToken, value);
  }

  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(isToken);
  }

  static Future<void> saveAboutMe(AboutmeFirebaseModel about) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(aboutKey, about.toJson());
  }

  static Future<AboutmeFirebaseModel?> getAboutMe() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(aboutKey);
    if (jsonString == null) return null;
    return AboutmeFirebaseModel.fromJson(jsonString);
  }

  static Future<void> saveRole(String role) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(userRole, role);
  }

  static Future<String?> getRole() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(userRole);
  }

  static Future<void> saveUserID(String uid) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(userIDKey, uid);
  }

  static Future<String?> getUserID() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(userIDKey);
  }
}
