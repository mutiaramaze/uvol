import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:uvol/database/db_helper.dart';
import 'package:uvol/firebase/models/user_firebase_model.dart';
import 'package:uvol/firebase/service/firebase.dart';
import 'package:uvol/firebase/service/user_firebase.dart';
import 'package:uvol/model/aboutme_model.dart';
import 'package:uvol/model/user_model.dart';
import 'package:uvol/preferences/preference_handler.dart';
import 'package:uvol/view/detail_events.dart';
import 'package:uvol/view/settings.dart';
import 'package:uvol/widget/app_images.dart';
import 'package:uvol/widget/build_text_field.dart';
import 'package:uvol/widget/container_widget.dart';

class ProfilePageFirebase extends StatefulWidget {
  const ProfilePageFirebase({super.key});

  @override
  State<ProfilePageFirebase> createState() => _ProfilePageFirebaseState();
}

class _ProfilePageFirebaseState extends State<ProfilePageFirebase> {
  UserFirebaseModel? user;
  AboutModel? about;

  @override
  void initState() {
    super.initState();
    _loadUser();
    // _loadAbout();
  }

  getData() {
    UserFirebaseService.getAllUser();
    setState(() {});
  }

  Future<void> _loadAbout() async {
    final data = await DbHelper.getAbout();

    setState(() {
      about = data;
    });

    print("DEBUG PROFILE: ABOUT LOADED -> ${about?.toMap()}");
  }

  Future<void> _loadUser() async {
    final token = await PreferenceHandler.getToken();
    // print(token);
    final data = await UserFirebaseService.getUser(token!);
    print("DEBUG PROFILE: USER LOADED FROM PREF -> ${data!.toJson()}");
    setState(() => user = data);
  }

  Future<void> _onEdit() async {
    print("DEBUG PROFILE: _onEdit dipanggil, user = $user");

    if (user == null) {
      Fluttertoast.showToast(msg: "Data user belum tersedia");
      return;
    }

    final currentUser = user!;
    final editNameC = TextEditingController(text: currentUser.name ?? "");

    final res = await showDialog<bool>(
      context: context,
      builder: (context) {
        print("DEBUG PROFILE: showDialog builder jalan");
        return AlertDialog(
          title: const Text("Edit nama"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [BuildTextField(hintText: "Name", controller: editNameC)],
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

    print("DEBUG PROFILE: hasil dialog -> $res");

    if (res == true) {
      final updated = UserFirebaseModel(
        uid: currentUser.uid,
        name: editNameC.text,
        email: currentUser.email,
      );

      print("DEBUG PROFILE: update data -> ${updated.toMap()}");

      try {
        final result = await UserFirebaseService.updateUser(updated);

        // print(result);
      } catch (e) {
        print("DEBUG PROFILE: DbHelper.updateUser error -> $e");
      }

      // await PreferenceHandler.saveUser(updated);

      setState(() {
        user = updated;
      });

      Fluttertoast.showToast(msg: "Data berhasil diupdate");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE9EFF8),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // HEADER PROFILE
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFF4962BF),
                borderRadius: BorderRadius.circular(15),
                boxShadow: const [BoxShadow(color: Colors.grey, blurRadius: 5)],
              ),
              child: Padding(
                padding: const EdgeInsets.all(25),
                child: Column(
                  children: [
                    // BARIS ATAS: TITLE + SETTINGS
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Profile",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                        IconButton(
                          icon: const Icon(Icons.settings, color: Colors.white),
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

                    // BARIS PROFILE: AVATAR + NAMA + EMAIL + TOMBOL EDIT
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const CircleAvatar(
                          radius: 40,
                          backgroundImage: AssetImage(AppImages.ali),
                        ),
                        width(15),
                        Expanded(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              // TEKS NAMA + EMAIL
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      user?.name ?? "",
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      user?.email ?? "",
                                      style: const TextStyle(
                                        color: Colors.white,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                              // ICON EDIT
                              IconButton(
                                onPressed: () {
                                  print("DEBUG PROFILE: Icon edit diklik");
                                  _onEdit();
                                },
                                icon: const Icon(
                                  Icons.edit,
                                  color: Colors.white,
                                  size: 18,
                                ),
                                tooltip: "Edit profil",
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    height(20),

                    // KOTAK PARTISIPASI
                    Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.8),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Column(children: [Text("3 Partisipasi")]),
                    ),
                  ],
                ),
              ),
            ),

            // BODY
            Padding(
              padding: const EdgeInsets.all(25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Tentang saya",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),

                  const Text(
                    "Seorang relawan yang bersemangat di bidang lingkungan dan pendidikan anak. Mahir dalam desain grafis dan penulisan konten. Siap membantu di area Jakarta dan sekitarnya.",
                  ),
                  height(30),
                  const Text(
                    "Skill saya",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  Text(about?.skill ?? "Belum ada data"),
                ],
              ),
            ),
            const Divider(),

            // --- CONTAINER CV & NOMOR TELEPON ---
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 6,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Text(
                          "Data Pribadi",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            print("DEBUG PROFILE: Icon edit diklik");
                            _onEdit();
                          },
                          icon: const Icon(
                            Icons.edit,
                            color: Colors.black,
                            size: 18,
                          ),
                          tooltip: "Edit Data",
                        ),
                      ],
                    ),

                    const SizedBox(height: 15),

                    // UPLOAD CV
                    Text(
                      about?.cv != null && about!.cv!.isNotEmpty
                          ? about!.cv!.split('/').last
                          : "Belum ada CV",
                      overflow: TextOverflow.ellipsis,
                    ),

                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 16,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade400),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: const [
                          Icon(Icons.attach_file, size: 20),
                          SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              "Pilih file CV",
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    // NOMOR TELEPON
                    const Text(
                      "Nomor Telepon",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      user?.phone ?? "",
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
            height(8),
            Divider(),
            height(8),
            const Padding(
              padding: EdgeInsets.only(bottom: 1, left: 12),
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
            ParticipatedWidget(),
            ParticipatedWidget(),
          ],
        ),
      ),
    );
  }
}
