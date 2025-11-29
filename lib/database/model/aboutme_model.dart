import 'dart:convert';


class AboutModel {
  String? id;
  String? storyaboutme;
  String? skill;
  String? cv;

  AboutModel({this.id, this.storyaboutme, this.skill, this.cv});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'storyaboutme': storyaboutme,
      'skill': skill,
      'cv': cv,
    };
  }

  factory AboutModel.fromMap(Map<String, dynamic> map) {
    return AboutModel(
      id: map['id'] != null ? map['id'] as String : null,
      storyaboutme: map['storyaboutme'] != null
          ? map['storyaboutme'] as String
          : null,
      skill: map['skill'] != null ? map['skill'] as String : null,
      cv: map['cv'] != null ? map['cv'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory AboutModel.fromJson(String source) =>
      AboutModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
