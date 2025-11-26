import 'package:cloud_firestore/cloud_firestore.dart';

class JoinEventService {
  static final _db = FirebaseFirestore.instance;

  static Future<void> joinEvent({
    required String userId,
    required Map<String, dynamic> event,
  }) async {
    await _db
        .collection('users')
        .doc(userId)
        .collection('my_events')
        .doc(event['id']) // id event unik
        .set(event);
  }

  static Stream<List<Map<String, dynamic>>> getMyEvents(String userId) {
    return _db
        .collection('users')
        .doc(userId)
        .collection('my_events')
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList());
  }
}
