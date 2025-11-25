import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uvol/database/db_helper.dart';
import 'package:uvol/preferences/preference_handler.dart';
import 'package:uvol/view/starting/about_me.dart';
import 'package:uvol/view/detail_events.dart';
import 'package:uvol/view/main%20page/home.dart';
import 'package:uvol/view/starting/register.dart';
import 'package:uvol/widget/app_images.dart';
import 'package:uvol/widget/bottom_nav.dart';
import 'package:uvol/widget/build_text_field.dart';
import 'package:uvol/widget/move_button.dart';

class LoginFirebase extends StatefulWidget {
  const LoginFirebase({super.key});
  @override
  State<LoginFirebase> createState() => _LoginState();
}

class _LoginState extends State<LoginFirebase> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  bool isVisibility = false;

  final _formKey = GlobalKey<FormState>();

  SizedBox height(double h) => SizedBox(height: h);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Color.fromARGB(255, 221, 231, 248)),
      backgroundColor: Color.fromARGB(255, 221, 231, 248),
      body: buildLayer(context),
    );
  }

  Widget buildLayer(BuildContext context) {
    // supaya kalau keyboard muncul, bisa scroll dan nggak overflow
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return SafeArea(
      child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            padding: EdgeInsets.only(bottom: bottomInset),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                height(30),
                Image.asset(AppImages.uvolpng, height: 100),
                height(15),
                const Text("LoginFirebase to access your account"),
                height(24),

                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Label email
                      const Text(
                        "Email",
                        style: TextStyle(color: Color(0xFF4962BF)),
                      ),
                      BuildTextField(
                        hintText: "Masukkan email anda",
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

                      // Label password
                      const Text(
                        "Password",
                        style: TextStyle(color: Color(0xFF4962BF)),
                      ),
                      BuildTextField(
                        hintText: "Masukkan password kamu",
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

                      height(25),

                      Center(
                        child: MoveButton(
                          text: "Login",
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              print(passwordController.text);
                              PreferenceHandler.saveLogin(true);
                              final data = await DbHelper.loginUser(
                                email: emailController.text,
                                password: passwordController.text,
                              );

                              if (data != null) {
                                await PreferenceHandler.saveLogin(true);
                                await PreferenceHandler.saveUser(
                                  data,
                                ); // simpan data user
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AboutMe(),
                                  ),
                                );
                              } else {
                                Fluttertoast.showToast(
                                  msg: "Email atau password salah",
                                );
                              }
                            } else {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: const Text("Validation Error"),
                                    content: const Text(
                                      "Please fill all fields",
                                    ),
                                    actions: [
                                      TextButton(
                                        child: const Text("OK"),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            }
                          },
                        ),
                      ),

                      height(10),

                      // LINK REGISTER
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Belum punya akun?"),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const Register(),
                                ),
                              );
                            },
                            child: const Text("Register"),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                height(20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
