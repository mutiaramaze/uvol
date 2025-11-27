// lib/firebase/service/user_firebase_service.dart
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uvol/firebase/models/user_firebase_model.dart';

class UserFirebaseService {
  static final FirebaseFirestore firestore = FirebaseFirestore.instance;

  static CollectionReference<Map<String, dynamic>> get _userRef =>
      firestore.collection('users');

  // ==============================================================
  // CREATE USER (buat akun baru)
  // ==============================================================
  static Future<UserFirebaseModel> createUser(UserFirebaseModel user) async {
    final doc = _userRef.doc(); // auto UID

    final data = {
      ...user.toMap(),
      'uid': doc.id, // ← WAJIB
      'createdAt': DateTime.now().toIso8601String(),
      'updatedAt': DateTime.now().toIso8601String(),
    };

    await doc.set(data);

    log("✔ USER CREATED: $data");

    return UserFirebaseModel.fromMap(data);
  }

  // ==============================================================
  // GET USER BY UID
  // ==============================================================
  static Future<UserFirebaseModel?> getUser(String uid) async {
    final doc = await _userRef.doc(uid).get();
    if (!doc.exists) return null;

    final data = doc.data()!;
    data['uid'] = doc.id; // ← WAJIB

    return UserFirebaseModel.fromMap(data);
  }

  // ==============================================================
  // UPDATE USER
  // ==============================================================
  static Future<void> updateUser(UserFirebaseModel user) async {
    if (user.uid == null || user.uid!.isEmpty) {
      log("❌ UPDATE dibatalkan: UID kosong");
      return;
    }

    final data = user.toMap()..removeWhere((key, value) => value == null);

    data['updatedAt'] = DateTime.now().toIso8601String();

    await _userRef.doc(user.uid).set(data, SetOptions(merge: true));

    log("✔ USER UPDATED: $data");
  }

  // ==============================================================
  // DELETE USER
  // ==============================================================
  static Future<void> deleteUser(String uid) async {
    await _userRef.doc(uid).delete();
  }

  // ==============================================================
  // GET ALL USERS
  // ==============================================================
  static Future<List<UserFirebaseModel>> getAllUser() async {
    final snap = await _userRef.orderBy('createdAt').get();

    return snap.docs.map((doc) {
      final data = doc.data();
      data['uid'] = doc.id; // ← WAJIB
      return UserFirebaseModel.fromMap(data);
    }).toList();
  }

  // ==============================================================
  // STREAM ALL USERS
  // ==============================================================
  static Stream<List<UserFirebaseModel>> streamAllUser() {
    return _userRef.orderBy('createdAt').snapshots().map((snap) {
      return snap.docs.map((doc) {
        final data = doc.data();
        data['uid'] = doc.id; // ← WAJIB
        return UserFirebaseModel.fromMap(data);
      }).toList();
    });
  }
}
