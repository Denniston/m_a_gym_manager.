class Speciality {
  int? id;
  String name;

  Speciality({
    this.id,
    required this.name,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }

  static Speciality fromMap(Map<String, dynamic> map) {
    return Speciality(
      id: map['id'],
      name: map['name'],
    );
  }
}
