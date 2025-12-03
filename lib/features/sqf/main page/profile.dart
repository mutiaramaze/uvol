import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:uvol/database/db_helper.dart';
import 'package:uvol/database/model/aboutme_model.dart';
import 'package:uvol/database/model/user_model.dart';
import 'package:uvol/database/preferences/preference_handler.dart';
import 'package:uvol/features/sqf/details/settings.dart';
import 'package:uvol/widgets/app_images.dart';
import 'package:uvol/widgets/container_widget.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  UserModel? user;
  AboutModel? about;

  @override
  void initState() {
    super.initState();
    _loadUser();
    _loadAbout();
  }

  Future<void> _loadAbout() async {
    final data = await DbHelper.getAbout(); 

    setState(() {
      about = data;
    });

    print("DEBUG PROFILE: ABOUT LOADED -> ${about?.toMap()}");
  }

  Future<void> _loadUser() async {
    final data = await PreferenceHandler.getUser();
    print("DEBUG PROFILE: USER LOADED FROM PREF -> $data");
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
      final updated = UserModel(
        id: currentUser.id,
        name: editNameC.text,
        email: currentUser.email,
        password: currentUser.password,
      );

      print("DEBUG PROFILE: update data -> ${updated.toMap()}");

      try {
        await DbHelper.updateUser(updated);
      } catch (e) {
        print("DEBUG PROFILE: DbHelper.updateUser error -> $e");
      }

      await PreferenceHandler.saveUser(updated);

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
                    const Text(
                      "Data Pribadi",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 15),

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

                    const Text(
                      "Nomor Telepon",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        hintText: "Masukkan nomor telepon",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            height(8),
            Divider(),
            height(8),
            const Padding(
              padding: EdgeInsets.only(left: 25),
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

SizedBox height(double height) => SizedBox(height: height);
SizedBox width(double width) => SizedBox(width: width);
