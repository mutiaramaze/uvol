import 'package:flutter/material.dart';
import 'package:uvol/database/preferences/preference_handler_firebase.dart';
import 'package:uvol/features/firebase/auth/register_user_firebase.dart';
import 'package:uvol/widgets/app_images.dart';
import 'package:uvol/widgets/bottom_nav.dart';

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
    await Future.delayed(const Duration(seconds: 2));

    final bool isLogin = await PreferenceHandlerFirebase.getLogin();
    final String? uid = await PreferenceHandlerFirebase.getUserID();

    print("CHECK LOGIN => isLogin:$isLogin | uid:$uid");

    if (!mounted) return;

    if (isLogin && uid != null && uid.isNotEmpty) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => BottomNav()),
      );
    } else {
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
