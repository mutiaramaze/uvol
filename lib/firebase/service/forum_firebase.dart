import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uvol/model/forum_model.dart';

class ForumFirebaseService {
  static final _ref = FirebaseFirestore.instance.collection("forum");

  static Future<void> insertPostingan(ForumModel data) async {
    await _ref.add({"name": data.name, "posts": data.posts, "time": data.time});
  }

  static Future<List<ForumModel>> getAllPosts() async {
    final snap = await _ref.orderBy("time", descending: true).get();
    return snap.docs.map((doc) {
      return ForumModel(
        id: doc.id,
        name: doc["name"],
        posts: doc["posts"],
        time: doc["time"],
      );
    }).toList();
  }

  static Future<void> updatePostingan(ForumModel data) async {
    await _ref.doc(data.id).update({"posts": data.posts, "time": data.time});
  }

  static Future<void> deletePostingan(String id) async {
    await _ref.doc(id).delete();
  }
}
