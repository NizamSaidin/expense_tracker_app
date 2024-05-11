import 'package:expense_tracker_app/models/setting.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SettingRepository {
  static final SettingRepository _instance = SettingRepository._();

  factory SettingRepository() => _instance;

  SettingRepository._() {
    _initialize();
  }

  Database? _database;

  static String get _tableName => 'settings';

  Future<Database> get database async {
    _database ??= await _initialize();
    return _database!;
  }

  Future<Database> _initialize() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'settings.db');

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
        currency TEXT,
        monthly_budget REAL
      )
    ''');

    await db.insert(
      _tableName,
      Setting().toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<int> addSetting(Setting setting) async {
    final db = await database;
    return db.transaction((txn) async {
      return await txn.insert(
        _tableName,
        setting.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    });
  }

  Future<Setting> getSetting() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(_tableName);

    if (maps.isEmpty) {
      // create if setting not exist
      Setting newSetting = Setting();
      await addSetting(Setting());
      return newSetting;
    }
    return Setting().fromJson(maps.first);
  }

  Future<int> updateSetting(Setting setting) async {
    final db = await database;
    return db.transaction((txn) async {
      return await txn.update(
        _tableName,
        setting.toJson(),
        where: 'id = ?',
        whereArgs: [setting.id],
      );
    });
  }
}
