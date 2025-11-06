import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uvol/view/events.dart';
import 'package:uvol/widget/app_images.dart';

class TapEvents extends StatefulWidget {
  const TapEvents({super.key});

  @override
  State<TapEvents> createState() => _TapEventsState();
}

class _TapEventsState extends State<TapEvents> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 221, 231, 248),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 200,
                  child: Image.asset(AppImages.v3, fit: BoxFit.cover),
                ),

                Positioned(
                  top: 40,
                  left: 15,
                  right: 15,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.white.withOpacity(0.8),
                        child: IconButton(
                          icon: Icon(Icons.arrow_back, color: Colors.black),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            Padding(
              padding: const EdgeInsets.all(15),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),

                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Scent of Indonesia",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      height(15),
                      Text(
                        "Activity Details",
                        style: TextStyle(color: Colors.grey, fontSize: 15),
                      ),
                      height(8),
                      Row(
                        children: [
                          Icon(Icons.date_range, size: 18),
                          width(5),
                          Text("12-14 Desember 2025"),
                        ],
                      ),
                      height(5),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.pin_drop, size: 18),
                          width(5),
                          Expanded(
                            child: Text(
                              "Pasaraya, Blok M, Jakarta Selatan",
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),

                      height(20),
                      Divider(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'About',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          Text(
                            "Experience it from the inside, be part of Indonesia's first local fragrance market behind the scenes!",
                          ),
Text(
                            'Requirements',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          Text(
                            "1. Minimum age: 17 years old.",
Text("2. Willing to fully participate in our event for 3 days (12-14 December 2025)."
                          ),
Text(
                            'Benefits',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          Text(
                            "1. Networking",
                          ),
Text("2. Konsumsi 2x sehari (Selama event)"),
Text("3. Fee IDR300,000 (Nominal total selama event)"),
Text("4. ID card"),
Text("5. E-certificate"),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Align(
                alignment: Alignment.bottomRight,
                child: ElevatedButton(
                  onPressed: () async {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          "Kamu berhasil terdaftar! Silahkan tunggu konfirmasi",
                          style: TextStyle(color: Colors.white),
                        ),
                        backgroundColor: Color(0xFF4962BF),
                        duration: Duration(seconds: 1),
                      ),
                    );
                    Future.delayed(Duration(seconds: 2), () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => Events()),
                      );
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 255, 255, 255),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    'Daftar',
                    style: TextStyle(
                      color: const Color.fromARGB(255, 6, 94, 167),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

SizedBox height(double height) => SizedBox(height: height);
SizedBox width(double width) => SizedBox(width: width);
