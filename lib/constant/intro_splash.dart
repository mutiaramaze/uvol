import 'package:flutter/material.dart';
import 'package:uvol/preferences/preference_handler.dart';
import 'package:uvol/view/starting/login.dart';
import 'package:uvol/view/starting/about_me.dart';
import 'package:uvol/view/starting/login_firebase.dart';
import 'package:uvol/view/starting/register.dart';
import 'package:uvol/view/starting/register_firebase.dart';
import 'package:uvol/widget/app_images.dart';
import 'package:uvol/widget/bottom_nav.dart';

class IntroSplash extends StatefulWidget {
  const IntroSplash({super.key});

  @override
  State<IntroSplash> createState() => _IntroSplashState();
}

class _IntroSplashState extends State<IntroSplash> {
  @override
  void initState() {
    super.initState();
    isLoginFunction();
  }

  isLoginFunction() async {
    Future.delayed(const Duration(seconds: 3)).then((value) async {
      bool isLogin = await PreferenceHandler.getLogin();
      print("isLogin: $isLogin");

      if (isLogin) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => BottomNav()),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const RegisterFirebase()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF94b7ee),
      body: Center(child: Image.asset(AppImages.uvolfull)),
    );
  }
}
