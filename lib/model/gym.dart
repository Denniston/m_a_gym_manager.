//import 'dart:ui';

class Gym {
  int? id;
  String name;
  String email;
  int phone;
  String address;
  late String? profileImage;
  String manager;

  Gym({
    this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.address,
    this.profileImage,
    required this.manager,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'address': address,
      'profileImage': profileImage,
      'manager': manager,
    };
  }

  factory Gym.fromSqfliteDatabase(Map<String, dynamic> map) => Gym(
        id: map['id']?.toInt() ?? 0,
        name: map['name'] ?? '',
        email: map['email'] ?? '',
        phone: map['phone'] ?? '',
        address: map['address'] ?? '',
        profileImage: map['profileImage'] ?? '',
        manager: map['manager'] ?? '',
      );

  static Gym fromMap(Map<String, dynamic> map) {
    return Gym(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      phone: map['phone'],
      address: map['address'],
      profileImage: map['profileImage'],
      manager: map['manager'],
    );
  }
}
