import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uvol/model/events.model.dart';

class EventsFirebaseService {
  static final _ref = FirebaseFirestore.instance.collection("events");

  static Future<void> insertEvents(EventsModel data) async {
    await _ref.add(data.toMap());
  }

  static Future<List<EventsModel>> getAllEvents() async {
    final snap = await _ref.get();
    return snap.docs.map((e) => EventsModel.fromMap(e.data())).toList();
  }

  static Future<void> updateEvents(EventsModel data) async {
    await _ref.doc(data.id).update(data.toMap());
  }

  static Future<void> deleteEvents(String id) async {
    await _ref.doc(id).delete();
  }
}
