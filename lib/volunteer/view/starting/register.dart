import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:uvol/database/db_helper.dart';
import 'package:uvol/model/user_model.dart';
import 'package:uvol/preferences/preference_handler.dart';
import 'package:uvol/volunteer/view/starting/about_me.dart';
import 'package:uvol/volunteer/view/starting/login.dart';
import 'package:uvol/widget/build_text_field.dart';
import 'package:uvol/widget/container_widget.dart';
import 'package:uvol/widget/move_button.dart';

class Register extends StatefulWidget {
  const Register({super.key});
  static const id = "/register";

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final phoneController = TextEditingController();
  bool isVisibility = false;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 221, 231, 248),
      body: Stack(children: [buildLayer()]),
    );
  }

  SafeArea buildLayer() {
    return SafeArea(
      child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Center(
            child: SingleChildScrollView(
              // supaya bisa di-scroll
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
                  Padding(
                    padding: const EdgeInsets.all(5),
                    child: Container(
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
                                "Nama",
                                style: TextStyle(color: Color(0xFF4962BF)),
                              ),
                            ],
                          ),
                          BuildTextField(
                            hintText: "Masukkan nama kamu",
                            controller: nameController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Nama tidak boleh kosong";
                              }
                              return null;
                            },
                          ),
                          height(20),
                          Row(
                            children: const [
                              Text(
                                "Email",
                                style: TextStyle(color: Color(0xFF4962BF)),
                              ),
                            ],
                          ),
                          BuildTextField(
                            hintText: "Masukkan email kamu",
                            controller: emailController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Email tidak boleh kosong";
                              } else if (!value.contains('@')) {
                                return "Email tidak valid";
                              } else if (!RegExp(
                                r"^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$",
                              ).hasMatch(value)) {
                                return "Format Email tidak valid";
                              }
                              return null;
                            },
                          ),
                          height(20),
                          Row(
                            children: const [
                              Text(
                                "Nomor Handphone",
                                style: TextStyle(color: Color(0xFF4962BF)),
                              ),
                            ],
                          ),
                          BuildTextField(
                            hintText: "Masukkan nomor handphone kamu",
                            controller: phoneController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Nomor tidak boleh kosong";
                              } else if (value.length < 12) {
                                return "Nomor minimal 12 karakter";
                              }
                              return null;
                            },
                          ),
                          height(20),
                          Row(
                            children: const [
                              Text(
                                "Password",
                                style: TextStyle(color: Color(0xFF4962BF)),
                              ),
                            ],
                          ),
                          BuildTextField(
                            hintText: "Buat password kamu",
                            isPassword: true,
                            controller: passwordController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Password tidak boleh kosong";
                              } else if (value.length < 6) {
                                return "Password minimal 6 karakter";
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  height(20),

                  // ✅ tombol register
                  MoveButton(
                    text: "Register",
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        final UserModel data = UserModel(
                          name: nameController.text,
                          email: emailController.text,
                          password: passwordController.text,
                        );

                        // simpan ke database
                        await DbHelper.registerUser(data);

                        // simpan status login & data user ke preferences
                        await PreferenceHandler.saveLogin(true);
                        await PreferenceHandler.saveUser(data);

                        Fluttertoast.showToast(msg: "Register Berhasil");

                        // pindah ke halaman AboutMe
                        if (mounted) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => Login()),
                          );
                        }
                      }
                    },
                  ),
                  height(15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Sudah punya akun?",
                        style: TextStyle(
                          color: Color.fromARGB(255, 128, 127, 127),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Login(),
                            ),
                          );
                        },
                        child: const Text("Sign in"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  SizedBox height(double height) => SizedBox(height: height);
  SizedBox width(double width) => SizedBox(width: width);
}
