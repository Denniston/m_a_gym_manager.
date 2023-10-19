import 'package:m_a_gym_manager/model/coach.dart';
import 'package:provider/provider.dart';

import '../model/class.dart';
import '../model/grade.dart';
import '../model/student.dart';
import '../model/syllabus.dart';
import 'database_service.dart';
import 'package:sqflite/sqflite.dart';
import 'package:m_a_gym_manager/model/gym.dart';
import 'package:flutter/material.dart';

class GymAppDB with ChangeNotifier {
  //INTEGER NOT NULL DEFAULT(cast(strftime('%s' 'now') as integer)
  late final Database _db;
  final gymTableName = 'gyms';
  final coachTableName = 'coaches';
  final classTableName = 'classes';
  final studentTableName = 'students';
  final gradeTableName = 'grades';
  final specialityTableName = 'specialities';
  final syllabusTableName = 'syllabus';

  Future<void> createTables(Database database) async {
    await database.execute('''CREATE TABLE IF NOT EXISTS $gymTableName(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT NOT NULL,
            email TEXT,
            phone INTEGER,
            address TEXT NOT NULL,
            profileImage TEXT,
            manager TEXT NOT NULL)''');
    await database.execute('''CREATE TABLE IF NOT EXISTS $coachTableName(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
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
            FOREIGN KEY (gym_id) REFERENCES gyms(id))''');
    await database
        .execute('''CREATE TABLE IF NOT EXISTS $classTableName(          
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT NOT NULL,
            start DATETIME NOT NULL,
            end DATETIME NOT NULL,
            length INTEGER,
            specialisation TEXT,
            coach_id INTEGER,
            gym_id INTEGER,
            FOREIGN KEY (coach_id) REFERENCES coaches(id),
            FOREIGN KEY (gym_id) REFERENCES gyms(id))''');

    await database.execute('''
          CREATE TABLE IF NOT EXISTS $studentTableName(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
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
    await database.execute('''CREATE TABLE IF NOT EXISTS $gradeTableName (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            student_id INTEGER NOT NULL,
            class_id INTEGER NOT NULL,
            grade INTEGER,
            FOREIGN KEY(student_id) REFERENCES students(id),
            FOREIGN KEY(class_id) REFERENCES classes(id)
           )
         ''');
    // await database.execute('''CREATE TABLE $specialityTableName(
    //         id INTEGER PRIMARY KEY AUTOINCREMENT,
    //         name TEXT NOT NULL,
    //         FOREIGN KEY(coach_id) REFERENCES coaches(id))''');
    await database.execute('''
            CREATE TABLE $syllabusTableName(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            gym_id,
            chapters TEXT,
            FOREIGN KEY(gym_id) REFERENCES gyms(id)
           )
         ''');
  }

  Future closeDatabase() async {
    var dbClose = _db;
    dbClose.close();
  }
  //==================================Gym================================

  // Create Gym
  Future<int> createGym({
    required String name,
    String? email,
    int? phone,
    required String address,
    String? profileImage,
    required String manager,
  }) async {
    try {
      return await _db.transaction((txn) async {
        final id = await txn.rawInsert('''
          INSERT INTO $gymTableName (name, email, phone, address, profileImage, manager) 
          VALUES (?, ?, ?, ?, ?, ?)
        ''', [name, email, phone, address, profileImage, manager]);
        return id;
      });
    } catch (error) {
      // Handle the error
      print('Error creating gym: $error');
      rethrow; // Re-throw the error to propagate it further
    } finally {
      await closeDatabase();
    }
  }
  // Future<int> createGym({
  //   required String name,
  //   required String address,
  //   String? profileImage,
  //   required String manager,
  // }) async {
  //   final database = await DatabaseService().database;
  //   int gymId = 0;
  //
  //   await database!.transaction((txn) async {
  //     gymId = await txn.rawInsert(
  //       '''INSERT INTO $gymTableName (name, address, profileImage, manager) VALUES (?,?,?,?)''',
  //       [name, address, profileImage, manager],
  //     );
  //   });
  //
  //   return gymId;
  // }
  // Future<int> createGym({
  //   //required int id,
  //   required String name,
  //   required String address,
  //   String? profileImage,
  //   required String manager,
  // }) async {
  //   final database = await DatabaseService().database;
  //   return await database!.rawInsert(
  //       '''INSERT INTO $gymTableName (name, address, profileImage, manager) VALUES (?,?,?,?)''',
  //       [
  //         name,
  //         address,
  //         profileImage,
  //         manager,
  //       ]);
  // }

  // Fetch Gym By Id
  Future<Gym?> fetchById(int id) async {
    try {
      final gymData =
          await _db.query(gymTableName, where: 'id = ?', whereArgs: [id]);
      if (gymData.isEmpty) {
        return null; // Gym with the given id not found
      }
      return Gym.fromMap(gymData.first);
    } catch (error) {
      // Handle the error
      print('Error fetching gym by ID: $error');
      rethrow; // Re-throw the error to propagate it further
    } finally {
      await closeDatabase();
    }
  }

  // Fetch All Gyms
  Future<List<Gym>> fetchGyms() async {
    final database = await DatabaseService().database;
    final gym = await database!.query('gyms');
    return gym.map((row) => Gym.fromMap(row)).toList();
  }

  Future<int> updateGym({
    int? id,
    required String? name,
    String? email,
    int? phone,
    String? address,
    String? profileImage,
    required String manager,
  }) async {
    final database = await DatabaseService().database;
    try {
      return await database!.update(
        gymTableName,
        {
          if (id != null && name != null) 'name': name,
          'email': email,
          'phone': phone,
          'address': address,
          'profileImage': profileImage,
          'manager': manager,
        },
        where: 'id = ?',
        conflictAlgorithm: ConflictAlgorithm.rollback,
        whereArgs: [id],
      );
    } catch (error) {
      // Handle the error
      print('Error Updating gym: $error');
      rethrow; // Re-throw the error to propagate it further
    } finally {
      await closeDatabase();
    }
  }

  // Delete Gym
  Future<int> deleteGym(int id) async {
    try {
      return await _db.transaction((txn) async {
        final rowsDeleted = await txn.delete(
          gymTableName,
          where: 'id = ?',
          whereArgs: [id],
        );
        return rowsDeleted;
      });
    } catch (error) {
      // Handle the error
      print('Error deleting gym: $error');
      rethrow; // Re-throw the error to propagate it further
    } finally {
      await closeDatabase();
    }
  }
  // Future<Gym> fetchById(int id) async {
  //   final database = await DatabaseService().database;
  //   final gym = await database!
  //       .rawQuery('''SELECT * from $gymTableName WHERE id = ?''', [id]);
  //   return Gym.fromSqfliteDatabase(gym.first);
  // }
  //
  // // Fetch Gyms
  // Future<List<Gym>> fetchGyms() async {
  //   final database = await DatabaseService().database;
  //   final gym = await database!.query('gyms');
  //   return gym.map((row) => Gym.fromMap(row)).toList();
  // }
  // Future<List<Gym>> fetchGyms() async {
  //   final database = await DatabaseService().database;
  //   final gyms = await database!.query('gyms'); // Use 'query' method to fetch data
  //   return gyms.map((row) => Gym.fromMap(row)).toList();
  // }
  //
  // // Update Gym

  //
  // // Delete Gym
  // Future<int> deleteGym(int id) async {
  //   final database = await DatabaseService().database;
  //   return await database!.rawDelete('''
  //     DELETE FROM $gymTableName WHERE id = ?
  //     ''');
  // }

  //==================================Coach================================
  //Create Coach
  Future<int> createCoach({
    int? id,
    required String specialization,
    required String firstName,
    required String lastName,
    String? email,
    DateTime? dob,
    String? age,
    required String phone,
    String? address,
    String? profileImage,
    String? coverImage,
  }) async {
    final database = await DatabaseService().database;
    return await database!.rawInsert(
        '''INSERT INTO $coachTableName (specialization, firstName, lastName, email, dob, age, phone, address, profileImage, coverImage,) VALUES (?,?)''',
        [
          specialization,
          firstName,
          lastName,
          email,
          dob,
          age,
          phone,
          address,
          profileImage,
          coverImage,
        ]);
  }

  // Fetch Coaches
  Future<List<Coach>> fetchCoaches() async {
    final database = await DatabaseService().database;
    final coach = await database!.rawQuery('coaches');
    return coach.map((row) => Coach.fromMap(row)).toList();
  }

  // Update Coach
  Future<int> updateCoach({
    int? id,
    required String specialization,
    String? firstName,
    required String lastName,
    String? email,
    DateTime? dob,
    String? age,
    String? phone,
    String? address,
    String? profileImage,
    String? coverImage,
  }) async {
    final database = await DatabaseService().database;
    return await database!.update(
      coachTableName,
      {
        if (id != null && firstName != null) 'specialization': specialization,
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'age': age,
        'dob': dob,
        'phone': phone,
        'address': address,
        'profileImage': profileImage,
        'coverImage': coverImage,
      },
      where: 'id = ?',
      conflictAlgorithm: ConflictAlgorithm.rollback,
      whereArgs: [id],
    );
  }

  // Delete Coach
  Future<int> deleteCoach(int id) async {
    final database = await DatabaseService().database;
    return await database!.rawDelete('''
      DELETE FROM $coachTableName WHERE id = ?
      ''');
  }

  //==================================Syllabi================================
  //Create Syllabus
  Future<int> createSyllabus({
    int? id,
    required String name,
    required String chapter,
  }) async {
    final database = await DatabaseService().database;
    return await database!.rawInsert(
        '''INSERT INTO $syllabusTableName (name, chapter,) VALUES (?,?)''',
        [
          name,
          chapter,
        ]);
  }

  // Fetch Syllabi
  Future<List<Syllabus>> fetchSyllabi() async {
    final database = await DatabaseService().database;
    final syllabi = await database!.rawQuery('syllabus');
    return syllabi.map((row) => Syllabus.fromMap(row)).toList();
  }

  // Update Syllabus
  Future<int> updateSyllabus(
      {required int? id, String? name, String? chapter}) async {
    final database = await DatabaseService().database;
    return await database!.update(
      syllabusTableName,
      {
        if (name != null || chapter != null) 'name': name,
        'chapter': chapter,
      },
      where: 'id = ?',
      conflictAlgorithm: ConflictAlgorithm.rollback,
      whereArgs: [id],
    );
  }

  // Delete Syllabus
  Future<int> deleteSyllabus(int id) async {
    final database = await DatabaseService().database;
    return await database!.rawDelete('''
      DELETE FROM $syllabusTableName WHERE id = ?
      ''');
  }
  // ========================
  // Class CRUD Operations
  // ========================

  Future<int> createClass({
    required String name,
    required DateTime start,
    required DateTime end,
    required int length,
    required String specialisation,
    required String coach,
  }) async {
    final database = await DatabaseService().database;
    return await database!.insert(
      'classes',
      {
        'name': name,
        'start': start.toIso8601String(),
        'end': end.toIso8601String(),
        'length': length,
        'specialisation': specialisation,
        'coach': coach,
      },
    );
  }

  Future<List<Class>> fetchClasses() async {
    final database = await DatabaseService().database;

    final classes = await database!.query('classes');
    return classes.map((classObj) => Class.fromMap(classObj)).toList();
  }

  Future<int> updateClass({
    required int? id,
    required String? name,
    DateTime? start,
    DateTime? end,
    int? length,
    String? specialisation,
    String? coach,
  }) async {
    final database = await DatabaseService().database;
    return await database!.update(
      'classes',
      {
        if (name != null) 'name': name,
        if (start != null) 'start': start.toIso8601String(),
        if (end != null) 'end': end.toIso8601String(),
        if (length != null) 'length': length,
        if (specialisation != null) 'specialisation': specialisation,
        if (coach != null) 'coach': coach,
      },
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> deleteClass(int id) async {
    final database = await DatabaseService().database;
    return await database!.delete(
      'classes',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  //==================================Students================================
  // Create Student
  Future<int> createStudent({
    int? id,
    String? profileImage,
    required String? coverImage,
    required String firstName,
    required String lastName,
    int? age,
    DateTime? dob,
    String? email,
    String? phone,
    String? address,
  }) async {
    final database = await DatabaseService().database;
    return await database!.rawInsert(
        '''INSERT INTO $studentTableName (firstName, lastName, email, dob, age, phone, address, profileImage, coverImage,) VALUES (?,?)''',
        [
          firstName,
          lastName,
          email,
          dob,
          age,
          phone,
          address,
          profileImage,
          coverImage,
        ]);
  }

  // Fetch Student By Id.
  Future<Student> fetchStudentById(int id) async {
    final database = await DatabaseService().database;
    final student = await database!
        .rawQuery('''SELECT * from $studentTableName WHERE id = ?''', [id]);
    return Student.fromMap(student.first);
  }

  // Fetch Students
  Future<List<Student>> fetchStudents() async {
    final database = await DatabaseService().database;
    final students = await database!.rawQuery('students');
    return students.map((row) => Student.fromMap(row)).toList();
  }

  // Update Student
  Future<int> updateStudent({
    int? id,
    String? profileImage,
    required String? coverImage,
    String? firstName,
    required String lastName,
    int? age,
    DateTime? dob,
    String? email,
    String? phone,
    String? address,
  }) async {
    final database = await DatabaseService().database;
    return await database!.update(
      studentTableName,
      {
        if (id != null && firstName != null) 'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'age': age,
        'dob': dob,
        'phone': phone,
        'address': address,
        'profileImage': profileImage,
        'coverImage': coverImage,
      },
      where: 'id = ?',
      conflictAlgorithm: ConflictAlgorithm.rollback,
      whereArgs: [id],
    );
  }

  // Delete Student
  Future<int> deleteStudent(int id) async {
    final database = await DatabaseService().database;
    return await database!.rawDelete('''
      DELETE FROM $studentTableName WHERE id = ?
      ''');
  }

  //===============================Grade Methods==============================
  //Grade methods
  Future<int> createGrade({
    int? id,
    required Color color,
    required int stripe,
  }) async {
    final database = await DatabaseService().database;
    return await database!.rawInsert(
        '''INSERT INTO $gradeTableName (color, stripe,) VALUES (?,?)''',
        [
          color,
          stripe,
        ]);
  }

  Future<List<Grade>> fetchGrades() async {
    final database = await DatabaseService().database;
    final grade = await database!.rawQuery('grades');
    return grade.map((row) => Grade.fromMap(row)).toList();
  }

// Update grade
  Future<int> updateGrade({
    int? id,
    required Color color,
    required int stripe,
  }) async {
    final database = await DatabaseService().database;
    return await database!.update(
      gradeTableName,
      {
        if (id != null) 'color': color,
        'stripe': stripe,
      },
      where: 'id = ?',
      conflictAlgorithm: ConflictAlgorithm.rollback,
      whereArgs: [id],
    );
  }

// Delete grade
  Future<int> deleteGrade(int id) async {
    final database = await DatabaseService().database;
    return await database!.rawDelete('''
      DELETE FROM $gradeTableName WHERE id = ?
      ''');
  }
}
