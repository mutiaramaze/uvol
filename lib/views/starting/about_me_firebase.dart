import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:file_picker/file_picker.dart';

import 'package:uvol/firebase/models/aboutme_firebase_model.dart';
import 'package:uvol/firebase/service/about_firebase.dart';
import 'package:uvol/preferences/preference_handler_firebase.dart';
import 'package:uvol/views/starting/views/login_firebase.dart';
import 'package:uvol/widget/bottom_nav.dart';

class AboutMeFirebase extends StatefulWidget {
  AboutMeFirebase({super.key});

  @override
  State<AboutMeFirebase> createState() => _AboutMeFirebaseState();
}

class _AboutMeFirebaseState extends State<AboutMeFirebase> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController aboutController = TextEditingController();
  final TextEditingController skillsController = TextEditingController();
  final TextEditingController cvController = TextEditingController();

  String? pdfPath;

  // PICK FILE (PDF)
  Future<void> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      File file = File(result.files.single.path!);

      setState(() {
        pdfPath = file.path;
        cvController.text = file.path;
      });

      print('Picked file: ${file.path}');
    } else {
      print('No file selected');
    }
  }

  // BUILD UI
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: const Color(0xFFE9EFF8),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 16),

          child: Form(
            key: _formKey,

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    "Ceritain sedikit tentang kamu yuk!",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),

                const SizedBox(height: 30),

                // ================= FORM UI (TIDAK DIUBAH) =================
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),

                  child: Column(
                    children: [
                      Row(
                        children: const [
                          Text(
                            "Tentang saya",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),

                      TextFormField(
                        controller: aboutController,
                        maxLines: 4,
                        decoration: InputDecoration(
                          hintText: "Tulis jawaban kamu di sini...",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          fillColor: Colors.white,
                          filled: true,
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return "Jawaban tidak boleh kosong";
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 15),

                      Row(
                        children: const [
                          Text(
                            "Skill yang Dimiliki",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),

                      TextFormField(
                        controller: skillsController,
                        maxLines: 4,
                        decoration: InputDecoration(
                          hintText: "Tulis jawaban kamu di sini...",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          fillColor: Colors.white,
                          filled: true,
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return "Jawaban tidak boleh kosong";
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 20),

                      Row(
                        children: const [
                          Text(
                            "CV",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),

                      Row(
                        children: [
                          SizedBox(
                            height: 45,
                            width: 200,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.grey[100],
                                elevation: 1,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 15,
                                  vertical: 10,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),

                              onPressed: pickFile,

                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(
                                    Icons.link,
                                    size: 20,
                                    color: Colors.black,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    pdfPath != null
                                        ? "File dipilih"
                                        : "Pilih file",
                                    style: const TextStyle(
                                      fontSize: 15,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),

                      if (pdfPath != null) ...[
                        const SizedBox(height: 8),
                        Text(
                          pdfPath!.split('/').last,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),

                const SizedBox(height: 30),

                // ================= SAVE BUTTON - LOGIC FIX =================
                Center(
                  child: SizedBox(
                    width: 300,
                    height: 50,

                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF4962BF),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),

                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          // 🔥 coba ambil dari userID dulu
                          String? uid =
                              await PreferenceHandlerFirebase.getUserID();

                          // 🔥 kalau userID kosong, fallback ke token (yang sebenarnya juga UID)
                          uid ??= await PreferenceHandlerFirebase.getToken();

                          if (uid == null || uid.isEmpty) {
                            Fluttertoast.showToast(
                              msg: "UID tidak ditemukan, silakan login ulang",
                            );
                            return;
                          }

                          final aboutFirebase = AboutmeFirebaseModel(
                            storyaboutme: aboutController.text.trim(),
                            skill: skillsController.text.trim(),
                            cv: cvController.text.trim(),
                          );

                          // Simpan ke Firestore
                          await AboutFirebaseService.saveAboutMe(
                            uid: uid,
                            story: aboutFirebase.storyaboutme ?? '',
                            skill: aboutFirebase.skill ?? '',
                            cv: aboutFirebase.cv ?? '',
                          );

                          // Simpan ke SharedPreferences
                          await PreferenceHandlerFirebase.saveAboutMe(
                            aboutFirebase,
                          );

                          Fluttertoast.showToast(msg: "Data anda tersimpan");

                          if (!mounted) return;

                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (_) => LoginFirebase()),
                          );
                        }
                      },

                      child: const Text(
                        "Simpan",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
