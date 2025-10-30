import 'package:flutter/material.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';
import 'package:uvol/home.dart';
import 'package:uvol/profile.dart';

// class BottomNav extends StatefulWidget {
//   const BottomNav({super.key});

//   @override
//   State<BottomNav> createState() => _BottomNavState();
// }

// class _BottomNavState extends State<BottomNav> {
//   int _selectedIndex = 0;
//   static const List<Widget> _widgetOptions = [Home(), Profile()];
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: _widgetOptions[_selectedIndex],
//       bottomNavigationBar: StylishBottomBar(
//         items: <BottomBarItem>[
//           Icon(Icons.home_rounded, size: 30),
//           Icon(Icons.list, size: 30),
//           Icon(Icons.compare_arrows, size: 30),
//         ],
//         onTap: (index) {
//           print(index);
//           setState(() {
//             _selectedIndex = index;
//           });
//         },
//       ),
//     );
//   }
// }
