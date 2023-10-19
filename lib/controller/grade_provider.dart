import 'package:flutter/material.dart';

import '../database/gym_app_db.dart';
import '../model/grade.dart';

class GradeProvider with ChangeNotifier {
  late final GymAppDB gymAppDb;

  //Read all grades in database
  Future fetchGrades() async {
    final grades = await gymAppDb.fetchGrades();
    // Assign grades to the private _grades variable
    _grades = grades;
    notifyListeners();
  }

  List<Grade> _grades = [];
  List<Grade> get syllabus => _grades;

  // Add a new grade to the database
  Future<void> addGrade(Grade grade) async {
    // Call the createGrade method from GymAppDB
    await gymAppDb.createGrade(
      color: grade.colour,
      stripe: grade.stripe,
    );
    // Refresh the list of grades
    await fetchGrades();
    notifyListeners();
  }

  // Update a grade in the database
  Future<void> updateGrade(Grade grade) async {
    // Call the updateGrade method from GymAppDB
    await gymAppDb.updateGrade(
      id: grade.id,
      color: grade.colour,
      stripe: grade.stripe,
    );
    // Refresh the list of grades
    await fetchGrades();
    notifyListeners();
  }

  // Delete a grade from the database
  Future<void> deleteGrade(int id) async {
    // Call the deleteGrade method from GymAppDB
    await gymAppDb.deleteGrade(id);
    // Refresh the list of grade
    await fetchGrades();
    notifyListeners();
  }
}
