import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uvol/database/db_helper.dart';
import 'package:uvol/preferences/preference_handler.dart';
import 'package:uvol/view/starting/about_me.dart';
import 'package:uvol/view/detail_events.dart';
import 'package:uvol/view/main%20page/home.dart';
import 'package:uvol/widget/app_images.dart';
import 'package:uvol/widget/bottom_nav.dart';
import 'package:uvol/widget/build_text_field.dart';
import 'package:uvol/widget/move_button.dart';

class Login extends StatefulWidget {
  const Login({super.key});
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  bool isVisibility = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Color.fromARGB(255, 221, 231, 248)),
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
          padding: const EdgeInsets.all(20.0),

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              height(30),

              Image.asset(AppImages.uvolpng, height: 100),
              height(15),
              Text("Login to access your account"),
              height(24),

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
                            "Email",
                            style: TextStyle(color: Color(0xFF4962BF)),
                          ),
                        ],
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
                      Row(
                        children: [
                          Text(
                            "Password",
                            style: TextStyle(color: Color(0xFF4962BF)),
                          ),
                        ],
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
                    ],
                  ),
                ),
              ),

              height(30),

              MoveButton(
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
                        MaterialPageRoute(builder: (context) => AboutMe()),
                      );
                    } else {
                      Fluttertoast.showToast(msg: "Email atau password salah");
                    }
                  } else {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text("Validation Error"),
                          content: Text("Please fill all fields"),
                          actions: [
                            TextButton(
                              child: Text("OK"),
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
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
