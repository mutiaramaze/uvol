import 'package:flutter/material.dart';
import 'package:uvol/firebase/service/events_firebase.dart';

import 'package:uvol/preferences/preference_handler.dart';
import 'package:uvol/widget/container_widget.dart';

class EventsFirebase extends StatefulWidget {
  const EventsFirebase({super.key});

  @override
  State<EventsFirebase> createState() => _EventsFirebaseState();
}

class _EventsFirebaseState extends State<EventsFirebase> {
  String? uid;

  @override
  void initState() {
    super.initState();
    loadUser();
  }

  void loadUser() async {
    uid = await PreferenceHandler.getUserID();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE9EFF8),
      body: Column(
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
                  "My Events",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ],
            ),
          ),

          if (uid == null)
            Padding(
              padding: EdgeInsets.all(20),
              child: CircularProgressIndicator(),
            )
          else
            Expanded(
              child: StreamBuilder<List<Map<String, dynamic>>>(
                stream: JoinEventService.getMyEvents(uid!),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(child: CircularProgressIndicator());
                  }

                  final events = snapshot.data!;

                  if (events.isEmpty) {
                    return Center(
                      child: Text("Belum ada event yang kamu ikuti."),
                    );
                  }

                  return ListView.separated(
                    separatorBuilder: (c, i) => SizedBox(height: 10),
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    itemCount: events.length,
                    itemBuilder: (context, index) {
                      final event = events[index];

                      return HomeWidget(
                        volImage: event['image'],
                        titleText: event['titleText'],
                        date: event['date'],
                        location: event['location'],
                      );
                    },
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}
