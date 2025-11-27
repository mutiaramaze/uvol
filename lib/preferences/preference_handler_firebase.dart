import 'package:shared_preferences/shared_preferences.dart';
import 'package:uvol/firebase/models/user_firebase_model.dart';
import 'package:uvol/firebase/models/aboutme_firebase_model.dart';
import 'package:uvol/model/user_model.dart';

class PreferenceHandlerFirebase {
  static const String isLoginKey = "isLogin";
  static const String localUserKey = "localUser";
  static const String firebaseUserKey = "firebaseUser";
  static const String tokenKey = "token"; // UID Firebase
  static const String aboutKey = "aboutMe";
  static const String roleKey = "userRole";
  static const String userIDKey = "userID";

  // ===================== LOGIN =====================
  static Future<void> saveLogin(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(isLoginKey, value);
  }

  static Future<bool> getLogin() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(isLoginKey) ?? false;
  }

  // ===================== LOCAL USER =====================
  static Future<void> saveLocalUser(UserModel user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(localUserKey, user.toJson());
  }

  static Future<UserModel?> getLocalUser() async {
    final prefs = await SharedPreferences.getInstance();
    final json = prefs.getString(localUserKey);
    if (json == null) return null;
    return UserModel.fromJson(json);
  }

  // ===================== FIREBASE USER =====================
  static Future<void> saveFirebaseUser(UserFirebaseModel user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(firebaseUserKey, user.toJson());
  }

  static Future<UserFirebaseModel?> getFirebaseUser() async {
    final prefs = await SharedPreferences.getInstance();
    final json = prefs.getString(firebaseUserKey);
    if (json == null) return null;
    return UserFirebaseModel.fromJson(json);
  }

  // ===================== TOKEN (UID) =====================
  static Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(tokenKey, token);
  }

  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(tokenKey);
  }

  // ===================== ABOUT ME =====================
  static Future<void> saveAboutMe(AboutmeFirebaseModel data) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(aboutKey, data.toJson());
  }

  static Future<AboutmeFirebaseModel?> getAboutMe() async {
    final prefs = await SharedPreferences.getInstance();
    final json = prefs.getString(aboutKey);
    if (json == null) return null;
    return AboutmeFirebaseModel.fromJson(json);
  }

  // ===================== ROLE =====================
  static Future<void> saveRole(String role) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(roleKey, role);
  }

  static Future<String?> getRole() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(roleKey);
  }

  // ===================== USER ID =====================
  static Future<void> saveUserID(String uid) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(userIDKey, uid);
  }

  static Future<String?> getUserID() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(userIDKey);
  }

  // ===================== LOGOUT =====================
  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear(); // Hapus semua
  }
}
