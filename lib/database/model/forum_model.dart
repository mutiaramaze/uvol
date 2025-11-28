// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ForumModel {
  String? id;
  String? name;
  String? posts;
  String? time;

  ForumModel({this.id, this.name, this.posts, this.time});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'posts': posts,
      'time': time,
    };
  }

  factory ForumModel.fromMap(Map<String, dynamic> map) {
    return ForumModel(
      id: map['id'] != null ? map['id'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      posts: map['posts'] != null ? map['posts'] as String : null,
      time: map['time'] != null ? map['time'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ForumModel.fromJson(String source) =>
      ForumModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
