import 'package:flutter/material.dart';
import 'package:m_a_gym_manager/model/syllabus.dart';
import 'package:provider/provider.dart';

import '../database/gym_app_db.dart';

class SyllabusProvider extends ChangeNotifier {
  late final GymAppDB gymAppDb;

  //Read all syllabi in database
  Future fetchSyllabi() async {
    final syllabi = await gymAppDb.fetchSyllabi();
    // Assign gyms to the private _gyms variable
    _syllabi = syllabi;
    notifyListeners();
  }

  List<Syllabus> _syllabi = [];
  List<Syllabus> get syllabus => _syllabi;

  // Add a new syllabus to the database
  Future<void> addSyllabus(Syllabus syllabus) async {
    // Call the createSyllabus method from GymAppDB
    await gymAppDb.createSyllabus(
      name: syllabus.name,
      chapter: syllabus.chapter,
    );
    // Refresh the list of syllabi
    await fetchSyllabi();
    notifyListeners();
  }

  // Update a syllabus in the database
  Future<void> updateSyllabus(Syllabus syllabus) async {
    // Call the updateSyllabus method from GymAppDB
    await gymAppDb.updateSyllabus(
      id: syllabus.id,
      name: syllabus.name,
      chapter: syllabus.chapter,
    );
    // Refresh the list of syllabus
    await fetchSyllabi();
    notifyListeners();
  }

  // Delete a syllabus from the database
  Future<void> deleteSyllabus(int id) async {
    // Call the deleteSyllabus method from GymAppDB
    await gymAppDb.deleteSyllabus(id);
    // Refresh the list of syllabi
    await fetchSyllabi();
    notifyListeners();
  }
}
