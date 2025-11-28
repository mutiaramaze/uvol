import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:uvol/database/firebase/models/aboutme_firebase_model.dart';
import 'package:uvol/database/firebase/models/user_firebase_model.dart';
import 'package:uvol/database/firebase/service/about_firebase.dart';
import 'package:uvol/database/firebase/service/user_firebase.dart';
import 'package:uvol/database/model/aboutme_model.dart';
import 'package:uvol/database/preferences/preference_handler_firebase.dart';
import 'package:uvol/features/firebase/auth/register_user_firebase.dart';
import 'package:uvol/features/sqf/details/detail_events.dart';
import 'package:uvol/features/sqf/details/settings.dart';
import 'package:uvol/widgets/app_images.dart';
import 'package:uvol/widgets/build_text_field.dart';
import 'package:uvol/widgets/container_widget.dart';

class ProfilePageFirebase extends StatefulWidget {
  const ProfilePageFirebase({super.key});

  @override
  State<ProfilePageFirebase> createState() => _ProfilePageFirebaseState();
}

class _ProfilePageFirebaseState extends State<ProfilePageFirebase> {
  UserFirebaseModel? user;
  AboutmeFirebaseModel? about;

  @override
  void initState() {
    super.initState();
    _loadUser();
    _loadAbout();
  }

  Future<void> _loadUser() async {
    final uid = await PreferenceHandlerFirebase.getUserID();

    if (uid == null || uid.isEmpty) {
      print("❌ UID tidak ditemukan di SharedPreferences");
      return;
    }

    final data = await UserFirebaseService.getUser(uid);

    print("DEBUG PROFILE: USER LOADED -> ${data?.toJson()}");

    if (!mounted) return;
    setState(() => user = data);
  }

  Future<void> _loadAbout() async {
    final uid = await PreferenceHandlerFirebase.getUserID();
    if (uid == null || uid.isEmpty) return;

    final data = await AboutFirebaseService.getAboutMe(uid);

    print("🔥 ABOUT LOADED: ${data?.toJson()}");

    setState(() {
      about = data; // pakai model Firebase langsung
    });
  }

  Future<void> _onEdit() async {
    if (user == null) {
      Fluttertoast.showToast(msg: "Data user belum tersedia");
      return;
    }

    final currentUser = user!;
    final currentAbout = about;

    final nameC = TextEditingController(text: currentUser.name ?? "");
    final phoneC = TextEditingController(text: currentUser.phone ?? "");
    final storyC = TextEditingController(
      text: currentAbout?.storyaboutme ?? "",
    );
    final skillC = TextEditingController(text: currentAbout?.skill ?? "");
    final cvC = TextEditingController(text: currentAbout?.cv ?? "");

    Future<void> pickFile() async {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
      );

      if (result != null) {
        String path = result.files.single.path ?? "";
        setState(() {
          cvC.text = path;
        });
      }
    }

    final res = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          titlePadding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
          contentPadding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
          title: const Text(
            "Edit Profil",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                formLabel("Nama"),
                BuildTextField(hintText: "Nama", controller: nameC),
                const SizedBox(height: 15),

                formLabel("Nomor Telepon"),
                BuildTextField(hintText: "Nomor Telepon", controller: phoneC),
                const SizedBox(height: 20),

                formLabel("Tentang Saya"),
                BuildTextField(
                  hintText: "Tuliskan tentang diri kamu",
                  controller: storyC,
                  maxLines: 3,
                ),
                const SizedBox(height: 20),

                formLabel("Skill"),
                BuildTextField(
                  hintText: "Tuliskan skill kamu",
                  controller: skillC,
                  maxLines: 3,
                ),
                const SizedBox(height: 20),

                formLabel("CV"),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: cvC,
                        readOnly: true,
                        decoration: InputDecoration(
                          hintText: "CV (file path)",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 10,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: pickFile,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF4962BF),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                      ),
                      child: const Text(
                        "Pilih File",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                const SizedBox(height: 20),
              ],
            ),
          ),
          actionsPadding: const EdgeInsets.fromLTRB(0, 0, 20, 10),
          actionsAlignment: MainAxisAlignment.end,
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text("Batal", style: TextStyle(color: Colors.grey)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF4962BF),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
              ),
              onPressed: () => Navigator.pop(context, true),
              child: const Text(
                "Simpan",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );

    if (res == true) {
      final updatedUser = UserFirebaseModel(
        uid: currentUser.uid,
        name: nameC.text.trim(),
        email: currentUser.email,
        phone: phoneC.text.trim(),
        createdAt: currentUser.createdAt,
        updatedAt: DateTime.now().toIso8601String(),
      );
      final updatedAbout = AboutmeFirebaseModel(
        storyaboutme: storyC.text.trim(),
        skill: skillC.text.trim(),
        cv: cvC.text.trim(),
      );

      try {
        // UPDATE FIRESTORE
        await UserFirebaseService.updateUser(updatedUser);

        await AboutFirebaseService.saveAboutMe(
          uid: currentUser.uid!,
          story: storyC.text.trim(),
          skill: skillC.text.trim(),
          cv: cvC.text.trim(),
        );

        // 🔥 SIMPAN KE SHAREDPREFERENCES
        await PreferenceHandlerFirebase.saveFirebaseUser(updatedUser);
        await PreferenceHandlerFirebase.saveAboutMe(
          AboutmeFirebaseModel(
            storyaboutme: storyC.text.trim(),
            skill: skillC.text.trim(),
            cv: cvC.text.trim(),
          ),
        );

        setState(() {
          user = updatedUser;
          about = updatedAbout;
        });

        Fluttertoast.showToast(msg: "Data berhasil diperbarui");
      } catch (e) {
        Fluttertoast.showToast(msg: "Gagal mengupdate data");
      }
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Profile",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                        IconButton(
                          icon: const Icon(Icons.logout, color: Colors.white),
                          onPressed: () async {
                            final confirm = await showDialog<bool>(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: const Text("Konfirmasi"),
                                  content: const Text(
                                    "Apakah kamu yakin ingin keluar?",
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  actions: [
                                    TextButton(
                                      child: const Text("Batal"),
                                      onPressed: () =>
                                          Navigator.pop(context, false),
                                    ),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color(
                                          0xFF4962BF,
                                        ),
                                      ),
                                      child: const Text(
                                        "Keluar",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      onPressed: () =>
                                          Navigator.pop(context, true),
                                    ),
                                  ],
                                );
                              },
                            );

                            // ❗ Jika user tekan cancel, stop
                            if (confirm != true) return;

                            // 🔥 Hapus semua SharedPreferences (logout)
                            await PreferenceHandlerFirebase.logout();

                            // Arahkan ke register/login
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const RegisterUserFirebase(),
                              ),
                              (route) => false,
                            );
                          },
                        ),

                        // IconButton(
                        //   icon: const Icon(Icons.settings, color: Colors.white),
                        //   onPressed: () {
                        //     Navigator.push(
                        //       context,
                        //       MaterialPageRoute(
                        //         builder: (context) => const Settings(),
                        //       ),
                        //     );
                        //   },
                        // ),
                      ],
                    ),
                    height(20),

                    // PROFILE DATA
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
                                onPressed: _onEdit,
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

                    // Container(
                    //   padding: const EdgeInsets.all(15),
                    //   decoration: BoxDecoration(
                    //     color: Colors.white.withOpacity(0.8),
                    //     borderRadius: BorderRadius.circular(8),
                    //   ),
                    //   child: const Column(children: [Text("3 Partisipasi")]),
                    // ),
                  ],
                ),
              ),
            ),

            height(10),

            // DATA PRIBADI BOX
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
                      children: const [
                        Text(
                          "Data Pribadi",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Divider(),
                    const SizedBox(height: 20),

                    const Text(
                      "Nomor Telepon",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      user?.phone ?? "Belum ada nomor",
                      style: const TextStyle(fontSize: 14),
                    ),

                    const SizedBox(height: 20),

                    const Text(
                      "CV",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      about?.cv != null && about!.cv!.isNotEmpty
                          ? about!.cv!.split('/').last
                          : "Belum ada CV",
                      style: const TextStyle(fontSize: 14),
                    ),

                    const SizedBox(height: 20),

                    const Text(
                      "Tentang Saya",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      about?.storyaboutme ?? "Belum ada data",
                      style: const TextStyle(fontSize: 14),
                    ),

                    const SizedBox(height: 20),

                    const Text(
                      "Skill Saya",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      about?.skill ?? "Belum ada data",
                      style: const TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),

            height(8),
            const Divider(),
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
