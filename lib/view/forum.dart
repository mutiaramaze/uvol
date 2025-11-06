import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:uvol/constant/time_ago.dart';
import 'package:uvol/database/db_helper.dart';
import 'package:uvol/model/forum_model.dart';
import 'package:uvol/model/user_model.dart';
import 'package:uvol/view/events.dart';
import 'package:uvol/view/make_post.dart';
import 'package:uvol/view/profile.dart';
import 'package:uvol/widget/app_images.dart';
import 'package:uvol/widget/container_widget.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:uvol/model/forum_model.dart';
import 'package:uvol/model/user_model.dart';
import 'package:uvol/view/make_post.dart';

class Forum extends StatefulWidget {
  const Forum({super.key});

  @override
  State<Forum> createState() => _ForumState();
}

class _ForumState extends State<Forum> {
  final nameC = TextEditingController();
  final postsC = TextEditingController();
  List<ForumModel>? forumData;

  @override
  void initState() {
    super.initState();
    getAllPostingan();
  }

  Future<void> getAllPostingan() async {
    final data = await DbHelper.getAllPostingan();
    if (data != null) {
      data.sort((a, b) {
        DateTime timeA = DateTime.tryParse(a.time ?? "") ?? DateTime.now();
        DateTime timeB = DateTime.tryParse(b.time ?? "") ?? DateTime.now();
        return timeB.compareTo(timeA); // terbaru di atas
      });
    }
    setState(() => forumData = data);
  }

  Future<void> _onEdit(ForumModel postingan) async {
    final editPostsC = TextEditingController(text: postingan.posts);

    final res = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(10),
          ),
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
      await DbHelper.updatePostingan(updated);
      await getAllPostingan();
      Fluttertoast.showToast(msg: "Postingan berhasil diupdate");
    }
  }

  Future<void> _onDelete(ForumModel postingan) async {
    await DbHelper.deletePostingan(postingan.id!);
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
        backgroundColor: Color(0xFF4962BF),
        child: const Icon(Icons.add, color: Colors.white),
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const MakePost()),
          );

          if (result != null && result is String) {
            final user = await DbHelper.getUser();
            final data = ForumModel(
              posts: result,
              time: DateTime.now().toString(),
              name: user?.name,
            );
            await DbHelper.insertPostingan(data);
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
            const Padding(
              padding: EdgeInsets.all(15),
              child: SearchBar(leading: Icon(Icons.search), hintText: "Search"),
            ),
            if (forumData == null)
              const Padding(
                padding: EdgeInsets.all(20),
                child: CircularProgressIndicator(),
              )
            else if (forumData!.isEmpty)
              const Padding(
                padding: EdgeInsets.all(20),
                child: Text("Belum ada postingan."),
              )
            else
              ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: forumData!.length,
                itemBuilder: (BuildContext context, int index) {
                  final item = forumData![index];
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
                            onPressed: () {
                              _showPostOptions(context, item);
                            },
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
