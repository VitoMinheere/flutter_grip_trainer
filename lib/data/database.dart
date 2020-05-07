import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseProvider {
  static const String DB_NAME = 'grip_trainer';
  static const String CATEGORY_TABLE = 'category';
  static const String LEVEL_TABLE = 'level';
  static const String EXERCISE_TABLE = 'exercise';

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
          "id INTEGER PRIMARY KEY AUTOINCREMENT,"
          "name TEXT,"
          "");
    });
  }
}
