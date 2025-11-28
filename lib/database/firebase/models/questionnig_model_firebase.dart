class QuestionningModelFirebase {
  String? id;
  String? title;
  String? image;
  String? date;
  String? location;
  String? category;

  String? division1;
  String? division2;
  String? division3;

  String? answer1;
  String? answer2;
  String? answer3;

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
    this.answer3,
  });

  factory QuestionningModelFirebase.fromJson(Map<String, dynamic> json) {
    return QuestionningModelFirebase(
      id: json["id"],
      title: json["title"],
      image: json["image"],
      date: json["date"],
      location: json["location"],
      category: json["category"],
      division1: json["division1"],
      division2: json["division2"],
      division3: json["division3"],
      answer1: json["answer1"],
      answer2: json["answer2"],
      answer3: json["answer3"],
    );
  }

  factory QuestionningModelFirebase.fromMap(Map<String, dynamic> map) {
    return QuestionningModelFirebase(
      id: map["id"],
      title: map["title"],
      image: map["image"],
      date: map["date"],
      location: map["location"],
      category: map["category"],
      division1: map["division1"],
      division2: map["division2"],
      division3: map["division3"],
      answer1: map["answer1"],
      answer2: map["answer2"],
      answer3: map["answer3"],
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "image": image,
    "date": date,
    "location": location,
    "category": category,
    "division1": division1,
    "division2": division2,
    "division3": division3,
    "answer1": answer1,
    "answer2": answer2,
    "answer3": answer3,
  };

  Map<String, dynamic> toMap() => toJson();
}
