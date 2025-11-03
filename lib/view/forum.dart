import 'package:flutter/material.dart';
import 'package:uvol/view/events.dart';
import 'package:uvol/view/make_post.dart';
import 'package:uvol/widget/app_images.dart';

import 'package:uvol/widget/container_widget.dart';

class Forum extends StatefulWidget {
  const Forum({super.key});

  @override
  State<Forum> createState() => _ForumState();
}

class _ForumState extends State<Forum> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE9EFF8),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MakePost()),
          );
        },
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(30),
              decoration: BoxDecoration(
                color: Color(0xFF4962BF),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  Text(
                    "Forum",
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: SearchBar(leading: Icon(Icons.search), hintText: "Search"),
            ),

            ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),

              itemCount: 20,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  margin: EdgeInsets.only(bottom: 15),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 216, 216, 216),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        blurRadius: 5,
                        offset: const Offset(2, 4),
                      ),
                    ],
                  ),
                  child: ForumWidget(
                    initial: 'MG',
                    name: 'Maria Gracia',
                    time: '40 minutes ago',
                    title: 'Tips untuk first timer volunteering',
                    upload:
                        'Halo semuanya! Saya mau berbagi pengalaman pertama kali jadi volunteer. Yang penting adalah datang dengan......',
                    like: '345',
                    comment: '87',
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
