import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first

class AboutmeFirebaseModel {
  String? id;
  String? storyaboutme;
  String? skill;
  String? cv;

  AboutmeFirebaseModel({this.id, this.storyaboutme, this.skill, this.cv});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'storyaboutme': storyaboutme,
      'skill': skill,
      'cv': cv,
    };
  }

  factory AboutmeFirebaseModel.fromMap(Map<String, dynamic> map) {
    return AboutmeFirebaseModel(
      id: map['id'] != null ? map['id'] as String : null,
      storyaboutme: map['storyaboutme'] != null
          ? map['storyaboutme'] as String
          : null,
      skill: map['skill'] != null ? map['skill'] as String : null,
      cv: map['cv'] != null ? map['cv'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory AboutmeFirebaseModel.fromJson(String source) =>
      AboutmeFirebaseModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
