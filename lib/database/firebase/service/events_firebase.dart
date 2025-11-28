import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uvol/database/firebase/models/questionnig_model_firebase.dart';

class JoinEventService {
  static final _db = FirebaseFirestore.instance;

  /// SAVE EVENT AFTER USER JOINS
  static Future<void> joinEvent({
    required String userId,
    required QuestionningModelFirebase event,
  }) async {
    // Auto-generate document ID
    final docRef = _db
        .collection('users')
        .doc(userId)
        .collection('my_events')
        .doc(); // AUTO-ID

    final eventId = docRef.id;

    // Convert model ke map
    final data = event.toMap();

    // Pastikan ID tersimpan
    data['id'] = eventId;

    // Tambahkan waktu join
    data['timeJoined'] = DateTime.now().toIso8601String();

    // SIMPAN DATA
    await docRef.set(data);
  }

  /// GET ALL EVENTS JOINED BY USER
  static Stream<List<QuestionningModelFirebase>> getMyEvents(String userId) {
    return _db
        .collection('users')
        .doc(userId)
        .collection('my_events')
        .orderBy('timeJoined', descending: true)
        .snapshots()
        .map((snap) {
          return snap.docs.map((doc) {
            final data = doc.data();

            // Set id dari firestore
            data['id'] = doc.id;

            return QuestionningModelFirebase.fromMap(data);
          }).toList();
        });
  }
}
