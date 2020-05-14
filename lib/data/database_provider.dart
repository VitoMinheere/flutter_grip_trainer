import 'dart:io';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'dart:typed_data';
import 'dart:core';
import 'package:flutter/services.dart';

import 'package:grip_trainer/data/category.dart';
import 'package:grip_trainer/data/level.dart';
import 'package:grip_trainer/data/exercise.dart';
import 'package:grip_trainer/data/personal_record.dart';

class DatabaseProvider {
  static const String DB_NAME = 'test.db';
  static const String CATEGORY_TABLE = 'category';
  static const List<String> CATEGORY_COLUMNS = ['id', 'name', 'image'];

  static const String LEVEL_TABLE = 'level';
  static const List<String> LEVEL_COLUMNS = [
    'id',
    'category_id',
    'exercise_id',
    'seconds_to_pass',
    'sets_to_pass',
    'completed'
  ];

  static const String EXERCISE_TABLE = 'exercise';
  static const List<String> EXERCISE_COLUMNS = [
    'id',
    'name',
    'image',
    'explanation'
  ];

  static const String PR_TABLE = 'personal_record';

  DatabaseProvider._();
  static final DatabaseProvider db = DatabaseProvider._();

  Database _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database;
    }

    _database = await createDatabase();

    return _database;
  }

  Future<Database> createDatabase() async {
    var databasesPath = await getDatabasesPath();
    var path = join(databasesPath, "test_4.db");

    // Check if the database exists
    var exists = await databaseExists(path);

    if (!exists) {
      // Should happen only the first time you launch your application
      print("Creating new copy from asset");

      // Make sure the parent directory exists
      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (_) {}

      // Copy from asset
      ByteData data = await rootBundle.load(join("assets", "test.db"));
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      // Write and flush the bytes written
      await File(path).writeAsBytes(bytes, flush: true);
    } else {
      print("Opening existing database");
    }
    // open the database
    return await openDatabase(path, readOnly: true);
  }

  Future<List<GripCategory>> getCategories() async {
    final db = await database;

    var categories = await db.query(CATEGORY_TABLE, columns: CATEGORY_COLUMNS);
    List<GripCategory> categoryList = List<GripCategory>();

    categories.forEach((element) {
      GripCategory category = GripCategory.fromMap(element);
      categoryList.add(category);
    });

    return categoryList;
  }

  Future<List<Level>> getLevelsForCategory(categoryId) async {
    print("Called function");

    final db = await database;

    var levels = await db.query(LEVEL_TABLE,
        columns: LEVEL_COLUMNS, where: "category_id = $categoryId");
    List<Level> levelList = List<Level>();

    levels.forEach((element) {
      Level level = Level.fromMap(element);
      levelList.add(level);
    });
    return levelList;
  }

  Future<List<Exercise>> getExercises(List<int> exerciseIds) async {
    final db = await database;

    var exercises = await db.query(EXERCISE_TABLE,
        columns: EXERCISE_COLUMNS, where: "id in (${exerciseIds.join(', ')})");
    List<Exercise> exerciseList = List<Exercise>();

    exercises.forEach((element) {
      Exercise exercise = Exercise.fromMap(element);
      exerciseList.add(exercise);
    });
    return exerciseList;
  }

  Future<PersonalRecord> insert(PersonalRecord pr) async {
    final db = await database;
    pr.id = await db.insert(PR_TABLE, pr.toMap());
    return pr;
  }
}
