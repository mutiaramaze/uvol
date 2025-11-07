import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:uvol/database/db_helper.dart';
import 'package:uvol/model/user_model.dart';
import 'package:uvol/preferences/preference_handler.dart';
import 'package:uvol/view/login.dart';
import 'package:uvol/widget/build_text_field.dart';
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
  final nohpController = TextEditingController();
  bool isVisibility = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 221, 231, 248),
      body: Stack(children: [buildLayer()]),
    );
  }

  final _formKey = GlobalKey<FormState>();
  SafeArea buildLayer() {
    return SafeArea(
      child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Hello volunteers!",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2E2E5D),
                  ),
                ),
                SizedBox(height: 5),
                Text(
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
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
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
                          children: [
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
                          children: [
                            Text(
                              "Nomor Handphone",
                              style: TextStyle(color: Color(0xFF4962BF)),
                            ),
                          ],
                        ),
                        BuildTextField(
                          hintText: "Masukkan nomor handphone kamu",
                          controller: nohpController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Nomor tidak boleh kosong";
                            } else if (value.length < 6) {
                              return "Nomor minimal 12 karakter";
                            }
                            return null;
                          },
                        ),
                        height(20),
                        Row(
                          children: [
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
                MoveButton(
                  text: "Register",
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      print(emailController.text);
                      final UserModel data = UserModel(
                        name: nameController.text,
                        email: emailController.text,
                        password: passwordController.text,
                      );
                      DbHelper.registerUser(data);
                      Fluttertoast.showToast(msg: "Register Berhasil");
                      PreferenceHandler.saveLogin(true);
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Login()),
                      );
                    }
                  },
                ),

                height(15),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Sudah punya akun?",
                      style: TextStyle(
                        color: const Color.fromARGB(255, 128, 127, 127),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        print("Tombol teks ditekan");
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Login()),
                        );
                      },
                      child: Text("Sign in"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  SizedBox height(double height) => SizedBox(height: height);
  SizedBox width(double width) => SizedBox(width: width);
}
