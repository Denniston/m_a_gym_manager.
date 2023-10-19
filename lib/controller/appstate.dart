// import 'package:flutter/cupertino.dart';
// import 'package:flutter/foundation.dart';
// import 'package:m_a_gym_manager/model/class.dart';
// import 'package:m_a_gym_manager/model/coach.dart';
// import 'package:m_a_gym_manager/model/gym.dart';
// import 'package:m_a_gym_manager/model/student.dart';
// import 'package:path/path.dart';
// import 'package:provider/provider.dart';
//
// import '../controller/gym_provider.dart'; // Import the GymProvider
// import '../controller/class_provider.dart'; // Import the ClassProvider
// import '../controller/coach_provider.dart'; // Import the CoachProvider
// import '../controller/student_provider.dart'; // Import the StudentProvider
// import '../controller/syllabus_provider.dart';
// import '../database/gym_app_db.dart';
// import '../model/grade.dart';
// import 'grade_provider.dart';
// import '../model/syllabus.dart'; // Import the SyllabusProvider
//
// class AppState with ChangeNotifier {
//   late final GymAppDB gymAppDb;
//
//   final GymProvider _gymProvider;
//   final ClassProvider _classProvider;
//   final CoachProvider _coachProvider;
//   final StudentProvider _studentProvider;
//   final SyllabusProvider _syllabusProvider;
//   final GradeProvider _gradeProvider;
//
//   AppState(
//     this.gymAppDb,
//     this._gymProvider,
//     this._classProvider,
//     this._coachProvider,
//     this._studentProvider,
//     this._syllabusProvider,
//     this._gradeProvider,
//   );
//
//   GymProvider get gymProvider => _gymProvider;
//
//   List<Gym> _gyms = [];
//   List<Coach> _coaches = [];
//   List<Class> _classes = [];
//   List<Student> _students = [];
//   List<Syllabus> _syllabi = [];
//   List<Grade> _grades = [];
//
//   List<Gym> get gyms => _gyms;
//   List<Coach> get coaches => _coaches;
//   List<Class> get classes => _classes;
//   List<Student> get students => _students;
//   List<Syllabus> get syllabi => _syllabi;
//   List<Grade> get grade => _grades;
//
//   Future<void> loadAllData() async {
//     // Use the respective provider to fetch data
//     _gyms = await _gymProvider.fetchGyms();
//     _coaches = await _coachProvider.fetchCoaches();
//     _classes = await _classProvider.fetchClasses();
//     _students = await _studentProvider.fetchStudents();
//     _grades = await _gradeProvider.fetchGrades();
//     _syllabi = await _syllabusProvider.fetchSyllabi();
//     notifyListeners();
//   }
//
//   //Inserting a Gym
//   Future<void> insertGym(Gym gym) async {
//     await _gymProvider.addGym(gym);
//     await loadAllData();
//   }
//
//   List<Gym> readGyms() {
//     return _gyms;
//   }
//
//   //Updating a Gym
//   Future<void> updateGym(Gym gym) async {
//     await _gymProvider.updateGym(gym);
//     await loadAllData();
//   }
//
//   //Deleting a Gym
//   Future<void> deleteGym(int id) async {
//     await _gymProvider.deleteGym(id);
//     await loadAllData();
//   }
//
//   // Example: Inserting a Coach
//   Future<void> insertCoach(Coach coach) async {
//     await _coachProvider.addCoach(coach);
//     await loadAllData();
//   }
//
//   // Example: Updating a Coach
//   Future<void> updateCoach(Coach coach) async {
//     await _coachProvider.updateCoach(coach);
//     await loadAllData();
//   }
//
//   // Example: Inserting a Class
//   Future<void> insertClass(Class classObj) async {
//     await _classProvider.addClass(classObj);
//     await loadAllData();
//   }
//
//   // Example: Updating a Class
//   Future<void> updateClass(Class classObj) async {
//     await _classProvider.updateClass(classObj);
//     await loadAllData();
//   }
//
//   // Example: Inserting a Student
//   Future<void> insertStudent(Student student) async {
//     await _studentProvider.addStudent(student);
//     await loadAllData();
//   }
//
//   // Example: Updating a Student
//   Future<void> updateStudent(Student student) async {
//     await _studentProvider.updateStudent(student);
//     await loadAllData();
//   }
//
//   // Example: Deleting a Student
//   Future<void> deleteStudent(int id) async {
//     await _studentProvider.deleteStudent(id);
//     await loadAllData();
//   }
// }
