import 'package:flutter/foundation.dart';

import '../model/class.dart';

class ClassesProvider extends ChangeNotifier {
  List<Class> classes = [];

  void addClass(Class classObj) {
    classes.add(classObj);
    notifyListeners();
  }

  List<Class> read() {
    return classes;
  }

  void update(List<Class> classes) {
    this.classes = classes;
    notifyListeners();
  }

  void deleteClass(int id) {
    classes.removeWhere((classObj) => classObj.id == id);
    notifyListeners();
  }
}
