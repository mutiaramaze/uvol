import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:uvol/database/firebase/service/firebase.dart';
import 'package:uvol/database/firebase/service/user_firebase.dart';
import 'package:uvol/database/firebase/models/user_firebase_model.dart';
import 'package:uvol/database/preferences/preference_handler_firebase.dart';
import 'package:uvol/features/firebase/auth/register_user_firebase.dart';
import 'package:uvol/features/firebase/main%20page/home_firebase.dart';
import 'package:uvol/widgets/app_images.dart';
import 'package:uvol/widgets/bottom_nav.dart';
import 'package:uvol/widgets/build_text_field.dart';
import 'package:uvol/widgets/container_widget.dart';
import 'package:uvol/widgets/move_button.dart';

class LoginFirebase extends StatefulWidget {
  const LoginFirebase({super.key});

  @override
  State<LoginFirebase> createState() => _LoginFirebaseState();
}

class _LoginFirebaseState extends State<LoginFirebase> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  SizedBox height(double h) => SizedBox(height: h);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: const Color.fromARGB(255, 221, 231, 248)),
      backgroundColor: const Color.fromARGB(255, 221, 231, 248),
      body: buildLayer(context),
    );
  }

  Widget buildLayer(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return SafeArea(
      child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            padding: EdgeInsets.only(bottom: bottomInset),
            child: Column(
              children: [
                height(30),
                Image.asset(AppImages.uvolpng, height: 100),
                height(15),
                const Text("Login to access your account"),
                height(24),

                _buildLoginForm(),

                height(20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLoginForm() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          formLabel("Email"),
          BuildTextField(
            hintText: "Masukkan email anda",
            controller: emailController,
            validator: (value) {
              if (value == null || value.isEmpty)
                return "Email tidak boleh kosong";
              if (!value.contains("@")) return "Email tidak valid";
              return null;
            },
          ),

          height(20),

          formLabel("Password"),
          BuildTextField(
            hintText: "Masukkan password kamu",
            isPassword: true,
            controller: passwordController,
            validator: (value) {
              if (value == null || value.isEmpty)
                return "Password tidak boleh kosong";
              if (value.length < 6) return "Password minimal 6 karakter";
              return null;
            },
          ),

          height(25),

          Center(
            child: MoveButton(
              text: "Login",
              onPressed: () async => handleLogin(),
            ),
          ),

          height(10),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Belum punya akun?"),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const RegisterUserFirebase(),
                    ),
                  );
                },
                child: const Text("Register"),
              ),
            ],
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

  Future<void> handleLogin() async {
    if (!_formKey.currentState!.validate()) return;

    try {
      // 1️⃣ Login ke Firebase Auth
      final authUser = await FirebaseService.loginUser(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      if (authUser == null || authUser.uid == null) {
        Fluttertoast.showToast(msg: "Email atau password salah");
        return;
      }

      final uid = authUser.uid!;
      print("🔥 LOGIN UID: $uid");

      // 2️⃣ Ambil user lengkap dari Firestore
      final userData = await UserFirebaseService.getUser(uid);

      if (userData == null) {
        Fluttertoast.showToast(msg: "User tidak ditemukan di Firestore");
        return;
      }

      print("🔥 USER FIRESTORE: ${userData.name}");

      await PreferenceHandlerFirebase.saveLogin(true);
      await PreferenceHandlerFirebase.saveUserID(userData.uid!);
      await PreferenceHandlerFirebase.saveFirebaseUser(userData);

      Fluttertoast.showToast(msg: "Login berhasil!");

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const BottomNav()),
      );
    } catch (e) {
      print("🔥 ERROR LOGIN: $e");
      Fluttertoast.showToast(msg: "Login gagal: $e");
    }
  }
}
