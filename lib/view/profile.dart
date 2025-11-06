import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sqflite/sqflite.dart';
import 'package:uvol/database/db_helper.dart';
import 'package:uvol/preferences/preference_handler.dart';
import 'package:uvol/view/detail_events.dart';
import 'package:uvol/view/events.dart';
import 'package:uvol/model/user_model.dart';
import 'package:uvol/view/settings.dart';
import 'package:uvol/widget/app_images.dart';
import 'package:uvol/widget/button.dart';
import 'package:uvol/widget/container_widget.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  UserModel? user;

  void initState() {
    super.initState();
    _loadUser();
  }

  Future<void> _loadUser() async {
    final data = await DbHelper.getUser();
    setState(() => user = data);
  }

  Future<void> _onEdit(UserModel? user) async {
    if (user == null) return;
    final editNameC = TextEditingController(text: user.name);
    final res = await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Edit nama"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: 12,
            children: [buildTextField(hintText: "Name", controller: editNameC)],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Batal"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context, true);
              },
              child: Text("Simpan"),
            ),
          ],
        );
      },
    );

    if (res == true) {
      final updated = UserModel(
        id: user.id,
        name: editNameC.text,
        email: user.email,
      );
      await DbHelper.updateUser(updated);
      _loadUser();
      Fluttertoast.showToast(msg: "Data berhasil di update");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE9EFF8),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Color(0xFF4962BF),
                borderRadius: BorderRadius.circular(15),
                boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 5)],
              ),
              child: Padding(
                padding: const EdgeInsets.all(25),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Profile",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                        IconButton(
                          icon: Icon(Icons.settings, color: Colors.white),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const Settings(),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    height(20),
                    Row(
                      children: [
                        const CircleAvatar(radius: 40),
                        width(15),
                        Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  user?.name ?? "",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                ),
                                width(8),
                                Text(
                                  user?.email ?? "",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                            IconButton(
                              onPressed: () {
                                _onEdit(user);
                              },
                              icon: Icon(
                                Icons.edit,
                                color: Colors.white,
                                size: 18,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    height(20),
                    Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.8),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(children: [Text("20 Partisipasi")]),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Tentang Saya",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  Text(
                    "Seorang relawan yang bersemangat di bidang lingkungan dan pendidikan anak. Mahir dalam desain grafis dan penulisan konten. Siap membantu di area Jakarta dan sekitarnya.",
                  ),
                  height(30),
                  Text(
                    "Skill saya",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  Text("Fotografi, Editing, dan lain-lain"),
                ],
              ),
            ),
            Divider(),
            height(8),
            Padding(
              padding: const EdgeInsets.only(bottom: 1, left: 12),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Participated",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
            ParticipatedWidget(),
          ],
        ),
      ),
    );
  }
}

TextFormField buildTextField({
  String? hintText,
  bool isPassword = false,
  TextEditingController? controller,
  String? Function(String?)? validator,
}) {
  return TextFormField(
    validator: validator,
    controller: controller,
    decoration: InputDecoration(
      hintText: hintText,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(32),
        borderSide: BorderSide(
          color: Colors.black.withOpacity(0.2),
          width: 1.0,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(32),
        borderSide: BorderSide(color: Colors.black, width: 1.0),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(32),
        borderSide: BorderSide(
          color: Colors.black.withOpacity(0.2),
          width: 1.0,
        ),
      ),
    ),
  );
}
