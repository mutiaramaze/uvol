import 'package:flutter/material.dart';
import 'package:uvol/events.dart';
import 'package:uvol/widget/app_images.dart';
import 'package:uvol/widget/button.dart';

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
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Color(0xFF4962BF),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(25),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Profile",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                        IconButton(
                          icon: Icon(Icons.settings),
                          onPressed: () {
                            print("Ikon di klik");
                          },
                        ),
                      ],
                    ),
                    height(20),
                    Row(
                      children: [
                        const CircleAvatar(radius: 40),
                        width(15),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Rizni Mutiara Farannita",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                            Text(
                              "@mufarannita@gmail.com",
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ],
                    ),
                    height(20),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(30),
                            decoration: BoxDecoration(
                              color: Color(0xFFD9D9D9),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Column(children: [Text("yep")]),
                          ),
                        ),

                        width(15),
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(30),
                            decoration: BoxDecoration(
                              color: Color(0xFFD9D9D9),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Column(children: [Text("20 Partisipasi")]),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            height(10),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text("Participated", style: TextStyle(color: Colors.black)),
              ],
            ),
            Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListTile(
                leading: Image.asset(AppImages.v2),
                title: Text("Beach Cleanup"),
                subtitle: Column(
                  children: [
                    Row(
                      children: [
                        Icon(Icons.date_range),
                        Text("Sat, 12th April"),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.time_to_leave),
                        Text("9.30 AM - 11.00 AM"),
                      ],
                    ),
                    Row(children: [Icon(Icons.pin)]),
                    Text("Pantai Anyer, Banten"),
                  ],
                ),
              ),
            ),

            ElevatedButton(
              onPressed: () {
                print("Tekan sekali");
              },
              child: Text("Logout"),
            ),
          ],
        ),
      ),
    );
  }
}
