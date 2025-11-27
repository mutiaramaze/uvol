import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:uvol/constant/time_ago.dart';
import 'package:uvol/firebase/models/user_firebase_model.dart';
import 'package:uvol/firebase/service/forum_firebase.dart';
import 'package:uvol/firebase/service/user_firebase.dart';
import 'package:uvol/model/forum_model.dart';
import 'package:uvol/preferences/preference_handler.dart';
import 'package:uvol/volunteer/view/make_post_firebase.dart';
import 'package:uvol/widget/container_widget.dart';

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

  Future<void> loadUser() async {
    final uid = await PreferenceHandler.getUserID();
    user = await UserFirebaseService.getUser(uid!);
    setState(() {});
  }

  // 🔥 GET ALL dari Firebase
  Future<void> getAllPostingan() async {
    final data = await ForumFirebaseService.getAllPosts();
    setState(() => forumData = data);
  }

  // 🔥 FILTER LIST — INI YANG DITAMBAHKAN
  List<ForumModel> get filteredForum {
    if (searchText.isEmpty || forumData == null) return forumData ?? [];

    return forumData!.where((post) {
      final name = post.name?.toLowerCase() ?? "";
      final text = post.posts?.toLowerCase() ?? "";
      return name.contains(searchText) || text.contains(searchText);
    }).toList();
  }

  // 🔥 EDIT POST
  Future<void> _onEdit(ForumModel postingan) async {
    final editPostsC = TextEditingController(text: postingan.posts);

    final res = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Edit Postingan"),
          content: TextField(
            controller: editPostsC,
            decoration: InputDecoration(
              hintText: "Tulis postingan baru...",
              border: OutlineInputBorder(),
            ),
            maxLines: 4,
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

  // 🔥 DELETE POST
  Future<void> _onDelete(ForumModel postingan) async {
    await ForumFirebaseService.deletePostingan(postingan.id!);
    await getAllPostingan();
    Fluttertoast.showToast(msg: "Postingan berhasil dihapus");
  }

  void _showPostOptions(BuildContext context, ForumModel postingan) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.edit, color: Colors.blue),
              title: Text("Edit"),
              onTap: () {
                Navigator.pop(context);
                _onEdit(postingan);
              },
            ),
            ListTile(
              leading: Icon(Icons.delete, color: Colors.red),
              title: Text("Hapus"),
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
        backgroundColor: Color(0xFF4962BF),
        child: Icon(Icons.add, color: Colors.white),
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MakePostFirebase()),
          );

          if (result != null && result is String) {
            final userName = user?.name ?? "";

            final data = ForumModel(
              posts: result,
              time: DateTime.now().toString(),
              name: userName,
            );

            await ForumFirebaseService.insertPostingan(data);
            await getAllPostingan();
          }
        },
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // HEADER
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

            // SEARCH
            Padding(
              padding: EdgeInsets.all(20),
              child: SizedBox(
                height: 40,
                child: SearchBar(
                  controller: searchC,
                  onChanged: (value) {
                    setState(() {
                      searchText = value.toLowerCase();
                    });
                  },
                  leading: Icon(Icons.search, size: 20),
                  hintText: "Search",
                  backgroundColor: WidgetStatePropertyAll(Colors.white),
                ),
              ),
            ),

            // DATA LIST
            if (forumData == null)
              Padding(
                padding: EdgeInsets.all(20),
                child: CircularProgressIndicator(),
              )
            else if (filteredForum.isEmpty)
              Padding(
                padding: EdgeInsets.all(20),
                child: Text("Tidak ada hasil."),
              )
            else
              ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 20),
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: filteredForum.length,
                itemBuilder: (BuildContext context, int index) {
                  final item = filteredForum[index];

                  return Container(
                    margin: EdgeInsets.only(bottom: 15),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          blurRadius: 5,
                          offset: Offset(2, 4),
                        ),
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
                            like: '345',
                            comment: '87',
                          ),
                        ),
                        Positioned(
                          top: 5,
                          right: 5,
                          child: IconButton(
                            onPressed: () => _showPostOptions(context, item),
                            icon: Icon(Icons.more_vert, color: Colors.grey),
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
