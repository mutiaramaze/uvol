import 'dart:convert';

class EventsModel {
  String? id;
  String? title;
  String? date;
  String? location;
  String? image;
  String? category;

  List<String>? about;
  List<String>? requirements;
  List<String>? benefits;
  List<Map<String, dynamic>>? positions;

  EventsModel({
    this.title,
    this.date,
    this.location,
    this.image,
    this.category,
    this.about,
    this.requirements,
    this.benefits,
    this.positions,
  });

  factory EventsModel.fromJson(Map<String, dynamic> json) {
    return EventsModel(
      title: json['title'],
      date: json['date'],
      location: json['location'],
      image: json['image'],
      category: json['category'],
      about: json['about'] != null ? List<String>.from(json['about']) : [],
      requirements: json['requirements'] != null
          ? List<String>.from(json['requirements'])
          : [],
      benefits: json['benefits'] != null
          ? List<String>.from(json['benefits'])
          : [],
      positions: json['positions'] != null
          ? List<Map<String, dynamic>>.from(json['positions'])
          : [],
    );
  }

  factory EventsModel.fromMap(Map<String, dynamic> map) {
    return EventsModel.fromJson(map);
  }

  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "date": date,
      "location": location,
      "image": image,
      "category": category,
      "about": about,
      "requirements": requirements,
      "benefits": benefits,
      "positions": positions,
    };
  }

  Map<String, dynamic> toMap() {
    return toJson();
  }

  String encode() => json.encode(toJson());

  factory EventsModel.decode(String source) =>
      EventsModel.fromJson(json.decode(source) as Map<String, dynamic>);
}
