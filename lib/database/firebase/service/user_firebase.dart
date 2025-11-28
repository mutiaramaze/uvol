import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uvol/database/firebase/models/user_firebase_model.dart';

class UserFirebaseService {
  static final firestore = FirebaseFirestore.instance;

  static Future<UserFirebaseModel?> getUser(String uid) async {
    try {
      final snap = await firestore.collection('users').doc(uid).get();

      if (!snap.exists) {
        print("❌ User tidak ditemukan di Firestore");
        return null;
      }

      final data = snap.data()!;
      print("🔥 Data User dari Firestore: $data");

      return UserFirebaseModel.fromMap(data);
    } catch (e) {
      print("❌ Error getUser: $e");
      return null;
    }
  }

  static Future<void> updateUser(UserFirebaseModel user) async {
    try {
      await firestore.collection('users').doc(user.uid).set({
        "uid": user.uid,
        "name": user.name,
        "email": user.email,
        "phone": user.phone,
        "createdAt": user.createdAt,
        "updatedAt": user.updatedAt ?? DateTime.now().toString(),
      }, SetOptions(merge: true));

      print("🔥 User Updated");
    } catch (e) {
      print("❌ Error updateUser: $e");
    }
  }
}
