import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:uvol/model/aboutme_model.dart';
import 'package:uvol/model/events.model.dart';
import 'package:uvol/model/forum_model.dart';
import 'package:uvol/model/user_model.dart';
import 'package:path/path.dart';
import 'package:uvol/preferences/preference_handler.dart';

class DbHelper {
  static const tableUser = 'users';
  static const tableForum = 'forum';
  static const tableEvents = 'events';
  static const tableAbout = 'about';

  static Future<Database> db() async {
    final dbPath = await getDatabasesPath();
    return openDatabase(
      join(dbPath, 'uvol.db'),
      onCreate: (db, version) async {
        await db.execute(
          "CREATE TABLE $tableUser(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, email TEXT, password TEXT)",
        );
        await db.execute(
          "CREATE TABLE $tableForum(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, time TEXT, posts TEXT)",
        );
        await db.execute(
          "CREATE TABLE $tableAbout(id INTEGER PRIMARY KEY AUTOINCREMENT, storyaboutme TEXT, skill TEXT, cv TEXT)",
        );
      },

      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < newVersion) {
          await db.execute(
            "CREATE TABLE $tableForum(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, time TEXT, upload TEXT)",
          );
        }
      },
      version: 5,
    );
  }

  static Future<void> registerUser(UserModel user) async {
    final dbs = await db();
    //Insert adalah fungsi untuk menambahkan data (CREATE)
    await dbs.insert(
      tableUser,
      user.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    print(user.toMap());
  }

  static Future<UserModel?> loginUser({
    required String email,
    required String password,
  }) async {
    final dbs = await db();

    // Query untuk mencari user dengan email & password cocok
    final List<Map<String, dynamic>> results = await dbs.query(
      tableUser,
      where: 'email = ? AND password = ?',
      whereArgs: [email, password],
    );

    if (results.isNotEmpty) {
      final user = UserModel.fromMap(results.first);

      // Simpan status login & data user ke SharedPreferences
      await PreferenceHandler.saveLogin(true);
      await PreferenceHandler.saveUser(user);

      return user;
    }

    return null;
  }

  //GET USER
  static Future<List<UserModel>> getAllUser() async {
    final dbs = await db();
    final List<Map<String, dynamic>> results = await dbs.query(tableUser);
    print(results.map((e) => UserModel.fromMap(e)).toList());
    return results.map((e) => UserModel.fromMap(e)).toList();
  }

  static Future<UserModel> getUser() async {
    final dbs = await db();
    final id = await PreferenceHandler.getUser();
    final result = await dbs.query(tableUser, where: "id = ?", whereArgs: [id]);
    print(UserModel.fromMap(result.first));
    print(UserModel.fromMap(result.first).name);
    return UserModel.fromMap(result.first);
  }

  //UPDATE
  static Future<void> updateUser(UserModel user) async {
    final dbs = await db();
    //Insert adalah fungsi untuk menambahkan data (CREATE)
    await dbs.update(
      tableUser,
      user.toMap(),
      where: "id = ?",
      whereArgs: [user.id],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    print(user.toMap());
  }

  //DELETE
  static Future<void> deleteUser(int id) async {
    final dbs = await db();
    //Insert adalah fungsi untuk menambahkan data (CREATE)
    await dbs.delete(tableUser, where: "id = ?", whereArgs: [id]);
  }

  //====Forum====
  static Future<void> insertPostingan(ForumModel postingan) async {
    final dbs = await db();
    //Insert adalah fungsi untuk menambahkan data (CREATE)
    await dbs.insert(
      tableForum,
      postingan.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    print(postingan.toMap());
  }

  static Future<List<ForumModel>> getAllPostingan() async {
    final dbs = await db();
    final List<Map<String, dynamic>> results = await dbs.query(tableForum);
    print(results.map((e) => ForumModel.fromMap(e)).toList());
    return results.map((e) => ForumModel.fromMap(e)).toList();
  }

  static Future<void> updatePostingan(ForumModel postingan) async {
    final dbs = await db();
    await dbs.update(
      tableForum,
      postingan.toMap(),
      where: 'id = ?',
      whereArgs: [postingan.id],
    );
  }

  static Future<void> deletePostingan(int id) async {
    final dbs = await db();
    await dbs.delete(tableForum, where: 'id = ?', whereArgs: [id]);
  }

  //====EVENTS====
  static Future<void> insertEvents(EventsModel events) async {
    final dbs = await db();
    //Insert adalah fungsi untuk menambahkan data (CREATE)
    await dbs.insert(
      tableEvents,
      events.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    print(events.toMap());
  }

  static Future<List<EventsModel>> getAllEvents() async {
    final dbs = await db();
    final List<Map<String, dynamic>> results = await dbs.query(tableEvents);
    print(results.map((e) => EventsModel.fromMap(e)).toList());
    return results.map((e) => EventsModel.fromMap(e)).toList();
  }

  static Future<void> updateEvents(EventsModel events) async {
    final dbs = await db();
    await dbs.update(
      tableEvents,
      events.toMap(),
      where: 'id = ?',
      whereArgs: [events.id],
    );
  }

  static Future<void> deleteEvents(int id) async {
    final dbs = await db();
    await dbs.delete(tableEvents, where: 'id = ?', whereArgs: [id]);
  }

  //==ABOUT ME==
  static Future<int> insertAbout(AboutModel about) async {
    final database = await db();
    return await database.insert(
      tableAbout,
      about.toMap(),
      conflictAlgorithm:
          ConflictAlgorithm.replace, // supaya tidak crash kalau id sama
    );
  }

  static Future<void> updateAbout(AboutModel about) async {
    final dbs = await db();
    await dbs.update(
      tableAbout,
      about.toMap(),
      where: 'id = ?',
      whereArgs: [about.id],
    );
  }
}
