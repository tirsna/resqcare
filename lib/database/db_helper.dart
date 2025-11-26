// import 'package:path/path.dart';
// import 'package:resqcare/models/modellaporan.dart';
// import 'package:resqcare/models/profailusermodel.dart';
// import 'package:resqcare/models/user_model.dart';
// // import 'package:ppkd_b4/day_19/model/student_model.dart';
// // import 'package:ppkd_b4/day_19/model/user_model.dart';
// // import 'package:flutter/painting.dart';
// import 'package:sqflite/sqflite.dart';

// class DbHelper {
//   static const tableUser = 'user';
//   static const tableLaporan = 'laporan';
//   static Future<Database> db() async {
//     final dbPath = await getDatabasesPath();
//     return openDatabase(
//       join(dbPath, 'green.db'),
//       onCreate: (db, version) async {
//         await db.execute('''
//           CREATE TABLE $tableLaporan(
//             id INTEGER PRIMARY KEY AUTOINCREMENT,
//             namapelapor TEXT,
//             jenisBencana TEXT,
//             judul TEXT,
//             deskripsi TEXT,
//             lokasi TEXT,
//             urgensi TEXT,
//             tanggal TEXT
//           )
//         ''');
//         await db.execute(
//           "CREATE TABLE $tableUser(id INTEGER PRIMARY KEY AUTOINCREMENT, username TEXT, email TEXT, password TEXT, kota TEXT, phone int)",
//         );
//       },

//       version: 4,
//     );
//   }

//   static Future<void> registerUser(UserModel user) async {
//     final dbs = await db();
//     //Insert adalah fungsi untuk menambahkan data (CREATE)
//     await dbs.insert(
//       tableUser,
//       user.toMap(),
//       conflictAlgorithm: ConflictAlgorithm.replace,
//     );

//     print(user.toMap());
//   }

//   static Future<UserModel?> loginUser({
//     required String email,
//     required String password,
//   }) async {
//     final dbs = await db();
//     //query adalah fungsi untuk menampilkan data (READ)
//     final List<Map<String, dynamic>> results = await dbs.query(
//       tableUser,
//       where: 'email = ? AND password = ?',
//       whereArgs: [email, password],
//     );
//     if (results.isNotEmpty) {
//       return UserModel.fromMap(results.first);
//     }
//     return null;
//   }

//   //MENAMBAHKAN SISWA
//   static Future<void> createPelapor(UserModel pelapor) async {
//     final dbs = await db();
//     //Insert adalah fungsi untuk menambahkan data (CREATE)
//     await dbs.insert(
//       tableLaporan,
//       pelapor.toMap(),
//       conflictAlgorithm: ConflictAlgorithm.replace,
//     );
//     print(pelapor.toMap());
//   }

//   //plpr
//   static Future<List<UserModel>> getAllPelapor() async {
//     final dbs = await db();
//     final List<Map<String, dynamic>> results = await dbs.query(tableUser);
//     print(results.map((e) => UserModel.fromMap(e)).toList());
//     return results.map((e) => UserModel.fromMap(e)).toList();
//   }

//   //UPDATE SISWA
//   static Future<void> updatePelapor(UserModel user) async {
//     final dbs = await db();
//     //Insert adalah fungsi untuk menambahkan data (CREATE)
//     await dbs.update(
//       tableLaporan,
//       user.toMap(),
//       where: "id = ?",
//       whereArgs: [user.id],
//       conflictAlgorithm: ConflictAlgorithm.replace,
//     );
//     print(user.toMap());
//   }

//   //fungsi delet laporan
//   static Future<void> deletePelapor(int id) async {
//     final dbs = await db();
//     await dbs.delete(tableLaporan, where: "id=?", whereArgs: [id]);
//     await dbs.delete(tableLaporan, where: "id = ?", whereArgs: [id]);
//   }

//   static Future<void> insertLaporan(Laporan laporan) async {
//     final dbs = await db();
//     print(laporan.toMap());
//     await dbs.insert(
//       tableLaporan,
//       laporan.toMap(),
//       conflictAlgorithm: ConflictAlgorithm.replace,
//     );
//   }

//   static Future<List<Laporan>> getLaporanList() async {
//     final dbs = await db();
//     final List<Map<String, dynamic>> maps = await dbs.query(
//       tableLaporan,
//       orderBy: 'tanggal DESC',
//     );
//     print(maps.map((e) => Laporan.fromMap(e)).toList());

//     return maps.map((e) => Laporan.fromMap(e)).toList();
//   }

//   // UPDATE PROFIL USER
//   static Future<void> updateUserProfile(profmodel user) async {
//     final dbs = await db();
//     await dbs.update(
//       tableUser,
//       user.toMap(),
//       where: "id = ?",
//       whereArgs: [user.id],
//       conflictAlgorithm: ConflictAlgorithm.replace,
//     );
//     print('User updated: ${user.toMap()}');
//   }

//   // GET USER BERDASARKAN ID
//   static Future<profmodel?> getUserById(int id) async {
//     final dbs = await db();
//     final List<Map<String, dynamic>> results = await dbs.query(
//       tableUser,
//       where: "id = ?",
//       whereArgs: [id],
//       limit: 1,
//     );
//     if (results.isNotEmpty) {
//       return profmodel.fromMap(results.first);
//     }
//     return null;
//   }

//   // UPDATE PROFIL USER
//   static Future<void> updateUerProfile(profmodel user) async {
//     final dbs = await db();
//     await dbs.update(
//       tableUser,
//       user.toMap(),
//       where: "id = ?",
//       whereArgs: [user.id],
//       conflictAlgorithm: ConflictAlgorithm.replace,
//     );
//     print('User updated: ${user.toMap()}');
//   }
// }
