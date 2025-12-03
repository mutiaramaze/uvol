import 'package:sqflite/sqflite.dart';
import 'package:uvol/database/model/aboutme_model.dart';
import 'package:uvol/database/model/events.model.dart';
import 'package:uvol/database/model/forum_model.dart';
import 'package:uvol/database/model/user_model.dart';
import 'package:path/path.dart';
import 'package:uvol/database/preferences/preference_handler.dart';

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
          "CREATE TABLE $tableUser(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, email TEXT, password TEXT, phone TEXT)",
        );
        await db.execute(
          "CREATE TABLE $tableAbout(id INTEGER PRIMARY KEY AUTOINCREMENT, storyaboutme TEXT, skill TEXT, cv TEXT)",
        );
        await db.execute(
          "CREATE TABLE $tableForum(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, time TEXT, upload TEXT)",
        );
      },
      version: 1,
    );
  }

  static Future<void> registerUser(UserModel user) async {
    final dbs = await db();
    await dbs.insert(
      tableUser,
      user.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<UserModel?> loginUser({
    required String email,
    required String password,
  }) async {
    final dbs = await db();

    final List<Map<String, dynamic>> results = await dbs.query(
      tableUser,
      where: 'email = ? AND password = ?',
      whereArgs: [email, password],
    );

    if (results.isNotEmpty) {
      final user = UserModel.fromMap(results.first);

      await PreferenceHandler.saveLogin(true);
      await PreferenceHandler.saveUser(user);

      return user;
    }

    return null;
  }

  static Future<List<UserModel>> getAllUser() async {
    final dbs = await db();
    final List<Map<String, dynamic>> results = await dbs.query(tableUser);
    return results.map((e) => UserModel.fromMap(e)).toList();
  }

  static Future<UserModel> getUser() async {
    final dbs = await db();
    final id = await PreferenceHandler.getUser();
    final result = await dbs.query(tableUser, where: "id = ?", whereArgs: [id]);
    return UserModel.fromMap(result.first);
  }

  static Future<void> updateUser(UserModel user) async {
    final dbs = await db();
    await dbs.update(
      tableUser,
      user.toMap(),
      where: "id = ?",
      whereArgs: [user.id],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<void> deleteUser(int id) async {
    final dbs = await db();
    await dbs.delete(tableUser, where: "id = ?", whereArgs: [id]);
  }

  static Future<void> insertPostingan(ForumModel postingan) async {
    final dbs = await db();
    await dbs.insert(
      tableForum,
      postingan.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<List<ForumModel>> getAllPostingan() async {
    final dbs = await db();
    final List<Map<String, dynamic>> results = await dbs.query(tableForum);
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

  static Future<void> deletePostingan(String id) async {
    final dbs = await db();
    await dbs.delete(tableForum, where: 'id = ?', whereArgs: [id]);
  }

  static Future<void> insertEvents(EventsModel events) async {
    final dbs = await db();
    await dbs.insert(
      tableEvents,
      events.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<List<EventsModel>> getAllEvents() async {
    final dbs = await db();
    final List<Map<String, dynamic>> results = await dbs.query(tableEvents);
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

  static Future<AboutModel?> getAbout() async {
    final dbs = await db();
    final res = await dbs.query(tableAbout, limit: 1);
    if (res.isNotEmpty) {
      return AboutModel.fromMap(res.first);
    }
    return null;
  }

  static Future<void> insertAbout(AboutModel about) async {
    final database = await db();
    await database.insert(tableAbout, about.toMap());
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
