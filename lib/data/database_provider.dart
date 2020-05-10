import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'package:grip_trainer/data/category.dart';
import 'package:grip_trainer/data/level.dart';
import 'package:grip_trainer/data/exercise.dart';
import 'package:grip_trainer/data/personal_record.dart';

class DatabaseProvider {
  static const String DB_NAME = 'grip_trainer';
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
    String dbPath = await getDatabasesPath();
    return await openDatabase(join(dbPath + DB_NAME), version: 1,
        onCreate: (Database database, int version) async {
      database.execute("CREATE TABLE $EXERCISE_TABLE ("
          "id INTEGER PRIMARY KEY,"
          "name TEXT,"
          "image TEXT,"
          "explanation TEXT"
          ")");

      database.execute("CREATE TABLE $CATEGORY_TABLE ("
          "id INTEGER PRIMARY KEY,"
          "name TEXT,"
          "image TEXT"
          ")");

      database.execute("CREATE TABLE $LEVEL_TABLE ("
          "id INTEGER PRIMARY KEY,"
          "category_id INTEGER,"
          "exercise_id INTEGER,"
          "seconds_to_pass INTEGER,"
          "sets_to_pass INTEGER,"
          "completed INTEGER"
          ")");

      database.execute("CREATE TABLE $PR_TABLE ("
          "id INTEGER PRIMARY KEY,"
          "date DATETIME,"
          "level_id TEXT,"
          "seconds INTEGER"
          ")");
    });
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
    print(levelList);
    return levelList;
  }

  Future<PersonalRecord> insert(PersonalRecord pr) async {
    final db = await database;
    pr.id = await db.insert(PR_TABLE, pr.toMap());
    return pr;
  }
}
