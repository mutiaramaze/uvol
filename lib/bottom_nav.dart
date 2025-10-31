import 'package:flutter/material.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';
import 'package:uvol/events.dart';
import 'package:uvol/forum.dart';
import 'package:uvol/home.dart';
import 'package:uvol/profile.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _Tugas8State();
}

class _Tugas8State extends State<BottomNav> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = [
    Home(),
    Events(),
    Forum(),
    Profile(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
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
