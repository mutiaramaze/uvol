import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:uvol/constant/time_ago.dart';
import 'package:uvol/database/firebase/models/user_firebase_model.dart';
import 'package:uvol/database/firebase/service/forum_firebase.dart';
import 'package:uvol/database/firebase/service/user_firebase.dart';
import 'package:uvol/database/model/forum_model.dart';
import 'package:uvol/database/preferences/preference_handler.dart';
import 'package:uvol/features/firebase/details/make_post_firebase.dart';
import 'package:uvol/widgets/container_widget.dart';

class ForumFirebase extends StatefulWidget {
  const ForumFirebase({super.key});

  @override
  State<ForumFirebase> createState() => _ForumFirebaseState();
}

class _ForumFirebaseState extends State<ForumFirebase> {
  final TextEditingController searchC = TextEditingController();
  String searchText = "";

  List<ForumModel>? forumData;
  UserFirebaseModel? user;

  @override
  void initState() {
    super.initState();
    getAllPostingan();
    loadUser();
  }

  // ============================================================
  // 🔥 LOAD USER
  // ============================================================
  Future<void> loadUser() async {
    final uid = await PreferenceHandler.getUserID();
    if (uid == null) {
      print("❌ UID tidak ditemukan di preferences");
      return;
    }

    user = await UserFirebaseService.getUser(uid);

    print("🔥 USER LOADED --> NAME: ${user?.name}");

    setState(() {});
  }

  Future<void> getAllPostingan() async {
    final data = await ForumFirebaseService.getAllPosts();
    setState(() => forumData = data);
  }

  List<ForumModel> get filteredForum {
    if (searchText.isEmpty || forumData == null) return forumData ?? [];

    return forumData!.where((post) {
      final name = post.name?.toLowerCase() ?? "";
      final text = post.posts?.toLowerCase() ?? "";
      return name.contains(searchText) || text.contains(searchText);
    }).toList();
  }

  Future<void> _onEdit(ForumModel postingan) async {
    final editPostsC = TextEditingController(text: postingan.posts);

    final res = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Edit Postingan"),
          content: TextField(
            controller: editPostsC,
            decoration: const InputDecoration(
              hintText: "Tulis postingan baru...",
              border: OutlineInputBorder(),
            ),
            maxLines: 4,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text("Batal"),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text("Simpan"),
            ),
          ],
        );
      },
    );

    if (res == true) {
      final updated = ForumModel(
        id: postingan.id,
        name: postingan.name,
        posts: editPostsC.text,
        time: DateTime.now().toString(),
      );

      await ForumFirebaseService.updatePostingan(updated);
      await getAllPostingan();
      Fluttertoast.showToast(msg: "Postingan berhasil diupdate");
    }
  }

  Future<void> _onDelete(ForumModel postingan) async {
    await ForumFirebaseService.deletePostingan(postingan.id!);
    await getAllPostingan();
    Fluttertoast.showToast(msg: "Postingan berhasil dihapus");
  }

  void _showPostOptions(BuildContext context, ForumModel postingan) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.edit, color: Colors.blue),
              title: const Text("Edit"),
              onTap: () {
                Navigator.pop(context);
                _onEdit(postingan);
              },
            ),
            ListTile(
              leading: const Icon(Icons.delete, color: Colors.red),
              title: const Text("Hapus"),
              onTap: () {
                Navigator.pop(context);
                _onDelete(postingan);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE9EFF8),

      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF4962BF),
        child: const Icon(Icons.add, color: Colors.white),
        onPressed: () async {
          // Pastikan user loaded
          if (user == null || (user?.name?.isEmpty ?? true)) {
            Fluttertoast.showToast(msg: "Sedang memuat user...");
            await loadUser();
            if (user == null) return;
          }

          // Pergi ke halaman buat post
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const MakePostFirebase()),
          );

          if (result != null && result is String) {
            final data = ForumModel(
              posts: result,
              time: DateTime.now().toString(),
              name: user!.name ?? "Anonymous",
            );

            await ForumFirebaseService.insertPostingan(data);
            await getAllPostingan();
          }
        },
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(30),
              decoration: BoxDecoration(
                color: const Color(0xFF4962BF),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Row(
                children: [
                  Text(
                    "Forum",
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(20),
              child: SizedBox(
                height: 40,
                child: SearchBar(
                  controller: searchC,
                  onChanged: (value) =>
                      setState(() => searchText = value.toLowerCase()),
                  leading: const Icon(Icons.search, size: 20),
                  hintText: "Search",
                  backgroundColor: const WidgetStatePropertyAll(Colors.white),
                ),
              ),
            ),

            if (forumData == null)
              const Padding(
                padding: EdgeInsets.all(20),
                child: CircularProgressIndicator(),
              )
            else if (filteredForum.isEmpty)
              const Padding(
                padding: EdgeInsets.all(20),
                child: Text("Tidak ada hasil."),
              )
            else
              ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: filteredForum.length,
                itemBuilder: (context, index) {
                  final item = filteredForum[index];

                  return Container(
                    margin: const EdgeInsets.only(bottom: 15),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          blurRadius: 5,
                          offset: const Offset(2, 4),
                        ),
                      ],
                    ),
                    child: Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(15),
                          child: ForumWidget(
                            name: item.name ?? "Anonymous",
                            time: timeAgo(item.time ?? ""),
                            upload: item.posts ?? "",
                            like: '345',
                            comment: '87',
                          ),
                        ),
                        Positioned(
                          top: 5,
                          right: 5,
                          child: IconButton(
                            onPressed: () => _showPostOptions(context, item),
                            icon: const Icon(
                              Icons.more_vert,
                              color: Colors.grey,
                            ),
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
