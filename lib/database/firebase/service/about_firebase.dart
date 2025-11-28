import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uvol/database/firebase/models/aboutme_firebase_model.dart';

class AboutFirebaseService {
  static final FirebaseFirestore firestore = FirebaseFirestore.instance;

  static CollectionReference<Map<String, dynamic>> get _ref =>
      firestore.collection('aboutme');

  /// -----------------------------
  /// SAVE or UPDATE ABOUT ME
  /// -----------------------------
  static Future<void> saveAboutMe({
    required String uid,
    required String story,
    required String skill,
    required String cv,
  }) async {
    final data = {
      'storyaboutme': story,
      'skill': skill,
      'cv': cv,
      'updatedAt': DateTime.now().toIso8601String(),
    };

    await _ref.doc(uid).set(data, SetOptions(merge: true));
  }

  /// -----------------------------
  /// GET ABOUT ME (by UID)
  /// -----------------------------
  static Future<AboutmeFirebaseModel?> getAboutMe(String uid) async {
    final doc = await _ref.doc(uid).get();

    if (!doc.exists) return null;

    return AboutmeFirebaseModel.fromMap(doc.data()!);
  }

  /// -----------------------------
  /// DELETE ABOUT ME
  /// -----------------------------
  static Future<void> deleteAboutMe(String uid) async {
    await _ref.doc(uid).delete();
  }
}
