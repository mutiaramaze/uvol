import 'package:sqflite/sqflite.dart';
import 'package:uvol/model/user_model.dart';
import 'package:path/path.dart';

class DbHelper {
  static const tableUser = 'users';
  static const tableForum = 'forum';

  static Future<Database> db() async {
    final dbPath = await getDatabasesPath();
    return openDatabase(
      join(dbPath, 'uvol.db'),
      onCreate: (db, version) async {
        await db.execute(
          "CREATE TABLE $tableUser(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, email TEXT, password TEXT)",
        );
        await db.execute(
          "CREATE TABLE $tableForum(id INTEGER PRIMARY KEY AUTOINCREMENT, initial TEXT, name TEXT, time TEXT, upload TEXT)",
        );
      },

      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < newVersion) {
          await db.execute(
            "CREATE TABLE $tableForum(id INTEGER PRIMARY KEY AUTOINCREMENT, initial TEXT, name TEXT, time TEXT, upload TEXT)",
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
    //required String name,
    required String email,
    required String password,
  }) async {
    final dbs = await db();
    //query adalah fungsi untuk menampilkan data (READ)
    final List<Map<String, dynamic>> results = await dbs.query(
      tableUser,
      where: 'email = ? AND password = ?',
      whereArgs: [email, password],
    );
    if (results.isNotEmpty) {
      return UserModel.fromMap(results.first);
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

  static Future<List<ForumModel>> getPengeluaranByKategori(
    String kategori,
  ) async {
    final dbs = await db();
    final List<Map<String, dynamic>> results = await dbs.query(
      tablePengeluaran,
      where: 'kategoriPengeluaran = ?',
      whereArgs: [kategori],
    );
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
}
