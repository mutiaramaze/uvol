import 'package:cloud_firestore/cloud_firestore.dart';

class QuestionningModelFirebase {
  final String id;
  final String userId;
  final String eventId;
  final String title;
  final String image;
  final String date;
  final String location;
  final String category;

  final String? division1;
  final String? division2;
  final String? division3;

  final String? answer1;
  final String? answer2;
  final String? answer3;

  final String status; 
  final DateTime createdAt;

  QuestionningModelFirebase({
    required this.id,
    required this.userId,
    required this.eventId,
    required this.title,
    required this.image,
    required this.date,
    required this.location,
    required this.category,
    this.division1,
    this.division2,
    this.division3,
    this.answer1,
    this.answer2,
    this.answer3,
    this.status = 'active', 
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "userId": userId,
      "eventId": eventId,
      "title": title,
      "image": image,
      "date": date,
      "location": location,
      "category": category,
      "division1": division1,
      "division2": division2,
      "division3": division3,
      "answer1": answer1,
      "answer2": answer2,
      "answer3": answer3,
      "status": status, 
      "createdAt": Timestamp.fromDate(createdAt),
    };
  }

  factory QuestionningModelFirebase.fromMap(Map<String, dynamic> map) {
    final created = map['createdAt'];
    DateTime createdDt;
    if (created is Timestamp) {
      createdDt = created.toDate();
    } else if (created is String) {
      createdDt = DateTime.tryParse(created) ?? DateTime.now();
    } else {
      createdDt = DateTime.now();
    }

    return QuestionningModelFirebase(
      id: map['id'] ?? '',
      userId: map['userId'] ?? '',
      eventId: map['eventId'] ?? '',
      title: map['title'] ?? '',
      image: map['image'] ?? '',
      date: map['date'] ?? '',
      location: map['location'] ?? '',
      category: map['category'] ?? '',
      division1: map['division1'],
      division2: map['division2'],
      division3: map['division3'],
      answer1: map['answer1'],
      answer2: map['answer2'],
      answer3: map['answer3'],
      status: (map['status'] is String && (map['status'] as String).isNotEmpty)
          ? map['status']
          : 'active',
      createdAt: createdDt,
    );
  }
}
