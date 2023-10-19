import 'dart:async';
import 'dart:io';
//import 'package:m_a_gym_manager/model/syllabus.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import '../model/class.dart';
import '../model/coach.dart';
//import '../model/grade.dart';
import '../model/gym.dart';
import '../model/student.dart';

class DatabaseHelper {
  static DatabaseHelper instance = DatabaseHelper();

  static const name = 'gym_app.db';
  static Database? gymAppDb;
  static int get _version => 1;

  // Future<Database?> get database async {
  //   if (gymAppDb != null) return gymAppDb;
  //   gymAppDb = await _initDatabase();
  //   return gymAppDb!;
  // }

  // Future<Database?> addProfileImageColumn() async {
  //   final db = await database;
  //   await db?.execute('ALTER TABLE gyms ADD COLUMN profileImage TEXT');
  //   return null;
  // }
  // Future<Database> get db async {
  //   if (_db == null) {
  //     _db = await _initDb();
  //   }
  //   return _db;
  // }

  Future<Database?> get _initDatabase async {
    if (gymAppDb != null) {
      return gymAppDb!;
    }
    try {
      Directory documentsDirectory = await getApplicationDocumentsDirectory();
      String path = join(documentsDirectory.path, name);
      gymAppDb =
          await openDatabase(path, version: _version, onCreate: onCreate);
    } catch (ex) {
      print(ex);
    }
    return null;
    // Directory documentsDirectory = await getApplicationDocumentsDirectory();
    // String path = join(documentsDirectory.path, name);
    // return await openDatabase(
    //   path,
    //   version: 1,
    //TODO: Go through the app and updated all dateTime objects.
    // onUpgrade: (db, oldVersion, newVersion) async {
    //   if (oldVersion < 2) {
    //     await db.execute('DROP TABLE gyms;');
    //     await db.execute('DROP TABLE coaches;');
    //     await db.execute('DROP TABLE classes;');
    //     await db.execute('DROP TABLE students;');
    //     //await db.execute('ALTER TABLE gyms ADD COLUMN profileImage TEXT');
    //   }
    // },

    //);
  }
  //==================================================================

  static void onCreate(db, version) async {
    await db.execute('''
          CREATE TABLE gyms(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT NOT NULL,
            address TEXT NOT NULL,
            profileImage TEXT,
            manager TEXT NOT NULL,
          )
        ''');

    await db.execute('''
          CREATE TABLE coaches(
            id INTEGER PRIMARY KEY,
            firstName TEXT NOT NULL,
            lastName TEXT NOT NULL,
            specialization TEXT,
            age INTEGER,
            dob TEXT,
            email TEXT,
            phone TEXT,
            address TEXT,
            profileImage TEXT,
            coverImage TEXT,
            gym_id INTEGER,
            FOREIGN KEY (gym_id) REFERENCES gyms(id)
          )
        ''');
    await db.execute('''
          CREATE TABLE classes(
            id INTEGER PRIMARY KEY,
            name TEXT NOT NULL,
            start TEXT,
            end TEXT,
            length INTEGER,
            coach_id INTEGER,
            gym_id INTEGER,
            FOREIGN KEY (coach_id) REFERENCES coaches(id),
            FOREIGN KEY (gym_id) REFERENCES gyms(id)
          )
        ''');
    await db.execute('''
          CREATE TABLE students(
            id INTEGER PRIMARY KEY,
            profileImage TEXT,
            coverImage TEXT,            
            firstName TEXT NOT NULL,
            lastName TEXT NOT NULL,
            age INTEGER,
            dob TEXT,
            email TEXT,
            phone TEXT,
            address TEXT,
            gym_id INTEGER,
            FOREIGN KEY (gym_id) REFERENCES gyms(id)
          )
        ''');
  }

  Future<int> insertGym(Gym gym) async {
    final db = await _initDatabase;
    return await db!.insert(
      'gyms',
      gym.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Gym>> getGyms() async {
    final db = await _initDatabase;
    final List<Map<String, dynamic>> maps = await db!.query('gyms');
    return List.generate(maps.length, (i) {
      return Gym.fromMap(maps[i]);
    });
  }

  // Update gym
  Future<int> updateGym(Gym gym) async {
    final db = await _initDatabase;
    return await db!.update(
      'gyms',
      gym.toMap(),
      where: 'id = ?',
      whereArgs: [gym.id],
    );
  }

  // Delete gym
  Future<int> deleteGym(int id) async {
    final db = await _initDatabase;
    return await db!.delete(
      'gyms',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Coach methods

  Future<int> insertCoach(Coach coach) async {
    final db = await _initDatabase;
    return await db!.insert('coaches', coach.toMap());
  }

  Future<List<Coach>> getCoaches() async {
    final db = await _initDatabase;
    final List<Map<String, dynamic>> maps = await db!.query('coaches');
    return List.generate(maps.length, (i) {
      return Coach.fromMap(maps[i]);
    });
  }

  // Update coach
  Future<int> updateCoach(Coach coach) async {
    final db = await _initDatabase;
    return await db!.update(
      'coaches',
      coach.toMap(),
      where: 'id = ?',
      whereArgs: [coach.id],
    );
  }

  // Delete coach
  Future<int> deleteCoach(int id) async {
    final db = await _initDatabase;
    return await db!.delete(
      'coaches',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Class methods

  Future<int> insertClass(Class classObj) async {
    final db = await _initDatabase;
    return await db!.insert('classes', classObj.toMap());
  }

  Future<List<Class>> getClasses() async {
    final db = await _initDatabase;
    final List<Map<String, dynamic>> maps = await db!.query('classes');
    return List.generate(maps.length, (i) {
      return Class.fromMap(maps[i]);
    });
  }

  // Update class
  Future<int> updateClass(Class classObj) async {
    final db = await _initDatabase;
    return await db!.update(
      'classes',
      classObj.toMap(),
      where: 'id = ?',
      whereArgs: [classObj.id],
    );
  }

  // Delete class
  Future<int> deleteClass(int id) async {
    final db = await _initDatabase;
    return await db!.delete(
      'classes',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Student methods

  Future<int> insertStudent(Student student) async {
    final db = await _initDatabase;
    return await db!.insert('students', student.toMap());
  }

  Future<List<Student>> getStudents() async {
    final db = await _initDatabase;
    final List<Map<String, dynamic>> maps = await db!.query('students');
    return List.generate(maps.length, (i) {
      return Student.fromMap(maps[i]);
    });
  }

  // Update student
  Future<int> updateStudent(Student student) async {
    final db = await _initDatabase;
    return await db!.update(
      'students',
      student.toMap(),
      where: 'id = ?',
      whereArgs: [student.id],
    );
  }

  // Delete student
  Future<int> deleteStudent(int id) async {
    final db = await _initDatabase;
    return await db!.delete(
      'students',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
// Future<void> _onCreate(Database db, int version) async {
//   await db.execute('''CREATE TABLE gyms (
//       id INTEGER PRIMARY KEY AUTOINCREMENT,
//       name TEXT NOT NULL,
//       address TEXT NOT NULL,
//       coaches TEXT,
//       classes TEXT,
//       students TEXT,
//       gradings TEXT,
//       profileImage TEXT
//   )''');
//
//   await db.execute('''CREATE TABLE coaches (
//       id INTEGER PRIMARY KEY AUTOINCREMENT,
//       name TEXT NOT NULL,
//       age INTEGER,
//       dob DATETIME,
//       email TEXT,
//       phone TEXT,
//       address TEXT,
//       gym_id INTEGER NOT NULL,
//       FOREIGN KEY(gym_id) REFERENCES gyms(id)
//   )''');
//
//   await db.execute('''CREATE TABLE classes (
//   id INTEGER PRIMARY KEY AUTOINCREMENT,
//   name TEXT NOT NULL,
//   start DATETIME,
//   end DATETIME,
//   length INTEGER,
//   style TEXT,
//   coach_id INTEGER NOT NULL,
//   FOREIGN KEY(coach_id) REFERENCES coaches(id)
//   )''');
//
//   await db.execute('''CREATE TABLE students (
//   id INTEGER PRIMARY KEY AUTOINCREMENT,
//   photo TEXT,
//   name TEXT NOT NULL,
//   age INTEGER,
//   dob DATETIME,
//   email TEXT,
//   phone TEXT,
//   address TEXT,
//   gym_id INTEGER NOT NULL,
//   FOREIGN KEY(gym_id) REFERENCES gyms(id)
//   )''');
//
//   await db.execute('''CREATE TABLE grades (
//   id INTEGER PRIMARY KEY AUTOINCREMENT,
//   student_id INTEGER NOT NULL,
//   class_id INTEGER NOT NULL,
//   grade INTEGER,
//   FOREIGN KEY(student_id) REFERENCES students(id),
//   FOREIGN KEY(class_id) REFERENCES classes(id)
//   )''');
// }

// //Grade methods
// Future<int> insertGrade(Grade grade) async {
//   final db = await database;
//   return await db!.insert('grades', grade.toMap());
// }
//
// Future<List<Grade>> getGrades() async {
//   final db = await database;
//   final List<Map<String, dynamic>> maps = await db!.query('grades');
//   return List.generate(maps.length, (i) {
//     return Grade.fromMap(maps[i]);
//   });
// }
//
// // Update grade
// Future<int> updateGrade(Grade grade) async {
//   final db = await database;
//   return await db!.update(
//     'grades',
//     grade.toMap(),
//     where: 'id = ?',
//     whereArgs: [grade.id],
//   );
// }
//
// // Delete grade
// Future<int> deleteGrade(int id) async {
//   final db = await database;
//   return await db!.delete(
//     'grades',
//     where: 'id = ?',
//     whereArgs: [id],
//   );
// }

//Syllabi methods
// Future<int> insertSyllabi(Syllabi syllabi) async {
//   final db = await database;
//   return await db!.insert('syllabi', syllabi.toMap());
// }
//
// Future<List<Syllabi>> getSyllabus() async {
//   final db = await database;
//   final List<Map<String, dynamic>> maps = await db!.query('syllabi');
//   return List.generate(maps.length, (i) {
//     return Syllabi.fromMap(maps[i]);
//   });
// }
//
// // Update syllabi
// Future<int> updateSyllabi(Syllabi syllabi) async {
//   final db = await database;
//   return await db!.update(
//     'syllabi',
//     syllabi.toMap(),
//     where: 'id = ?',
//     whereArgs: [syllabi.id],
//   );
// }
//
// // Delete student
// Future<int> deleteSyllabi(int id) async {
//   final db = await database;
//   return await db!.delete(
//     'syllabi',
//     where: 'id = ?',
//     whereArgs: [id],
//   );
// }
// await db.execute('''
//   CREATE TABLE grades(
//     id INTEGER PRIMARY KEY,
//     colour TEXT,
//     stripes INTEGER
//   )
// ''');
// await db.execute('''
//   CREATE TABLE specialities(
//     name TEXT PRIMARY KEY,
//     FOREIGN KEY(coach_id) REFERENCES coaches(id),
//
//   )
// ''');
// await db.execute('''
//   CREATE TABLE syllabi(
//     id INTEGER PRIMARY KEY,
//     name TEXT,
//     gym_id,
//     chapters TEXT,
//     FOREIGN KEY(gym_id) REFERENCES gyms(id),
//   )
// ''');
