import 'package:flutter/material.dart';
import 'package:uvol/constant/intro_splash.dart';
import 'package:uvol/view/starting/about_me.dart';
import 'package:uvol/view/main%20page/events.dart';
import 'package:uvol/view/main%20page/forum.dart';
import 'package:uvol/view/main%20page/home.dart';
import 'package:uvol/view/starting/login.dart';
import 'package:uvol/view/make_post.dart';
import 'package:uvol/view/profile.dart';
import 'package:uvol/view/starting/register.dart';
import 'package:uvol/widget/bottom_nav.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UVol',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF4962BF)),
        useMaterial3: true,
      ),

      // 👇 GANTI halaman awal ke Splash Screen
      home: const IntroSplash(),

      // 👇 Tambahkan route agar bisa navigasi ke halaman lain dengan mudah
      routes: {
        '/home': (context) => const Homepage(),
        '/events': (context) => const Events(),
        '/forum': (context) => const Forum(),
        '/make_post': (context) => const MakePost(),
        '/profile': (context) => const ProfilePage(),
        '/login': (context) => const Login(),
        '/register': (context) => const Register(),
        '/about_me': (context) => AboutMe(),
        '/bottom_nav': (context) => const BottomNav(),
      },
    );
  }
}
