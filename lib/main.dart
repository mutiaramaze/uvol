import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:uvol/constant/intro_splash.dart';
import 'package:uvol/firebase_options.dart';
import 'package:uvol/starting/register_choice.dart';
import 'package:uvol/volunteer/view/starting/about_me.dart';
import 'package:uvol/volunteer/view/main%20page/events.dart';
import 'package:uvol/volunteer/view/main%20page/forum.dart';
import 'package:uvol/volunteer/view/main%20page/home.dart';
import 'package:uvol/volunteer/view/starting/login.dart';
import 'package:uvol/volunteer/view/make_post.dart';
import 'package:uvol/volunteer/view/profile.dart';
import 'package:uvol/volunteer/view/starting/register.dart';
import 'package:uvol/widget/bottom_nav.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('id_ID', null);
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
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
      home: const BottomNav(),

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
