import 'package:path/path.dart';
import 'package:resqcare/models/user_model.dart';
// import 'package:ppkd_b4/day_19/model/student_model.dart';
// import 'package:ppkd_b4/day_19/model/user_model.dart';
// import 'package:flutter/painting.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  static const tableUser = 'user';
  static const tableLaporan = 'laporan';
  static Future<Database> db() async {
    final dbPath = await getDatabasesPath();
    return openDatabase(
      join(dbPath, 'GREEN.EARTH'),
      onCreate: (db, version) async {
        await db.execute(
          "CREATE TABLE $tableUser(id INTEGER PRIMARY KEY AUTOINCREMENT, username TEXT, email TEXT, password TEXT, kota TEXT, phone int)",
        );
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        if (newVersion > 2) {
          await db.execute(
            "CREATE TABLE $tableLaporan(id INTEGER PRIMARY KEY AUTOINCREMENT, laporan TEXT, email TEXT, class TEXT, age int)",
          );
        }
      },

      version: 3,
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

  //MENAMBAHKAN SISWA
  static Future<void> createPelapor(UserModel pelapor) async {
    final dbs = await db();
    //Insert adalah fungsi untuk menambahkan data (CREATE)
    await dbs.insert(
      tableLaporan,
      pelapor.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    print(pelapor.toMap());
  }

  //GET SISWA
  static Future<List<UserModel>> getAllPelapor() async {
    final dbs = await db();
    final List<Map<String, dynamic>> results = await dbs.query(tableUser);
    print(results.map((e) => UserModel.fromMap(e)).toList());
    return results.map((e) => UserModel.fromMap(e)).toList();
  }

  //UPDATE SISWA
  static Future<void> updatePelapor(UserModel user) async {
    final dbs = await db();
    //Insert adalah fungsi untuk menambahkan data (CREATE)
    await dbs.update(
      tableLaporan,
      user.toMap(),
      where: "id = ?",
      whereArgs: [user.id],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    print(user.toMap());
  }

  //DELETE SISWA
  static Future<void> deletePelapor(int id) async {
    final dbs = await db();
    //Insert adalah fungsi untuk menambahkan data (CREATE)
    await dbs.delete(tableUser, where: "id = ?", whereArgs: [id]);
  }
}
