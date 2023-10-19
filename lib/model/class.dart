// class Class {
//   int? id;
//   String name;
//   DateTime start;
//   DateTime end;
//   int length;
//   String specialisation;
//   String coach;
//
//   Class({
//     this.id,
//     required this.name,
//     required this.start,
//     required this.end,
//     required this.length,
//     required this.specialisation,
//     required this.coach,
//   });
//
//   Map<String, dynamic> toMap() {
//     return {
//       'id': id,
//       'name': name,
//       'start': start.toString(),
//       'end': end.toString(),
//       'length': length,
//       'specialisation': specialisation,
//       'coach': coach,
//     };
//   }
//
//   static Class fromMap(Map<String, dynamic> map) {
//     return Class(
//       id: map['id'],
//       name: map['name'],
//       start: DateTime.parse(map['start']),
//       end: DateTime.parse(map['end']),
//       length: map['length'],
//       specialisation: map['specialisation'],
//       coach: map['coach'],
//     );
//   }
// }
class Class {
  int? id;
  String name;
  DateTime start;
  DateTime end;
  int length;
  String specialisation;
  String coach;

  Class({
    this.id,
    required this.name,
    required this.start,
    required this.end,
    required this.length,
    required this.specialisation,
    required this.coach,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'start': start.toIso8601String(),
      'end': end.toIso8601String(),
      'length': length,
      'specialisation': specialisation,
      'coach': coach,
    };
  }

  static Class fromMap(Map<String, dynamic> map) {
    return Class(
      id: map['id'],
      name: map['name'],
      start: DateTime.parse(map['start']),
      end: DateTime.parse(map['end']),
      length: map['length'],
      specialisation: map['specialisation'],
      coach: map['coach'],
    );
  }
}
