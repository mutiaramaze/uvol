import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uvol/database/model/forum_model.dart';

class ForumFirebaseService {
  static final _ref = FirebaseFirestore.instance.collection("forum");

  static Future<void> insertPostingan(ForumModel data) async {
    await _ref.add({
      "name": data.name,
      "posts": data.posts,
      "time": data.time,
      "userId": data.userId,
    });
  }

  static Future<List<ForumModel>> getAllPosts() async {
    final snap = await _ref.orderBy("time", descending: true).get();
    return snap.docs.map((doc) {
      return ForumModel(
        id: doc.id,
        name: doc["name"],
        posts: doc["posts"],
        time: doc["time"],
        userId: doc["userId"],
      );
    }).toList();
  }

  static Future<void> updatePostingan(ForumModel data) async {
    await _ref.doc(data.id).update({"posts": data.posts, "time": data.time});
  }

  static Future<void> deletePostingan(String id) async {
    await _ref.doc(id).delete();
  }

  static Future<void> updateNameForUser(String userId, String newName) async {
    final query = _ref.where("userId", isEqualTo: userId);
    const int batchSize = 500;
    QuerySnapshot snapshot = await query.limit(batchSize).get();

    while (snapshot.docs.isNotEmpty) {
      final WriteBatch batch = FirebaseFirestore.instance.batch();

      for (final doc in snapshot.docs) {
        batch.update(doc.reference, {"name": newName});
      }

      await batch.commit();

      final lastDoc = snapshot.docs.last;
      snapshot = await query.startAfterDocument(lastDoc).limit(batchSize).get();
    }
  }
}
