import 'dart:convert';

class OrganizerFirebaseModel {
  String? uid;
  String? orgName;
  String? picName;
  String? email;
  String? phone;
  String? orgType;
  String? city;
  String? description;
  String? createdAt;
  String? updatedAt;

  OrganizerFirebaseModel({
    this.uid,
    this.orgName,
    this.picName,
    this.email,
    this.phone,
    this.orgType,
    this.city,
    this.description,
    this.createdAt,
    this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'orgName': orgName,
      'picName': picName,
      'email': email,
      'phone': phone,
      'orgType': orgType,
      'city': city,
      'description': description,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  factory OrganizerFirebaseModel.fromMap(Map<String, dynamic> map) {
    return OrganizerFirebaseModel(
      uid: map['uid'] != null ? map['uid'] as String : null,
      orgName: map['orgName'] != null ? map['orgName'] as String : null,
      picName: map['picName'] != null ? map['picName'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      phone: map['phone'] != null ? map['phone'] as String : null,
      orgType: map['orgType'] != null ? map['orgType'] as String : null,
      city: map['city'] != null ? map['city'] as String : null,
      description: map['description'] != null
          ? map['description'] as String
          : null,
      createdAt: map['createdAt'] != null ? map['createdAt'] as String : null,
      updatedAt: map['updatedAt'] != null ? map['updatedAt'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory OrganizerFirebaseModel.fromJson(String source) =>
      OrganizerFirebaseModel.fromMap(
        json.decode(source) as Map<String, dynamic>,
      );
}
