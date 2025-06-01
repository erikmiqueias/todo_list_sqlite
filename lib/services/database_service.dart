import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_list_sqlite/helpers/date_format.dart';

class DatabaseService {
  static Database? _db;
  static final DatabaseService instance = DatabaseService._constructor();

  final String _tasksTableName = "Todos";
  final _tasksIdColumnName = "id";
  final _tasksTitleColumnName = "title";
  final _tasksDescriptionColumnName = "description";
  final _tasksDateColumnName = "date";
  final _tasksIsCompletedColumnName = "isCompleted";
  final _tasksIsFavoriteColumnName = "isFavorite";

  DatabaseService._constructor();

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await getDatabase();
    return _db!;
  }

  Future<Database> getDatabase() async {
    final databaseDirPath = await getDatabasesPath();
    final databasePath = join(databaseDirPath, 'database.db');

    return await openDatabase(
      databasePath,
      version: 7,
      onCreate: (db, version) async {
        await db.execute('''
        CREATE TABLE $_tasksTableName (
          $_tasksIdColumnName INTEGER PRIMARY KEY AUTOINCREMENT,
          $_tasksTitleColumnName TEXT NOT NULL,
          $_tasksDescriptionColumnName TEXT NOT NULL,
          $_tasksDateColumnName TEXT NOT NULL,
          $_tasksIsCompletedColumnName INTEGER NOT NULL,
          $_tasksIsFavoriteColumnName INTEGER NOT NULL
        )
      ''');
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        await db.execute('DROP TABLE IF EXISTS $_tasksTableName');
        await db.execute('''
        CREATE TABLE $_tasksTableName (
          $_tasksIdColumnName INTEGER PRIMARY KEY AUTOINCREMENT,
          $_tasksTitleColumnName TEXT NOT NULL,
          $_tasksDescriptionColumnName TEXT NOT NULL,
          $_tasksDateColumnName TEXT NOT NULL,
          $_tasksIsCompletedColumnName INTEGER NOT NULL,
          $_tasksIsFavoriteColumnName INTEGER NOT NULL
        )
      ''');
      },
    );
  }

  Future createTask(String title, String description, String date) async {
    final db = await database;
    await db.insert(_tasksTableName, {
      _tasksTitleColumnName: title,
      _tasksDescriptionColumnName: description,
      _tasksDateColumnName: date,
      _tasksIsCompletedColumnName: 0,
      _tasksIsFavoriteColumnName: 0,
    });
  }

  Future getAllTasks() async {
    final db = await database;
    final result = await db.query(_tasksTableName);
    return result;
  }

  Future getCompletedTasks(String date) async {
    final db = await database;
    final result = await db.query(
      _tasksTableName,
      where:
          '$_tasksIsCompletedColumnName = ? AND LOWER($_tasksDateColumnName) LIKE LOWER(?)',
      whereArgs: [1, '%${formatDate(date)}%'],
    );
    return result;
  }

  Future<List<Map<String, dynamic>>> getUncompletedTasks(String date) async {
    final db = await database;
    final result = await db.query(
      _tasksTableName,
      where:
          '$_tasksIsCompletedColumnName = ? AND LOWER($_tasksDateColumnName) LIKE LOWER(?)',
      whereArgs: [0, '%${formatDate(date)}%'],
    );
    return result;
  }

  Future deleteTask(int id) async {
    final db = await database;
    await db.delete(
      _tasksTableName,
      where: '$_tasksIdColumnName = ?',
      whereArgs: [id],
    );
  }

  Future updateTask(int id, int isCompleted) async {
    final db = await database;
    return db.update(
      _tasksTableName,
      {_tasksIsCompletedColumnName: isCompleted},
      where: '$_tasksIdColumnName = ?',
      whereArgs: [id],
    );
  }

  Future updateFavorite(int id, int isFavorite) async {
    final db = await database;
    return db.update(
      _tasksTableName,
      {_tasksIsFavoriteColumnName: isFavorite},
      where: '$_tasksIdColumnName = ?',
      whereArgs: [id],
    );
  }

  void closeDatabase() {
    _db?.close();
    _db = null;
  }
}
