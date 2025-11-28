class DetailModelFirebase {
  String? title;
  String? date;
  String? location;
  String? image;
  String? category;

  List<String>? about;
  List<String>? requirements;
  List<String>? benefits;
  List<Map<String, dynamic>>? positions;

  DetailModelFirebase({
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

  factory DetailModelFirebase.fromJson(Map<String, dynamic> json) {
    return DetailModelFirebase(
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
}
