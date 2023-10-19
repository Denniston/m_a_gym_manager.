import 'package:flutter/foundation.dart';
import 'package:m_a_gym_manager/model/class.dart';
import 'package:m_a_gym_manager/database/gym_app_db.dart';

class ClassProvider with ChangeNotifier {
  late final GymAppDB gymAppDb;

  //Read all classes in database
  Future fetchClasses() async {
    final classes = await gymAppDb.fetchClasses();
    // Assign classes to the private _classes variable
    _classes = classes;
    notifyListeners();
  }

  List<Class> _classes = [];
  List<Class> get classes => _classes;

  // Add a new class to the database
  Future<void> addClass(Class classObj) async {
    await gymAppDb.createClass(
      name: classObj.name,
      start: classObj.start,
      end: classObj.end,
      length: classObj.length,
      specialisation: classObj.specialisation,
      coach: classObj.coach,
    );
    await fetchClasses();
    notifyListeners();
  }

  Future<void> updateClass(Class classObj) async {
    await gymAppDb.updateClass(
      id: classObj.id,
      name: classObj.name,
      start: classObj.start,
      end: classObj.end,
      length: classObj.length,
      specialisation: classObj.specialisation,
      coach: classObj.coach,
    );
    await fetchClasses();
    notifyListeners();
  }

  // Delete a class from the database
  Future<void> deleteClass(int id) async {
    // Call the deleteClass method from GymAppDB
    await gymAppDb.deleteClass(id);

    // Refresh the list of classes
    await fetchClasses();
    notifyListeners();
  }
}
