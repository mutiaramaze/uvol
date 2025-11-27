import 'package:flutter/material.dart';
import 'package:uvol/preferences/preference_handler.dart';
import 'package:uvol/views/starting/views/register_user_firebase.dart';
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
    _navigateUser();
  }

  Future<void> _navigateUser() async {
    await Future.delayed(const Duration(seconds: 3));

    final bool isLogin = await PreferenceHandler.getLogin();
    final String? uid = await PreferenceHandler.getUserID();

    print("CHECK LOGIN => isLogin:$isLogin | uid:$uid");

    if (isLogin == true && uid != null) {
      // langsung masuk ke app tanpa login
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => BottomNav()),
      );
    } else {
      // pertama kali > wajib register
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const RegisterUserFirebase()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF94b7ee),
      body: Center(child: Image.asset(AppImages.uvolfull)),
    );
  }
}
