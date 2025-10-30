import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:uvol/database/db_helper.dart';
import 'package:uvol/home.dart';
import 'package:uvol/widget/app_images.dart';
import 'package:uvol/widget/button.dart';
import 'package:uvol/widget/preferance_handler.dart';

class Login extends StatefulWidget {
  const Login({super.key});
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

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
          padding: const EdgeInsets.all(20.0),

          child: Column(
            children: [
              height(30),
              ListTile(
                leading: Center(child: Image.asset(AppImages.uvol, height: 30)),
              ),

              height(15),
              Text("Login to access your account"),

              height(24),

              Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    buildTextField(
                      hintText: "Masukkan username anda",
                      controller: usernameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Username wajib diisi";
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),

              height(12),
              Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    buildTextField(
                      hintText: "Masukkan password Anda",
                      controller: passwordController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Password wajib diisi";
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),

              Row(
                children: [
                  Text(
                    "Password",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),

              height(30),

              Button(
                text: "Login",
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    print(passwordController.text);
                    PreferanceHandler.saveLogin(true);
                    final data = await DbHelper.loginUser(
                      username: usernameController.text,
                      password: passwordController.text,
                    );
                    print("Hasil dari loginUser: $data");

                    if (data != null) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Home()),
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
            ],
          ),
        ),
      ),
    );
  }

  TextFormField buildTextField({
    String? hintText,

    TextEditingController? controller,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      validator: validator,
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
      ),
    );
  }

  SizedBox height(double height) => SizedBox(height: height);
  SizedBox width(double width) => SizedBox(width: width);
}
