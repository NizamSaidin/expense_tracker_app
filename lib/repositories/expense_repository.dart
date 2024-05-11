import 'package:expense_tracker_app/models/category.dart';
import 'package:expense_tracker_app/models/expense.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class ExpenseRepository {
  static final ExpenseRepository _instance = ExpenseRepository._();

  factory ExpenseRepository() => _instance;

  ExpenseRepository._() {
    _initialize();
  }

  Database? _database;

  static String get _tableName => 'expenses';

  Future<Database> get database async {
    _database ??= await _initialize();
    return _database!;
  }

  Future<Database> _initialize() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'expenses.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  void _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $_tableName (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        category TEXT,
        amount REAL,
        date TEXT,
        note TEXT
      )
    ''');
  }

  Future<int> addExpense(Expense expense) async {
    final db = await database;
    return db.transaction((txn) async {
      return await txn.insert(
        _tableName,
        expense.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    });
  }

  Future<List<Expense>> getAllExpenses({List<String>? categories, String? sortBy}) async {
    final db = await database;
    String? whereQuery;

    if (categories != null && categories.isNotEmpty) {
      whereQuery = 'category IN (${categories.map((e) => '"$e"').join(',')})';
    }

    final List<Map<String, dynamic>> maps = await db.query(
      _tableName,
      orderBy: "${sortBy ?? 'id'} DESC",
      where: whereQuery,
    );
    return List.generate(
      maps.length,
      (index) {
        return Expense().fromJson(maps[index]);
      },
    );
  }

  Future<List<Category>> getExpensesGroupByCategory(DateTime dateTime) async {
    final db = await database;
    final DateFormat dateFormat = DateFormat('yyyy-MM-dd');

    DateTime startOfMonth = DateTime(dateTime.year, dateTime.month, 1);
    DateTime endOfMonth = DateTime(dateTime.year, dateTime.month + 1, 0);

    // group by category
    final List<Map<String, dynamic>> maps = await db.rawQuery('''
      SELECT category, SUM(amount) as total FROM $_tableName WHERE date BETWEEN '${dateFormat.format(startOfMonth)}' AND '${dateFormat.format(endOfMonth)}' GROUP BY category
    ''');

    return List.generate(
      maps.length,
      (index) {
        return Category().fromGroupByJson(maps[index]);
      },
    );
  }

  Future<List<Expense>> getExpensesByDay(DateTime dateTime) async {
    final db = await database;
    final DateFormat dateFormat = DateFormat('yyyy-MM-dd');

    DateTime startOfMonth = DateTime(dateTime.year, dateTime.month, 1);
    DateTime endOfMonth = DateTime(dateTime.year, dateTime.month + 1, 0);

    // get expenses filter by start month of date time and end month of date time
    // group the expenses by date
    // sort by date
    final List<Map<String, dynamic>> maps = await db.rawQuery('''
      SELECT date, SUM(amount) as total FROM $_tableName WHERE date BETWEEN '${dateFormat.format(startOfMonth)}' AND '${dateFormat.format(endOfMonth)}' GROUP BY date ORDER BY date ASC
    ''');

    return List.generate(
      maps.length,
      (index) {
        return Expense().fromGroupByDayJson(maps[index]);
      },
    );
  }

  Future<Expense?> getExpenseById(int id) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      _tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
    if (maps.isEmpty) {
      return null;
    }

    return Expense().fromJson(maps.first);
  }

  Future<int> updateExpense(Expense expense) async {
    final db = await database;
    return db.transaction((txn) async {
      return await txn.update(
        _tableName,
        expense.toJson(),
        where: 'id = ?',
        whereArgs: [expense.id],
      );
    });
  }

  Future<int> deleteExpense(Expense expense) async {
    final db = await database;
    return db.transaction(
      (txn) async {
        return await txn.delete(
          _tableName,
          where: 'id = ?',
          whereArgs: [expense.id],
        );
      },
    );
  }
}
