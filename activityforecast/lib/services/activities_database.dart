import 'dart:async';
import 'dart:developer';

import 'package:activityforecast/components/themes/manage_activities_colors.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:activityforecast/models/activity.dart';

List<Activity> moreActivities = [
  Activity(
      activity: "Run",
      activityIcon: Icons.directions_run,
      status: true,
      minTemp: 40,
      maxTemp: 70,
      isSunnyIdeal: true,
      isFogIdeal: true,
      isCloudyIdeal: true,
      isDrizzleIdeal: true,
      isRainyIdeal: true,
      isThunderstormIdeal: false,
      isSnowIdeal: true),
  Activity(
      activity: "Ski",
      activityIcon: Icons.downhill_skiing,
      status: true,
      minTemp: 0,
      maxTemp: 40,
      isSunnyIdeal: true,
      isFogIdeal: true,
      isCloudyIdeal: true,
      isDrizzleIdeal: true,
      isRainyIdeal: true,
      isThunderstormIdeal: false,
      isSnowIdeal: true),
  Activity(
      activity: "Surfing",
      activityIcon: Icons.surfing,
      status: true,
      minTemp: 50,
      maxTemp: 75,
      isSunnyIdeal: true,
      isFogIdeal: true,
      isCloudyIdeal: true,
      isDrizzleIdeal: false,
      isRainyIdeal: false,
      isThunderstormIdeal: false,
      isSnowIdeal: false),
  Activity(
      activity: "Swim",
      activityIcon: Icons.pool,
      status: true,
      minTemp: 1,
      maxTemp: 80,
      isSunnyIdeal: true,
      isFogIdeal: true,
      isCloudyIdeal: true,
      isDrizzleIdeal: true,
      isRainyIdeal: true,
      isThunderstormIdeal: true,
      isSnowIdeal: true),
  Activity(
      activity: "Hike",
      activityIcon: Icons.hiking,
      status: true,
      minTemp: 1,
      maxTemp: 80,
      isSunnyIdeal: true,
      isFogIdeal: true,
      isCloudyIdeal: true,
      isDrizzleIdeal: true,
      isRainyIdeal: true,
      isThunderstormIdeal: true,
      isSnowIdeal: true),
  Activity(
      activity: "FootBall",
      activityIcon: Icons.sports_football,
      status: true,
      minTemp: 1,
      maxTemp: 80,
      isSunnyIdeal: true,
      isFogIdeal: true,
      isCloudyIdeal: true,
      isDrizzleIdeal: true,
      isRainyIdeal: true,
      isThunderstormIdeal: true,
      isSnowIdeal: true),
  Activity(
      activity: "BasketBall",
      activityIcon: Icons.sports_baseball,
      status: true,
      minTemp: 1,
      maxTemp: 80,
      isSunnyIdeal: true,
      isFogIdeal: true,
      isCloudyIdeal: true,
      isDrizzleIdeal: true,
      isRainyIdeal: true,
      isThunderstormIdeal: true,
      isSnowIdeal: true),
  Activity(
      activity: "Soccer",
      activityIcon: Icons.sports_soccer,
      status: true,
      minTemp: 1,
      maxTemp: 80,
      isSunnyIdeal: true,
      isFogIdeal: true,
      isCloudyIdeal: true,
      isDrizzleIdeal: true,
      isRainyIdeal: true,
      isThunderstormIdeal: true,
      isSnowIdeal: true),
  Activity(
      activity: "Cricket",
      activityIcon: Icons.sports_cricket,
      status: true,
      minTemp: 1,
      maxTemp: 80,
      isSunnyIdeal: true,
      isFogIdeal: true,
      isCloudyIdeal: true,
      isDrizzleIdeal: true,
      isRainyIdeal: true,
      isThunderstormIdeal: true,
      isSnowIdeal: true),
  Activity(
      activity: "Golf",
      activityIcon: Icons.sports_golf,
      status: true,
      minTemp: 1,
      maxTemp: 80,
      isSunnyIdeal: true,
      isFogIdeal: true,
      isCloudyIdeal: true,
      isDrizzleIdeal: true,
      isRainyIdeal: true,
      isThunderstormIdeal: true,
      isSnowIdeal: true),
  Activity(
      activity: "Mix Martial Arts",
      activityIcon: Icons.sports_handball,
      status: true,
      minTemp: 1,
      maxTemp: 80,
      isSunnyIdeal: true,
      isFogIdeal: true,
      isCloudyIdeal: true,
      isDrizzleIdeal: true,
      isRainyIdeal: true,
      isThunderstormIdeal: true,
      isSnowIdeal: true),
];

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
    // final dbPath = await getDatabasesPath();
    final path = join(await getDatabasesPath(), filePath);
    log("***INIT DB***");
    log(path);
    // !<!<!<
    //await deleteDatabase(path);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  // Future<Database> _initDB(String filepath) async {
  //   final dbPath = await getDatabasesPath();
  //   return openDatabaseR(join(dbPath, filepath),
  //       onCreate: (db, version) => _createDB, version: 2);
  // }

  // static void _createDb(Database db) {
  //   // db.execute('CREATE TABLE mytable(date TEXT PRIMARY KEY, value DOUBLE)');
  //   // db.execute('CREATE TABLE mytableb(date TEXT PRIMARY KEY, value DOUBLE)');
  // }

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
    log("****Table1 is created ****** ");
    await db.execute('''
      CREATE TABLE $tableActivities2 (
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

    for (int i = 0; i < moreActivities.length; i++) {
      db.insert(
        tableActivities2,
        moreActivities[i].toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
    log("****Table2 is created ****** ");
  }

  Future<Activity> create(Activity activity) async {
    final db = await instance.database;

    final id = await db.insert(tableActivities, activity.toJson());

    return activity.copy(id: id);
  }

  Future<Activity> create2(Activity activity) async {
    final db = await instance.database;

    final id = await db.insert(tableActivities2, activity.toJson());

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

  Future<Activity> readActivity2(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tableActivities2,
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

  Future<List<Activity>> readAllActivities2() async {
    final db = await instance.database;

    final result = await db.query(tableActivities2);

    return result.map((json) => Activity.fromJson(json)).toList();
  }

  Future<int> delete(int id) async {
    final db = await instance.database;

    int idd = 0;

    List<Map> tasksQuery = await db.rawQuery("SELECT * FROM $tableActivities");
    for (int i = 0; i < tasksQuery.length; i++) {
      if (id == i) {
        idd = tasksQuery[i]["_id"];
        //log("HELLLO");

        //print(idd);
      }
    }

    return await db.delete(tableActivities,
        where: '${ActivityFields.id} = ?', whereArgs: [idd]);
  }

  Future<int> delete2(int id) async {
    final db = await instance.database;
    int idd = 0;

    List<Map> tasksQuery = await db.rawQuery("SELECT * FROM $tableActivities2");
    //print(tasksQuery);
    for (int i = 0; i < tasksQuery.length; i++) {
      if (id == i) {
        idd = tasksQuery[i]["_id"];
        // log(tasksQuery[i]["_id"]);

        //print(idd);
      }
    }

    return await db.delete(tableActivities2,
        where: '${ActivityFields.id} = ?', whereArgs: [idd]);
  }

  Future close() async {
    final db = await instance.database;
    _datatbase = null;
    db.close();
  }
}
