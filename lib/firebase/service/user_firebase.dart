// lib/day_19/services/user_firebase_service.dart
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uvol/firebase/models/user_firebase_model.dart';

class UserFirebaseService {
  static final FirebaseFirestore firestore = FirebaseFirestore.instance;

  static CollectionReference<Map<String, dynamic>> get _userRef =>
      firestore.collection('user');

  /// CREATE user (tambah siswa)
  static Future<UserFirebaseModel> createUser(UserFirebaseModel user) async {
    // bikin dokumen baru dengan auto id
    final doc = _userRef.doc();

    // siapkan map untuk disimpan
    final data = {
      ...user.toMap(),
      'id': doc.id,
      'createdAt': DateTime.now().toIso8601String(),
      'updatedAt': DateTime.now().toIso8601String(),
    };

    // simpan ke Firestore
    await doc.set(data);
    log('data: $data');
    log('data doc id: ${doc.id}');
    // kembalikan model dengan id dokumen (kalau UserModelFirebase support id String)
    // sesuaikan dengan konstruktor UserModelFirebase kamu
    return UserFirebaseModel.fromMap({
      // 'id': doc.id, // pastikan fromMap bisa handle String
      ...data,
    });
  }

  /// READ ALL user (ambil semua siswa)
  static Future<List<UserFirebaseModel>> getAllUser() async {
    final snap = await _userRef.orderBy('createdAt', descending: false).get();

    final list = snap.docs.map((doc) {
      final data = doc.data();

      // gabung doc.id sebagai id ke map
      return UserFirebaseModel.fromMap({'id': doc.id, ...data});
    }).toList();

    return list;
  }

  static Stream<List<UserFirebaseModel>> streamAllUser() {
    return _userRef.orderBy('createdAt', descending: false).snapshots().map((
      snap,
    ) {
      return snap.docs.map((doc) {
        final data = doc.data();

        // pastikan id selalu ada
        data['id'] ??= doc.id;

        return UserFirebaseModel.fromMap(data);
      }).toList();
    });
  }

  /// UPDATE user
  ///
  /// asumsi: di UserModelFirebase sudah ada field `id` yang menyimpan docId Firestore
  static Future<void> updateUser(UserFirebaseModel user) async {
    if (user.uid!.isEmpty) {
      print("❌ UID kosong! Update dibatalkan");
      return;
    }

    final data = user.toMap()
      ..removeWhere((key, value) => value == null); // HINDARI overwrite null

    print("UPDATE FIREBASE => $data");

    await firestore
        .collection('user')
        .doc(user.uid)
        .set(data, SetOptions(merge: true));
  }

  /// DELETE user
  ///
  /// docId = id dokumen di Firestore
  static Future<void> deleteuser(String docId) async {
    await _userRef.doc(docId).delete();
  }

  static Future<UserFirebaseModel?> getUser(String uid) async {
    final doc = await firestore.collection('user').doc(uid).get();
    if (!doc.exists) return null;
    return UserFirebaseModel.fromMap(doc.data()!);
  }
}
