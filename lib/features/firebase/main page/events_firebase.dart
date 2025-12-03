import 'package:flutter/material.dart';
import 'package:uvol/database/firebase/models/questionning_firebase_model.dart';
import 'package:uvol/database/firebase/service/events_firebase.dart';
import 'package:uvol/database/preferences/preference_handler.dart';
import 'package:uvol/widgets/my_event_container.dart';

class EventsFirebase extends StatefulWidget {
  const EventsFirebase({super.key});

  @override
  State<EventsFirebase> createState() => _EventsFirebaseState();
}

class _EventsFirebaseState extends State<EventsFirebase> {
  late BuildContext rootContext;
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

  Future<void> _markCompleted(
    BuildContext ctx,
    QuestionningModelFirebase ev,
  ) async {
    if (uid == null) {
      ScaffoldMessenger.of(
        ctx,
      ).showSnackBar(const SnackBar(content: Text("User not logged in")));
      return;
    }

    showDialog(
      context: ctx,
      barrierDismissible: false,
      builder: (_) => const Center(child: CircularProgressIndicator()),
    );

    try {
      await JoinEventService.updateStatus(
        userId: uid!,
        eventId: ev.id,
        status: "completed",
      );

      Navigator.of(ctx).pop(); 
      ScaffoldMessenger.of(
        ctx,
      ).showSnackBar(const SnackBar(content: Text("Event marked completed")));
    } catch (e) {
      Navigator.of(ctx).pop(); 
      ScaffoldMessenger.of(
        ctx,
      ).showSnackBar(SnackBar(content: Text("Gagal mengubah status: $e")));
    }
  }

  @override
  Widget build(BuildContext context) {
    rootContext = context;
    return Scaffold(
      backgroundColor: const Color(0xFFE9EFF8),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(30),
            decoration: BoxDecoration(
              color: const Color(0xFF4962BF),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Row(
              children: [
                Text(
                  "My Events",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ],
            ),
          ),

          if (uid == null)
            const Padding(
              padding: EdgeInsets.all(20),
              child: CircularProgressIndicator(),
            )
          else
            Expanded(
              child: StreamBuilder<List<QuestionningModelFirebase>>(
                stream: JoinEventService.streamActiveEvents(uid!),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  final events = snapshot.data!;

                  if (events.isEmpty) {
                    return const Center(
                      child: Text("Belum ada event yang kamu ikuti."),
                    );
                  }

                  return ListView.separated(
                    separatorBuilder: (c, i) => const SizedBox(height: 10),
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    itemCount: events.length,
                    itemBuilder: (context, index) {
                      final event = events[index];

                      return MyEventContainer(
                        onComplete: () {
                          _markCompleted(rootContext, event);
                        },
                        volImage: event.image ?? "",
                        titleText: event.title ?? "",
                        date: event.date ?? "",
                        location: event.location ?? "",
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
