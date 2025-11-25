// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class EventsModel {
  String? id;
  String? image;
  String? title;
  String? icon;
  String? date;
  String? location;

  EventsModel({
    this.id,
    this.image,
    this.title,
    this.icon,
    this.date,
    this.location,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'image': image,
      'title': title,
      'icon': icon,
      'date': date,
      'location': location,
    };
  }

  factory EventsModel.fromMap(Map<String, dynamic> map) {
    return EventsModel(
      id: map['id'] != null ? map['id'] as String : null,
      image: map['image'] != null ? map['image'] as String : null,
      title: map['title'] != null ? map['title'] as String : null,
      icon: map['icon'] != null ? map['icon'] as String : null,
      date: map['date'] != null ? map['date'] as String : null,
      location: map['location'] != null ? map['location'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory EventsModel.fromJson(String source) =>
      EventsModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
