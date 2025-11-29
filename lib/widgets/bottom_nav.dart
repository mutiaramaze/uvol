import 'package:flutter/material.dart';
import 'package:uvol/features/firebase/main%20page/forum_firebase.dart';
import 'package:uvol/features/firebase/main%20page/events_firebase.dart';
import 'package:uvol/features/firebase/main%20page/home_firebase.dart';
import 'package:uvol/features/firebase/main%20page/profile_firebase.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _Tugas8State();
}

class _Tugas8State extends State<BottomNav> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = [
    HomepageFirebase(),
    EventsFirebase(),
    ForumFirebase(),
    ProfilePageFirebase(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        elevation: 0,
        backgroundColor: Colors.white,
        currentIndex: _selectedIndex,
        selectedItemColor: const Color(0xFF4962BF),
        unselectedItemColor: const Color(0xFFB6B8C0),

        selectedLabelStyle: const TextStyle(color: Color(0xFF4962BF)),
        unselectedLabelStyle: const TextStyle(color: Color(0xFFB6B8C0)),

        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },

        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.event), label: "My Events"),
          BottomNavigationBarItem(icon: Icon(Icons.message), label: "Forum"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }
}
