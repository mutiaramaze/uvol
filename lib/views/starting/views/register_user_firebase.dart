import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:uvol/firebase/models/user_firebase_model.dart';
import 'package:uvol/firebase/service/firebase.dart';
import 'package:uvol/firebase/service/user_firebase.dart';
import 'package:uvol/preferences/preference_handler_firebase.dart';
import 'package:uvol/views/starting/about_me_firebase.dart';
import 'package:uvol/views/starting/views/login_firebase.dart';
import 'package:uvol/volunteer/view/starting/about_me.dart';
import 'package:uvol/widget/build_text_field.dart';
import 'package:uvol/widget/container_widget.dart';
import 'package:uvol/widget/move_button.dart';

class RegisterUserFirebase extends StatefulWidget {
  const RegisterUserFirebase({super.key});
  static const id = "/registerUserFirebase";

  @override
  State<RegisterUserFirebase> createState() => _RegisterUserFirebaseState();
}

class _RegisterUserFirebaseState extends State<RegisterUserFirebase> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final phoneController = TextEditingController();

  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();

  SizedBox height(double h) => SizedBox(height: h);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: const Color.fromARGB(255, 221, 231, 248)),
      backgroundColor: const Color.fromARGB(255, 221, 231, 248),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Hello volunteers!",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2E2E5D),
                      ),
                    ),
                    const SizedBox(height: 5),
                    const Text(
                      "Daftar dulu yuk",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2E2E5D),
                      ),
                    ),
                    height(16),

                    _buildForm(),

                    height(20),

                    MoveButton(
                      text: "Register",
                      isLoading: isLoading,
                      onPressed: () async => handleRegister(context),
                    ),

                    height(15),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Sudah punya akun?",
                          style: TextStyle(color: Colors.grey),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => LoginFirebase(),
                              ),
                            );
                          },
                          child: const Text("Login"),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildForm() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          formLabel("Nama"),
          BuildTextField(
            hintText: "Masukkan nama kamu",
            controller: nameController,
            validator: (value) => value == null || value.isEmpty
                ? "Nama tidak boleh kosong"
                : null,
          ),
          height(20),

          formLabel("Email"),
          BuildTextField(
            hintText: "Masukkan email kamu",
            controller: emailController,
            validator: (value) {
              if (value == null || value.isEmpty)
                return "Email tidak boleh kosong";
              if (!value.contains("@")) return "Email tidak valid";
              return null;
            },
          ),
          height(20),

          formLabel("Nomor Handphone"),
          BuildTextField(
            hintText: "Masukkan nomor handphone kamu",
            controller: phoneController,
            validator: (value) {
              if (value == null || value.isEmpty)
                return "Nomor tidak boleh kosong";
              if (value.length < 10) return "Nomor minimal 10 karakter";
              return null;
            },
          ),
          height(20),

          formLabel("Password"),
          BuildTextField(
            hintText: "Buat password kamu",
            isPassword: true,
            controller: passwordController,
            validator: (value) {
              if (value == null || value.isEmpty)
                return "Password tidak boleh kosong";
              if (value.length < 6) return "Password minimal 6 karakter";
              return null;
            },
          ),
        ],
      ),
    );
  }

  Widget formLabel(String text) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(text, style: const TextStyle(color: Color(0xFF4962BF))),
    );
  }

  Future<void> handleRegister(BuildContext context) async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => isLoading = true);

    try {
      // 1️⃣ Register ke FirebaseAuth
      final authUser = await FirebaseService.registerUser(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
        name: nameController.text.trim(),
        phone: phoneController.text.trim(),
      );

      if (authUser == null || authUser.uid == null) {
        Fluttertoast.showToast(msg: "Register gagal");
        return;
      }

      final uid = authUser.uid!;
      print("🔥 FirebaseAuth UID: $uid");

      // 2️⃣ Buat User Model untuk disimpan ke Firestore
      final user = UserFirebaseModel(
        uid: uid,
        name: nameController.text.trim(),
        email: emailController.text.trim(),
        phone: phoneController.text.trim(),
        createdAt: DateTime.now().toIso8601String(),
        updatedAt: DateTime.now().toIso8601String(),
      );

      // 3️⃣ Simpan ke Firestore
      await UserFirebaseService.updateUser(user);
      print("🔥 Firestore user saved");

      // 4️⃣ Simpan ke SharedPreferences
      await PreferenceHandlerFirebase.saveToken(uid);
      await PreferenceHandlerFirebase.saveFirebaseUser(user);

      print("🔥 User saved to SharedPreferences");

      setState(() => isLoading = false);

      Fluttertoast.showToast(msg: "Register berhasil!");

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => AboutMeFirebase()),
      );
    } catch (e) {
      setState(() => isLoading = false);

      print("🔥 ERROR: $e");

      try {
        final errorJson = jsonDecode(e.toString());
        Fluttertoast.showToast(
          msg: errorJson["message"] ?? "Terjadi kesalahan",
        );
      } catch (_) {
        Fluttertoast.showToast(msg: e.toString());
      }
    }
  }
}
