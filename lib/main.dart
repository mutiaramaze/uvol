import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:uvol/constant/intro_splash.dart';
import 'package:uvol/firebase_options.dart';
import 'package:uvol/features/firebase/main%20page/events_firebase.dart';
import 'package:uvol/features/firebase/main%20page/forum_firebase.dart';
import 'package:uvol/features/firebase/main%20page/home_firebase.dart';
import 'package:uvol/features/firebase/main%20page/profile_firebase.dart';
import 'package:uvol/features/admin/register_choice.dart';
import 'package:uvol/features/firebase/auth/login_firebase.dart';
import 'package:uvol/features/firebase/auth/register_user_firebase.dart';
import 'package:uvol/features/firebase/auth/about_me_firebase.dart';
import 'package:uvol/features/firebase/details/make_post_firebase.dart';
import 'package:uvol/features/sqf/starting/about_me.dart';
import 'package:uvol/features/sqf/main%20page/events.dart';
import 'package:uvol/features/sqf/main%20page/forum.dart';
import 'package:uvol/features/sqf/main%20page/home.dart';
import 'package:uvol/features/sqf/starting/login.dart';
import 'package:uvol/features/sqf/details/make_post.dart';
import 'package:uvol/features/sqf/main%20page/profile.dart';
import 'package:uvol/features/sqf/starting/register.dart';
import 'package:uvol/widgets/bottom_nav.dart';
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
      home: const IntroSplash(),

      // 👇 Tambahkan route agar bisa navigasi ke halaman lain dengan mudah
      routes: {
        '/home': (context) => const HomepageFirebase(),
        '/events': (context) => const EventsFirebase(),
        '/forum': (context) => const ForumFirebase(),
        '/make_post': (context) => const MakePostFirebase(),
        '/profile': (context) => const ProfilePageFirebase(),
        '/login': (context) => const LoginFirebase(),
        '/register': (context) => const RegisterUserFirebase(),
        '/about_me': (context) => AboutMeFirebase(),
        '/bottom_nav': (context) => const BottomNav(),
      },
    );
  }
}
