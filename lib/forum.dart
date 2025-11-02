import 'package:flutter/material.dart';
import 'package:uvol/events.dart';
import 'package:uvol/widget/app_images.dart';

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
                  child: Column(
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                        ),
                      ),
                      height(5),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          children: [
                            CircleAvatar(radius: 30, child: Text("MG")),
                            width(15),

                            Column(
                              // crossAxisAlignment: CrossAxisAlignment.start,
                              // mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "Maria Gracia",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text("40 minutes ago"),
                              ],
                            ),
                          ],
                        ),
                      ),
                      height(20),
                      Column(
                        children: [
                          Text(
                            "Tips untuk first timer volunteers",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "Halo semuanya! Saya mau berbagi pengalaman pertama kali jadi volunteer. Yang penting adalah datang dengan......",
                          ),

                          Divider(color: Colors.grey, thickness: 0.5),

                          Row(
                            children: [
                              Icon(Icons.leak_remove_rounded),
                              Text("456"),
                              width(5),
                              Icon(Icons.comment),
                              Text("20"),
                            ],
                          ),
                        ],
                      ),
                    ],
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
