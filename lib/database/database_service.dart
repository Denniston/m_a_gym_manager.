import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'gym_app_db.dart';
import 'package:flutter/material.dart';

//1- Create DBService class
class DatabaseService with ChangeNotifier {
  //2 Create local variable of type Database of sqlite
  Database? _database;

  //Create get db method to check if db exists. initialize or create now
  Future<Database?> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await _initialize();
    return _database!;
  }

  Future<String> get fullPath async {
    const name = 'gym_app.db';
    final path = await getDatabasesPath();
    return join(path, name);
  }

  Future<Database> _initialize() async {
    final path = await fullPath;
    var database = await openDatabase(
      path,
      version: 1,
      onCreate: createDb,
      singleInstance: true,
    );
    return database;
  }

  Future<void> createDb(Database database, int version) async =>
      await GymAppDB().createTables(database);
}
