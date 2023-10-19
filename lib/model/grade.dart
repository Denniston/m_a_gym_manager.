import 'dart:ui';

class Grade {
  int? id;
  Color colour;
  int stripe;

  Grade({
    this.id,
    required this.colour,
    required this.stripe,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'colour': colour,
      'stripe': stripe,
    };
  }

  static Grade fromMap(Map<String, dynamic> map) {
    return Grade(
      id: map['id'],
      colour: map['colour'],
      stripe: map['stripe'],
    );
  }
}
