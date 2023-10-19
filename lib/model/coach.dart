import 'dart:ui';

class Coach {
  final int? id;
  final String specialization;
  final String firstName;
  final String lastName;
  final String email;
  DateTime? dob;
  final String? age;
  final String phone;
  final String? address;
  final String? profileImage;
  final String? coverImage;

  Coach({
    this.id,
    required this.firstName,
    required this.lastName,
    required this.specialization,
    required this.email,
    this.dob,
    this.age,
    required this.phone,
    this.address,
    this.profileImage,
    this.coverImage,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'specialization': specialization,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'age': age,
      'dob': dob,
      'phone': phone,
      'address': address,
      'profileImage': profileImage,
      'coverImage': coverImage,
    };
  }

  static Coach fromMap(Map<String, dynamic> map) {
    return Coach(
      id: map['id'],
      firstName: map['firstName'],
      lastName: map['lastName'],
      specialization: map['specialization'],
      email: map['email'],
      phone: map['phone'],
      address: map['address'],
      profileImage: map['profileImage'],
      coverImage: map['coverImage'],
      age: map['age'],
    );
  }
}
