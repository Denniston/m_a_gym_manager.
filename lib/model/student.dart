class Student {
  int? id;
  final String? profileImage;
  final String? coverImage;
  String firstName;
  String lastName;
  int age;
  DateTime dob;
  String email;
  String? phone;
  String? address;

  Student({
    this.id,
    this.profileImage,
    this.coverImage,
    required this.firstName,
    required this.lastName,
    required this.age,
    required this.dob,
    required this.email,
    this.phone,
    this.address,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'profileImage': profileImage,
      'coverImage': coverImage,
      'firstName': firstName,
      'lastName': lastName,
      'age': age,
      'dob': dob.toString(),
      'email': email,
      'phone': phone,
      'address': address,
    };
  }

  static Student fromMap(Map<String, dynamic> map) {
    return Student(
      id: map['id'],
      profileImage: map['profileImage'],
      coverImage: map['coverImage'],
      firstName: map['firstName'],
      lastName: map['lastName'],
      age: map['age'],
      dob: DateTime.parse(map['dob']),
      email: map['email'],
      phone: map['phone'],
      address: map['address'],
    );
  }
}
