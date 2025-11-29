import 'package:flutter/material.dart';
import 'package:uvol/database/dummy/detail_events.dart';
import 'package:uvol/features/sqf/details/question_events.dart';
import 'package:uvol/widgets/app_images.dart';
import 'package:uvol/widgets/widget_%20detail.dart';

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
                  child: Image.asset(AppImages.soi, fit: BoxFit.cover),
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
                          height(8),
                          Text(
                            'Requirements',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),

                          Text("1. Minimum age: 17 years old."),
                          Text(
                            "2. Willing to fully participate in our event for 3 days (12-14 December 2025).",
                          ),
                          height(8),
                          Text(
                            'Benefits',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          Text("1. Networking"),
                          Text("2. Konsumsi 2x sehari (Selama event)"),
                          Text(
                            "3. Fee IDR300,000 (Nominal total selama event)",
                          ),
                          Text("4. ID card"),
                          Text("5. E-certificate"),
                          height(10),

                          Divider(),
                          height(10),
                          Text(
                            'Volunteer Position & Job Description',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: List.generate(volunteerRoles.length, (
                              index,
                            ) {
                              final role = volunteerRoles[index];
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 15),
                                child: buildVolunteerRoleWithPoints(
                                  number: index + 1, 
                                  title: role['title']!,
                                  points: List<String>.from(role['points']!),
                                ),
                              );
                            }),
                          ),
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
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => QuestioningEvent(),
                      ),
                    );
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
