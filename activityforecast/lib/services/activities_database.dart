import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:activityforecast/models/activity.dart';

class ActivitiesDatabase {
  static final ActivitiesDatabase instance = ActivitiesDatabase._init();

  static Database? _datatbase;

  ActivitiesDatabase._init();

  Future<Database> get database async {
    if (_datatbase != null) return _datatbase!;

    _datatbase = await _initDB('my_activities.db');
    return _datatbase!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    print("***INIT DB***");
    print(path);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  FutureOr<void> _createDB(Database db, int version) async {
    final idType = 'INTEGER PRIMARY KEY';
    final boolType = 'BOOLEAN';
    final textType = 'TEXT NOT NULL';
    final integerType = 'INTEGER NOT NULL';

    await db.execute('''
      CREATE TABLE $tableActivities (
        ${ActivityFields.id} $idType,
        ${ActivityFields.activity} $textType,
        ${ActivityFields.iconCodePoint} $integerType,
        ${ActivityFields.status} $boolType,
        ${ActivityFields.minTemp} $integerType,
        ${ActivityFields.maxTemp} $integerType,
        ${ActivityFields.isSunnyIdeal} $boolType,
        ${ActivityFields.isFogIdeal} $boolType,
        ${ActivityFields.isCloudyIdeal} $boolType,
        ${ActivityFields.isDrizzleIdeal} $boolType,
        ${ActivityFields.isRainyIdeal} $boolType,
        ${ActivityFields.isThunderstormIdeal} $boolType,
        ${ActivityFields.isSnowIdeal} $boolType
      )''');
    print("****Table is created ****** ");
  }

  Future<Activity> create(Activity activity) async {
    final db = await instance.database;

    final id = await db.insert(tableActivities, activity.toJson());

    return activity.copy(id: id);
  }

  Future<Activity> readActivity(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tableActivities,
      columns: ActivityFields.values,
      where: '${ActivityFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Activity.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<Activity>> readAllActivities() async {
    final db = await instance.database;

    final result = await db.query(tableActivities);

    return result.map((json) => Activity.fromJson(json)).toList();
  }

  Future<int> delete(int id) async {
    final db = await instance.database;

    return await db.delete(tableActivities,
        where: '${ActivityFields.id} = ?', whereArgs: [id]);
  }

  Future close() async {
    final db = await instance.database;
    _datatbase = null;
    db.close();
  }
}
