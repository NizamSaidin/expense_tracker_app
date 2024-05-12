import 'package:expense_tracker_app/models/category.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class CategoryRepository {
  Database? _database;

  static String get _tableName => 'categories';

  Future<Database> get database async {
    _database ??= await _initialize();
    return _database!;
  }

  Future<Database> _initialize() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, '$_tableName.db');

    _database = await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
    return _database!;
  }

  void _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $_tableName (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT UNIQUE
      )
    ''');
  }

  Future<int> addCategory(Category category) async {
    final db = await database;
    return db.transaction((txn) async {
      return await txn.insert(
        _tableName,
        category.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    });
  }

  Future<List<Category>> getCategories() async {
    final db = await database;

    final List<Map<String, dynamic>> maps = await db.query(_tableName);
    return List.generate(
      maps.length,
      (index) {
        return Category().fromJson(maps[index]);
      },
    );
  }

  Future<void> addOrUpdateCategories(List<Category> categories) async {
    final db = await database;
    await db.transaction((txn) async {
      for (Category category in categories) {
        await txn.insert(
          _tableName,
          category.toSqlJson(),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }
    });
  }
}
