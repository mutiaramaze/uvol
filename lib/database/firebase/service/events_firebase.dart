import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uvol/database/firebase/models/questionning_firebase_model.dart';

class JoinEventService {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static Future<bool> joinEvent({
    required String userId,
    required QuestionningModelFirebase event,
  }) async {
    try {
      if (userId.isEmpty) return false;
      final docRef = _firestore
          .collection("users")
          .doc(userId)
          .collection("joined_events")
          .doc(event.id);

      final map = event.toMap();
      if (map['status'] == null || (map['status'] as String).isEmpty) {
        map['status'] = 'active';
      }
      await docRef.set(map, SetOptions(merge: true));
      return true;
    } catch (e) {
      print("joinEvent error: $e");
      return false;
    }
  }

  static Stream<List<QuestionningModelFirebase>> streamJoinedEvents(
    String userId,
  ) {
    return _firestore
        .collection("users")
        .doc(userId)
        .collection("joined_events")
        .orderBy("createdAt", descending: true)
        .snapshots()
        .map((snap) {
          return snap.docs.map((doc) {
            final data = doc.data();
            return QuestionningModelFirebase(
              id: data["id"],
              userId: data["userId"],
              eventId: data["eventId"],
              title: data["title"],
              image: data["image"],
              date: data["date"],
              location: data["location"],
              category: data["category"],
              division1: data["division1"],
              division2: data["division2"],
              division3: data["division3"],
              answer1: data["answer1"],
              answer2: data["answer2"],
              answer3: data["answer3"],
              createdAt: DateTime.parse(data["createdAt"]),
            );
          }).toList();
        });
  }

  static Future<void> updateStatus({
    required String userId,
    required String eventId,
    required String status,
  }) async {
    try {
      final docRef = _firestore
          .collection("users")
          .doc(userId)
          .collection("joined_events")
          .doc(eventId);

      await docRef.update({"status": status});
      print("Status updated to $status for eventId: $eventId");
    } catch (e, st) {
      print("updateStatus ERROR: $e\n$st");
      rethrow;
    }
  }

  static Stream<List<QuestionningModelFirebase>> streamActiveEvents(
    String userId,
  ) {
    return _firestore
        .collection("users")
        .doc(userId)
        .collection("joined_events")
        .where("status", isEqualTo: "active")
        .orderBy("createdAt", descending: true)
        .snapshots()
        .map(
          (snap) => snap.docs
              .map((d) => QuestionningModelFirebase.fromMap(d.data()))
              .toList(),
        );
  }

  static Stream<List<QuestionningModelFirebase>> streamCompletedEvents(
    String userId,
  ) {
    return FirebaseFirestore.instance
        .collection("users")
        .doc(userId)
        .collection("joined_events")
        .where("status", isEqualTo: "completed")
        .snapshots()
        .map((snap) {
          final list = snap.docs
              .map((doc) => QuestionningModelFirebase.fromMap(doc.data()))
              .toList();

          list.sort((a, b) => b.createdAt.compareTo(a.createdAt));
          return list;
        });
  }
}
