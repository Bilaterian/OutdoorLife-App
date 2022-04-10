import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/widgets.dart';

import '../models/activity.dart';

class DBProvider {
  DBProvider._();

  static final DBProvider dbp = DBProvider._();

  // !<!<!< WidgetsFlutterBinding.ensureInitialized();

  List<Activity> presetActivities = [
    Activity(
        order: 0,
        category: 0,
        activity: "Run",
        activityIconCP: Icons.directions_run.codePoint,
        minTemp: 0,
        maxTemp: 0,
        isSunnyIdeal: true,
        isFogIdeal: true,
        isCloudyIdeal: true,
        isDrizzleIdeal: true,
        isRainyIdeal: true,
        isThunderstormIdeal: true,
        isSnowIdeal: true),
    Activity(
        order: 1,
        category: 0,
        activity: "Ski",
        activityIconCP: Icons.downhill_skiing.codePoint,
        minTemp: 0,
        maxTemp: 0,
        isSunnyIdeal: true,
        isFogIdeal: true,
        isCloudyIdeal: true,
        isDrizzleIdeal: true,
        isRainyIdeal: true,
        isThunderstormIdeal: true,
        isSnowIdeal: true),
    // Activity(
    //     activity: "Picnic",
    //     activityIcon: Icons.,
    //     condition: condition,
    //     status: true),
    Activity(
        order: 2,
        category: 0,
        activity: "Surfing",
        activityIconCP: Icons.surfing.codePoint,
        minTemp: 0,
        maxTemp: 0,
        isSunnyIdeal: true,
        isFogIdeal: true,
        isCloudyIdeal: true,
        isDrizzleIdeal: true,
        isRainyIdeal: true,
        isThunderstormIdeal: true,
        isSnowIdeal: true),
    Activity(
        order: 3,
        category: 1,
        activity: "Swim",
        activityIconCP: Icons.pool.codePoint,
        minTemp: 0,
        maxTemp: 0,
        isSunnyIdeal: true,
        isFogIdeal: true,
        isCloudyIdeal: true,
        isDrizzleIdeal: true,
        isRainyIdeal: true,
        isThunderstormIdeal: true,
        isSnowIdeal: true),
    Activity(
        order: 4,
        category: 1,
        activity: "Hike",
        activityIconCP: Icons.hiking.codePoint,
        minTemp: 0,
        maxTemp: 0,
        isSunnyIdeal: true,
        isFogIdeal: true,
        isCloudyIdeal: true,
        isDrizzleIdeal: true,
        isRainyIdeal: true,
        isThunderstormIdeal: true,
        isSnowIdeal: true),
    Activity(
        order: 5,
        category: 1,
        activity: "FootBall",
        activityIconCP: Icons.sports_football.codePoint,
        minTemp: 0,
        maxTemp: 0,
        isSunnyIdeal: true,
        isFogIdeal: true,
        isCloudyIdeal: true,
        isDrizzleIdeal: true,
        isRainyIdeal: true,
        isThunderstormIdeal: true,
        isSnowIdeal: true),
    Activity(
        order: 6,
        category: 1,
        activity: "BasketBall",
        activityIconCP: Icons.sports_baseball.codePoint,
        minTemp: 0,
        maxTemp: 0,
        isSunnyIdeal: true,
        isFogIdeal: true,
        isCloudyIdeal: true,
        isDrizzleIdeal: true,
        isRainyIdeal: true,
        isThunderstormIdeal: true,
        isSnowIdeal: true),
    Activity(
        order: 7,
        category: 1,
        activity: "Soccer",
        activityIconCP: Icons.sports_soccer.codePoint,
        minTemp: 0,
        maxTemp: 0,
        isSunnyIdeal: true,
        isFogIdeal: true,
        isCloudyIdeal: true,
        isDrizzleIdeal: true,
        isRainyIdeal: true,
        isThunderstormIdeal: true,
        isSnowIdeal: true),
    Activity(
        order: 8,
        category: 1,
        activity: "Cricket",
        activityIconCP: Icons.sports_cricket.codePoint,
        minTemp: 0,
        maxTemp: 0,
        isSunnyIdeal: true,
        isFogIdeal: true,
        isCloudyIdeal: true,
        isDrizzleIdeal: true,
        isRainyIdeal: true,
        isThunderstormIdeal: true,
        isSnowIdeal: true),
    Activity(
        order: 9,
        category: 1,
        activity: "Golf",
        activityIconCP: Icons.sports_golf.codePoint,
        minTemp: 0,
        maxTemp: 0,
        isSunnyIdeal: true,
        isFogIdeal: true,
        isCloudyIdeal: true,
        isDrizzleIdeal: true,
        isRainyIdeal: true,
        isThunderstormIdeal: true,
        isSnowIdeal: true),
    Activity(
        order: 10,
        category: 1,
        activity: "Mix Martial Arts",
        activityIconCP: Icons.sports_handball.codePoint,
        minTemp: 0,
        maxTemp: 0,
        isSunnyIdeal: true,
        isFogIdeal: true,
        isCloudyIdeal: true,
        isDrizzleIdeal: true,
        isRainyIdeal: true,
        isThunderstormIdeal: true,
        isSnowIdeal: true),
  ];

  Database? _database;

  Future<Database?> getDatabase() async {
    if (_database != null) {
      //log("grabbing existing database??");

      return _database;
    } else {
      // if _database is null we instantiate it
      //log("initializing database??");
      _database = await initDB();

      return _database;
    }
  }

  /*
  initDB() async {
    log("initalizing database!?");
    WidgetsFlutterBinding.ensureInitialized();

    String path = join(await getDatabasesPath(), "activities_database.db");
    log(path);
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
          log("creating table");
          await db.execute(
              'CREATE TABLE activities(ord INTEGER PRIMARY KEY, category INTEGER, name TEXT, icon INTEGER, minTemp INTEGER, maxTemp INTEGER, sunny INTEGER, fog INTEGER, cloudy INTEGER, drizzle INTEGER, rainy INTEGER, thunderstorm INTEGER, snow INTEGER)'
          );

          log("initializing database with presets");

          // insert presets
          for (int i = 0; i < presetActivities.length; i++) {
            await db.insert(
              'activities',
              presetActivities[i].toMap(),
              conflictAlgorithm: ConflictAlgorithm.replace,
            );
          }
        });
  }

   */

  initDB() async {
    log("------start of initDB");
    WidgetsFlutterBinding.ensureInitialized();

    return await openDatabase(

      join(await getDatabasesPath(), 'activities_database.db'),

      onCreate: (db, version) {
        log("creating table");
        db.execute(
            'CREATE TABLE activities(ord INTEGER PRIMARY KEY, category INTEGER, name TEXT, icon INTEGER, minTemp INTEGER, maxTemp INTEGER, sunny INTEGER, fog INTEGER, cloudy INTEGER, drizzle INTEGER, rainy INTEGER, thunderstorm INTEGER, snow INTEGER)'
        );

        log("initializing database with presets");

        // insert presets
        for (int i = 0; i < presetActivities.length; i++) {
          db.insert(
            'activities',
            presetActivities[i].toMap(),
            conflictAlgorithm: ConflictAlgorithm.replace,
          );
        }
      },

      version: 1,
    );
  }

  Future<void> clearTable() async {
    log("clearing table");
    if (_database != null) {
      //final db = await getDatabase();
      await _database!.execute("DELETE FROM activities");
    }
  }

  Future<void> deleteTable() async {
    log("deleting table");
    if (_database != null) {
      final db = await getDatabase();
      await db!.execute("DROP TABLE IF EXISTS activities");
    }
  }

  Future<void> deleteDatabase() async {
    databaseFactory.deleteDatabase(await getDatabasesPath());
  }

  // Define a function that inserts activities into the database
  Future<void> insertActivity(Activity activity) async {
    //log("inserting " + activity.activity + "(" + activity.order.toString() + ")");
    final db = _database; //await getDatabase();

    await db!.insert(
      'activities',
      activity.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }


  Future<List<Activity>> getActivities() async {
    log("getting activities list from database");

    //log("---hello delete everything");
    //await deleteTable();
    //await deleteDatabase();
    //_database = null;
    //log("---bye delete everything");

    log("---hello getDatabase Call");
    final db = await getDatabase();
    log("---bye getDatabase Call");
    if (db == null) {
      log("getActivities: db is null");
    } else {
      log("getActivities: db is not null");

      bool temp = false;

      if (temp) {
        _database!.execute(
            'DROP TABLE IF EXISTS activities'
        );

        _database!.execute(
            'CREATE TABLE IF NOT EXISTS activities(ord INTEGER PRIMARY KEY, category INTEGER, name TEXT, icon INTEGER, minTemp INTEGER, maxTemp INTEGER, sunny INTEGER, fog INTEGER, cloudy INTEGER, drizzle INTEGER, rainy INTEGER, thunderstorm INTEGER, snow INTEGER)'
        );

        // insert presets
        print(await getDatabasesPath());
        for (int i = 0; i < presetActivities.length; i++) {
          _database!.insert(
            'activities',
            presetActivities[i].toMap(),
            conflictAlgorithm: ConflictAlgorithm.replace,
          );
          log("insert" + i.toString());
        }
      }



    }
    //return [];

    final List<Map<String, dynamic>> maps = await db!.query('activities');

    //log("!<!<!< map is " + maps.length.toString());

    List<Activity> temp = List.generate(maps.length, (i) {
      return Activity(
        order: maps[i]['ord'],
        category: maps[i]['category'],
        activity: maps[i]['name'],
        activityIconCP: maps[i]['icon'],
        minTemp: maps[i]['minTemp'],
        maxTemp: maps[i]['maxTemp'],
        isSunnyIdeal: maps[i]['sunny'] == 0 ? false : true,
        isFogIdeal: maps[i]['fog'] == 0 ? false : true,
        isCloudyIdeal: maps[i]['cloudy'] == 0 ? false : true,
        isDrizzleIdeal: maps[i]['drizzle'] == 0 ? false : true,
        isRainyIdeal: maps[i]['rainy'] == 0 ? false : true,
        isThunderstormIdeal: maps[i]['thunderstorm'] == 0 ? false : true,
        isSnowIdeal: maps[i]['snow'] == 0 ? false : true,
      );
    });

    //log("!<!<!< returned list is " + temp.length.toString());

    // Convert the List<Map<String, dynamic> into a List<Activities>.
    return temp;
  }

  Future<void> updateActivities(List<Activity> activities) async {
    await clearTable();

    for(int i = 0; i < activities.length; i++) {
      await DBProvider.dbp.insertActivity(activities[i]);
    }
  }

  Future<void> updateActivity(Activity activity) async {
    log("updating " + activity.activity);
    final db = await getDatabase();

    await db!.update(
      'activities',
      activity.toMap(),
      // Ensure that the Activity has a matching ord.
      where: 'ord = ?',
      whereArgs: [activity.order],
    );
  }

  Future<void> deleteActivity(int ord) async {
    log("deleting an activity");
    final db = await getDatabase();

    await db!.delete(
      'activites',
      // Use a `where` clause to delete a specific Activity.
      where: 'ord = ?',
      whereArgs: [ord],
    );
  }
}