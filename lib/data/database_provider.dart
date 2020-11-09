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
    'seconds_to_pass',
    'completed'
  ];

  static const String EXERCISE_TABLE = 'exercise';
  static const List<String> EXERCISE_COLUMNS = [
    'id',
    'name',
    'image',
    'explanation',
    'level_id',
  ];

  static const String PERSONAL_RECORD_TABLE = 'personal_record';
  static const List<String> PERSONAL_RECORD_COLUMNS = [
    'id',
    'exercise_id',
    'seconds_done',
    'date',
  ];

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
    var path = join(databasesPath, "test_07.db");

    // Check if the database exists
    var exists = await databaseExists(path);
    // var exists = false;

    if (!exists) {
      // Make sure the parent directory exists
      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (_) {}

      // Copy from asset
      ByteData data = await rootBundle.load(join("assets", "grip_trainer.db"));
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      // Write and flush the bytes written
      await File(path).writeAsBytes(bytes, flush: true);
    }
    // open the database
    return await openDatabase(path, readOnly: false);
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

  Future<List<Level>> getCompletedLevelsForCategory(categoryId) async {
    final db = await database;

    var levels = await db.query(LEVEL_TABLE,
        columns: LEVEL_COLUMNS,
        where: "category_id = $categoryId AND completed = 1");
    List<Level> levelList = List<Level>();

    levels.forEach((element) {
      Level level = Level.fromMap(element);
      levelList.add(level);
    });
    return levelList;
  }

  Future<List<Exercise>> getExercisesForLevel(List<int> levelIds) async {
    final db = await database;

    var exercises = await db.query(EXERCISE_TABLE,
        columns: EXERCISE_COLUMNS,
        where: "level_id in (${levelIds.join(', ')})");
    List<Exercise> exerciseList = List<Exercise>();

    exercises.forEach((element) {
      Exercise exercise = Exercise.fromMap(element);
      exerciseList.add(exercise);
    });
    return exerciseList;
  }

  Future<List<PersonalRecord>> getPersonalRecordsForExercise(
      List<int> exerciseIds) async {
    final db = await database;

    var personalRecords = await db.rawQuery(
        'select pr.id, pr.date, pr.seconds_done, pr.exercise_id FROM $PERSONAL_RECORD_TABLE pr inner join (select exercise_id, max(id) as MaxId from $PERSONAL_RECORD_TABLE group by exercise_id) tm on pr.exercise_id = tm.exercise_id and pr.id = tm.MaxId WHERE pr.exercise_id in (${exerciseIds.join(', ')})');
    List<PersonalRecord> recordsList = List<PersonalRecord>();

    personalRecords.forEach((element) {
      PersonalRecord pr = PersonalRecord.fromMap(element);
      recordsList.add(pr);
    });
    return recordsList;
  }

  Future<PersonalRecord> insertRecord(PersonalRecord pr) async {
    final db = await database;
    pr.id = await db.insert(PERSONAL_RECORD_TABLE, pr.toMap());
    return pr;
  }

  void setLevelComplete(int levelId) async {
    final db = await database;
    db.rawUpdate("UPDATE $LEVEL_TABLE SET completed = 1 WHERE id = $levelId");
  }
}
