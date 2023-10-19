// import 'package:flutter/material.dart';
// import 'package:m_a_gym_manager/model/student.dart';
// import 'package:provider/provider.dart';
//
// import '../database/gym_app_db.dart';
//
// class StudentProvider extends ChangeNotifier {
//   late final GymAppDB gymAppDb;
//
//   List<Student> students = [];
//
//   void addStudent(Student student) {
//     students.add(student);
//     notifyListeners();
//   }
//
//   List<Student> readStudent() {
//     return students;
//   }
//
//   void updateStudent(List<Student> students) {
//     this.students = students;
//     notifyListeners();
//   }
//
//   void deleteStudent(int id) {
//     students.removeWhere((student) => student.id == id);
//     notifyListeners();
//   }
//
//   insertStudent(Student student) {}
// }
import 'package:flutter/foundation.dart';
import 'package:m_a_gym_manager/model/student.dart';

import '../database/gym_app_db.dart';

class StudentProvider with ChangeNotifier {
  late final GymAppDB gymAppDb;

  List<Student> _students = [];

  // Add a getter to access the list of students
  List<Student> get students => _students;

  Future fetchStudents() async {
    final students = await gymAppDb.fetchStudents();
    // Assign students to the private _students variable
    _students = students;
    notifyListeners();
  }

  // Create a method to add a student to the list
  Future<void> addStudent(Student student) async {
    await gymAppDb.createStudent(
      firstName: student.firstName,
      lastName: student.lastName,
      address: student.address,
      profileImage: student.profileImage,
      coverImage: student.coverImage,
      email: student.email,
      phone: student.phone,
      age: student.age,
      dob: student.dob,
    );
    // Refresh the list of students
    await fetchStudents();
    notifyListeners();
  }

  // Update a student in the database
  Future<void> updateStudent(Student student) async {
    // Call the updateStudent method from GymAppDB
    await gymAppDb.updateStudent(
      id: student.id,
      firstName: student.firstName,
      lastName: student.lastName,
      address: student.address,
      email: student.email,
      phone: student.phone,
      profileImage: student.profileImage,
      coverImage: student.coverImage,
      dob: student.dob,
      age: student.age,
    );

    // Refresh the list of students
    await fetchStudents();
    notifyListeners();
  }

  Future<void> deleteStudent(int id) async {
    // Call the deleteStudent method from GymAppDB
    await gymAppDb.deleteStudent(id);

    // Refresh the list of students
    await fetchStudents();
    notifyListeners();
  }
}
