import 'dart:convert';

class AboutmeFirebaseModel {
  final String? storyaboutme;
  final String? skill;
  final String? cv;

  AboutmeFirebaseModel({this.storyaboutme, this.skill, this.cv});

  Map<String, dynamic> toMap() {
    return {'storyaboutme': storyaboutme, 'skill': skill, 'cv': cv};
  }

  factory AboutmeFirebaseModel.fromMap(Map<String, dynamic> map) {
    return AboutmeFirebaseModel(
      storyaboutme: map['storyaboutme'] as String?,
      skill: map['skill'] as String?,
      cv: map['cv'] as String?,
    );
  }

  String toJson() => json.encode(toMap());

  factory AboutmeFirebaseModel.fromJson(String source) =>
      AboutmeFirebaseModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
