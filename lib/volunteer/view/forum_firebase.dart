import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:uvol/constant/time_ago.dart';
import 'package:uvol/firebase/service/forum_firebase.dart';
import 'package:uvol/firebase/service/user_firebase.dart';
import 'package:uvol/model/forum_model.dart';
import 'package:uvol/widget/container_widget.dart';
import 'package:uvol/volunteer/view/make_post.dart';

class ForumFirebase extends StatefulWidget {
  const ForumFirebase({super.key});

  @override
  State<ForumFirebase> createState() => _ForumFirebaseState();
}

class _ForumFirebaseState extends State<ForumFirebase> {
  List<ForumModel>? forumData;

  @override
  void initState() {
    super.initState();
    getAllPostingan();
  }

  // 🔥 Ambil semua postingan dari Firebase
  Future<void> getAllPostingan() async {
    final data = await ForumFirebaseService.getAllPosts();
    setState(() => forumData = data);
  }

  // 🔥 Edit postingan
  Future<void> _onEdit(ForumModel postingan) async {
    final editC = TextEditingController(text: postingan.posts);

    final save = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Edit Postingan"),
          content: TextField(
            controller: editC,
            maxLines: 4,
            decoration: InputDecoration(border: OutlineInputBorder()),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: Text("Batal"),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: Text("Simpan"),
            ),
          ],
        );
      },
    );

    if (save == true) {
      final updated = ForumModel(
        id: postingan.id,
        name: postingan.name,
        posts: editC.text,
        time: DateTime.now().toString(),
      );

      await ForumFirebaseService.updatePostingan(updated);
      await getAllPostingan();
      Fluttertoast.showToast(msg: "Postingan berhasil diupdate");
    }
  }

  // 🔥 Delete postingan
  Future<void> _onDelete(ForumModel postingan) async {
    await ForumFirebaseService.deletePostingan(postingan.id!);
    await getAllPostingan();
    Fluttertoast.showToast(msg: "Postingan dihapus");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE9EFF8),

      // 🔥 FAB Add Post
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFF4962BF),
        child: Icon(Icons.add, color: Colors.white),
        onPressed: () async {
          final text = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MakePost()),
          );

          if (text != null && text is String) {
            final uid = FirebaseAuth.instance.currentUser!.uid;
            final user = await UserFirebaseService.getUser(uid);

            final newPost = ForumModel(
              name: user?.name ?? "User",
              posts: text,
              time: DateTime.now().toString(),
            );

            await ForumFirebaseService.insertPostingan(newPost);
            await getAllPostingan();
          }
        },
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header
            Container(
              padding: EdgeInsets.all(30),
              decoration: BoxDecoration(
                color: Color(0xFF4962BF),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  Text(
                    "Forum",
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ],
              ),
            ),

            SizedBox(height: 10),

            // LIST POSTS
            if (forumData == null)
              Center(child: CircularProgressIndicator())
            else if (forumData!.isEmpty)
              Padding(
                padding: EdgeInsets.all(20),
                child: Text("Belum ada postingan."),
              )
            else
              ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 20),
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: forumData!.length,
                itemBuilder: (context, index) {
                  final item = forumData![index];

                  return Container(
                    margin: EdgeInsets.only(bottom: 15),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(color: Colors.black12, blurRadius: 4),
                      ],
                    ),
                    child: Stack(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(15),
                          child: ForumWidget(
                            name: item.name ?? "",
                            time: timeAgo(item.time ?? ""),
                            upload: item.posts ?? "",
                            like: "345",
                            comment: "87",
                          ),
                        ),

                        // Edit / Hapus Menu
                        Positioned(
                          right: 5,
                          top: 5,
                          child: IconButton(
                            icon: Icon(Icons.more_vert),
                            onPressed: () {
                              showModalBottomSheet(
                                context: context,
                                builder: (context) => Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    ListTile(
                                      leading: Icon(
                                        Icons.edit,
                                        color: Colors.blue,
                                      ),
                                      title: Text("Edit"),
                                      onTap: () {
                                        Navigator.pop(context);
                                        _onEdit(item);
                                      },
                                    ),
                                    ListTile(
                                      leading: Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                      ),
                                      title: Text("Hapus"),
                                      onTap: () {
                                        Navigator.pop(context);
                                        _onDelete(item);
                                      },
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
          ],
        ),
      ),
    );
  }
}
