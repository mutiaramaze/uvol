import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE9EFF8),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(110),
          decoration: BoxDecoration(
            color: Color(0xFF4962BF),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            children: [
              Text(
                "Profile",
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
              Spacer(),
              Icon(Icons.settings, color: Colors.white),
            ],
          ),
        ),
      ),
    );
  }
}
