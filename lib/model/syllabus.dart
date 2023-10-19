class Syllabus {
  int? id;
  String name;
  String chapter;

  Syllabus({
    this.id,
    required this.name,
    required this.chapter,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'chapters': chapter,
    };
  }

  static Syllabus fromMap(Map<String, dynamic> map) {
    return Syllabus(
      id: map['id'],
      name: map['name'],
      chapter: map['chapters'],
    );
  }
}
