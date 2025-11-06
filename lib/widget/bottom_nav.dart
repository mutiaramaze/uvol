import 'package:flutter/material.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';
import 'package:uvol/view/events.dart';
import 'package:uvol/view/forum.dart';
import 'package:uvol/view/home.dart';
import 'package:uvol/view/profile.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _Tugas8State();
}

class _Tugas8State extends State<BottomNav> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = [
    Homepage(),
    Events(),
    Forum(),
    ProfilePage(),
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
