import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseProvider {
  static const String DB_NAME = 'grip_trainer';
  static const String CATEGORY_TABLE = 'category';
  static const String LEVEL_TABLE = 'level';
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
}
