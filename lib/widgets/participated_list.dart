import 'package:flutter/material.dart';
import 'package:uvol/database/firebase/models/questionning_firebase_model.dart';
import 'package:uvol/database/firebase/service/events_firebase.dart';
import 'package:uvol/widgets/my_event_container.dart';

class ParticipatedList extends StatelessWidget {
  final String uid;
  const ParticipatedList({super.key, required this.uid});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<QuestionningModelFirebase>>(
      stream: JoinEventService.streamCompletedEvents(uid),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Padding(
            padding: EdgeInsets.all(20),
            child: Center(child: CircularProgressIndicator()),
          );
        }

        final events = snapshot.data!;

        if (events.isEmpty) {
          return const Padding(
            padding: EdgeInsets.all(20),
            child: Text("Belum ada event yang selesai."),
          );
        }

        return ListView.separated(
          physics:
              const NeverScrollableScrollPhysics(), 
          shrinkWrap: true,
          separatorBuilder: (_, __) => const SizedBox(height: 10),
          itemCount: events.length,
          itemBuilder: (context, index) {
            final e = events[index];

            return MyEventContainer(
              volImage: e.image ?? "",
              titleText: e.title ?? "",
              date: e.date ?? "",
              location: e.location ?? "",
              onTap: () {}, 
              onComplete: null, 
            );
          },
        );
      },
    );
  }
}
