import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:uvol/database/db_helper.dart';
import 'package:uvol/database/preferences/preference_handler.dart';
import 'package:uvol/features/sqf/starting/about_me.dart';
import 'package:uvol/features/sqf/starting/register.dart';
import 'package:uvol/widgets/app_images.dart';
import 'package:uvol/widgets/container_widget.dart';
import 'package:uvol/widgets/move_button.dart';

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
                const Text("Login to access your account"),
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
                                ); 
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
