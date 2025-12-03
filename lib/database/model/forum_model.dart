import 'dart:convert';

class ForumModel {
  String? id;
  String? name;
  String? posts;
  String? time;
  String? userId;

  ForumModel({this.id, this.name, this.posts, this.time, this.userId});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'posts': posts,
      'time': time,
      'userId': userId,
    };
  }

  factory ForumModel.fromMap(Map<String, dynamic> map) {
    return ForumModel(
      id: map['id'] != null ? map['id'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      posts: map['posts'] != null ? map['posts'] as String : null,
      time: map['time'] != null ? map['time'] as String : null,
      userId: map['userId'] != null ? map['userId'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ForumModel.fromJson(String source) =>
      ForumModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
