import 'package:flutter/material.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';
import 'package:uvol/volunteer/main%20page/forum_firebase.dart';
import 'package:uvol/volunteer/view/main%20page/events.dart';
import 'package:uvol/volunteer/view/main%20page/forum.dart';
import 'package:uvol/volunteer/view/main%20page/home.dart';
import 'package:uvol/volunteer/view/main%20page/home_firebase.dart';
import 'package:uvol/volunteer/view/profile.dart';
import 'package:uvol/volunteer/main%20page/profile_firebase.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _Tugas8State();
}

class _Tugas8State extends State<BottomNav> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = [
    HomepageFirebase(),
    Events(),
    ForumFirebase(),
    ProfilePageFirebase(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        currentIndex: _selectedIndex,
        selectedItemColor: Color(0xFF4962BF),
        unselectedItemColor: Color(0xFFB6B8C0),
        selectedLabelStyle: TextStyle(color: Color(0xFF4962BF)),
        unselectedLabelStyle: TextStyle(color: Color(0xFFB6B8C0)),
        onTap: (index) {
          print(index);
          setState(() {
            _selectedIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.event), label: "Events"),
          BottomNavigationBarItem(icon: Icon(Icons.message), label: "Forum"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }
}
