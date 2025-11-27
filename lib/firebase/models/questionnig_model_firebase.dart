// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class QuestionningModelFirebase {
  String? id;
  String? title;
  String? image;
  String? date;
  String? location;
  String? category;

  // Tambahan untuk Join Event
  String? division1;
  String? division2;
  String? division3;

  String? answer1;
  String? answer2;

  String? timeJoined;

  QuestionningModelFirebase({
    this.id,
    this.title,
    this.image,
    this.date,
    this.location,
    this.category,
    this.division1,
    this.division2,
    this.division3,
    this.answer1,
    this.answer2,
    this.timeJoined,
  });

  // ===========================================================
  // COPYWITH
  // ===========================================================
  QuestionningModelFirebase copyWith({
    String? id,
    String? title,
    String? image,
    String? date,
    String? location,
    String? category,
    String? division1,
    String? division2,
    String? division3,
    String? answer1,
    String? answer2,
    String? timeJoined,
  }) {
    return QuestionningModelFirebase(
      id: id ?? this.id,
      title: title ?? this.title,
      image: image ?? this.image,
      date: date ?? this.date,
      location: location ?? this.location,
      category: category ?? this.category,
      division1: division1 ?? this.division1,
      division2: division2 ?? this.division2,
      division3: division3 ?? this.division3,
      answer1: answer1 ?? this.answer1,
      answer2: answer2 ?? this.answer2,
      timeJoined: timeJoined ?? this.timeJoined,
    );
  }

  // ===========================================================
  // TO MAP
  // ===========================================================
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'image': image,
      'date': date,
      'location': location,
      'category': category,
      'division1': division1,
      'division2': division2,
      'division3': division3,
      'answer1': answer1,
      'answer2': answer2,
      'timeJoined': timeJoined,
    };
  }

  // ===========================================================
  // FROM MAP
  // ===========================================================
  factory QuestionningModelFirebase.fromMap(Map<String, dynamic> map) {
    return QuestionningModelFirebase(
      id: map['id'],
      title: map['title'],
      image: map['image'],
      date: map['date'],
      location: map['location'],
      category: map['category'],
      division1: map['division1'],
      division2: map['division2'],
      division3: map['division3'],
      answer1: map['answer1'],
      answer2: map['answer2'],
      timeJoined: map['timeJoined'],
    );
  }

  // ===========================================================
  // JSON
  // ===========================================================
  String toJson() => json.encode(toMap());

  factory QuestionningModelFirebase.fromJson(String source) =>
      QuestionningModelFirebase.fromMap(json.decode(source));
}
