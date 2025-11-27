import 'package:flutter/material.dart';
import 'package:uvol/firebase/models/detail_model_firebase.dart';
import 'package:uvol/views/starting/views/login_firebase.dart';
import 'package:uvol/volunteer/view/question_events.dart';
import 'package:uvol/volunteer/view/question_events_firebase.dart';
import 'package:uvol/widget/widget_%20detail.dart';

class TapEventsFirebase extends StatelessWidget {
  final DetailModelFirebase event;
  const TapEventsFirebase({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE9EFF8),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // ================= IMAGE HEADER =================
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 200,
                  child: Image.asset(event.image!, fit: BoxFit.cover),
                ),

                Positioned(
                  top: 40,
                  left: 15,
                  child: CircleAvatar(
                    backgroundColor: Colors.white.withOpacity(0.8),
                    child: IconButton(
                      icon: Icon(Icons.arrow_back, color: Colors.black),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                ),
              ],
            ),

            // ================= DETAIL CONTENT =================
            Padding(
              padding: const EdgeInsets.all(15),
              child: Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    Text(
                      event.title ?? "",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),

                    SizedBox(height: 15),
                    Text(
                      "Activity Details",
                      style: TextStyle(color: Colors.grey, fontSize: 15),
                    ),
                    SizedBox(height: 8),

                    Row(
                      children: [
                        Icon(Icons.date_range, size: 18),
                        SizedBox(width: 5),
                        Text(event.date ?? ""),
                      ],
                    ),

                    SizedBox(height: 5),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.pin_drop, size: 18),
                        SizedBox(width: 5),
                        Expanded(
                          child: Text(
                            event.location ?? "",
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 20),
                    Divider(),

                    // ================= ABOUT =================
                    Text(
                      "About",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(height: 6),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: event.about!.map((a) => Text("• $a")).toList(),
                    ),

                    SizedBox(height: 15),

                    // ================= REQUIREMENTS =================
                    Text(
                      "Requirements",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(height: 6),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: event.requirements!
                          .asMap()
                          .entries
                          .map((e) => Text("${e.key + 1}. ${e.value}"))
                          .toList(),
                    ),

                    SizedBox(height: 15),

                    // ================= BENEFITS =================
                    Text(
                      "Benefits",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(height: 6),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: event.benefits!
                          .asMap()
                          .entries
                          .map((e) => Text("${e.key + 1}. ${e.value}"))
                          .toList(),
                    ),

                    SizedBox(height: 20),
                    Divider(),

                    // ================= POSITIONS =================
                    Text(
                      "Volunteer Position & Job Description",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(height: 10),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: List.generate(event.positions!.length, (index) {
                        final role = event.positions![index];

                        return Padding(
                          padding: const EdgeInsets.only(bottom: 15),
                          child: buildVolunteerRoleWithPoints(
                            number: index + 1,
                            title: role["title"],
                            points: List<String>.from(role["points"]),
                          ),
                        );
                      }),
                    ),
                  ],
                ),
              ),
            ),

            // ================= BUTTON DAFTAR =================
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
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    "Daftar",
                    style: TextStyle(color: Color(0xFF065EA7)),
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
