import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:uvol/database/db_helper.dart';

import 'package:uvol/model/user_model.dart';
import 'package:uvol/preferences/preference_handler.dart';
import 'package:uvol/view/login.dart';
import 'package:uvol/widget/button.dart';

class Register extends StatefulWidget {
  const Register({super.key});
  static const id = "/register";
  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
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
                  "Please register",
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
                        buildTitle("Nama"),
                        buildTextField(
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
                        buildTitle("Email "),
                        buildTextField(
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
                              "Password",
                              style: TextStyle(color: Color(0xFF4962BF)),
                            ),
                          ],
                        ),
                        buildTitle("Password"),
                        buildTextField(
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
                Button(
                  text: "Register",
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      print(emailController.text);
                      final UserModel data = UserModel(
                        name: nameController.text,
                        email: emailController.text,
                        password: passwordController.text,
                      );
                      DBHelper.registerUser(data);
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

                Container(
                  width: 322,
                  height: 30,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Container(
                          height: 0.5,
                          color: const Color.fromARGB(255, 148, 145, 145),
                        ),
                      ),
                      SizedBox(width: 4),
                      Text(
                        "or",
                        style: TextStyle(
                          color: const Color.fromARGB(255, 148, 145, 145),
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(width: 4),
                      Expanded(
                        child: Container(
                          height: 0.5,
                          color: const Color.fromARGB(255, 148, 145, 145),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 10),

                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF4962BF),
                    fixedSize: Size(250, 40),
                  ),
                  onPressed: () {
                    print("Tekan sekali");
                  },

                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset("assets/images/google.png", height: 20),
                      SizedBox(width: 10),
                      Text(
                        "Login with Google",
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account?",
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

  TextFormField buildTextField({
    String? hintText,
    bool isPassword = false,
    TextEditingController? controller,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      validator: validator,
      controller: controller,
      obscureText: isPassword ? isVisibility : false,
      decoration: InputDecoration(
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: const Color.fromARGB(255, 214, 212, 212).withOpacity(0.2),
            width: 0.5,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.black, width: 1.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: Colors.black.withOpacity(0.2),
            width: 1.0,
          ),
        ),
        suffixIcon: isPassword
            ? IconButton(
                onPressed: () {
                  setState(() {
                    isVisibility = !isVisibility;
                  });
                },
                icon: Icon(
                  isVisibility ? Icons.visibility_off : Icons.visibility,
                ),
              )
            : null,
      ),
    );
  }

  SizedBox height(double height) => SizedBox(height: height);
  SizedBox width(double width) => SizedBox(width: width);

  Widget buildTitle(String text) {
    return Row(children: [
      
      ],
    );
  }
}
