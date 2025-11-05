import 'package:resqcare/models/modellaporan.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DbHelperLaporan {
  static Database? _laporan;

  static Future<Database> _initDb() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'resqcare.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE laporan(
            id TEXT PRIMARY KEY,
            jenisBencana TEXT,
            judul TEXT,
            deskripsi TEXT,
            lokasi TEXT,
            urgensi TEXT,
            tanggal TEXT
          )
        ''');
      },
    );
  }

  static Future<Database> get database async {
    _laporan ??= await _initDb();
    return _laporan!;
  }

  static Future<void> insertLaporan(Laporan laporan) async {
    final db = await database;
    await db.insert(
      'laporan',
      laporan.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<List<Laporan>> getLaporanList() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'laporan',
      orderBy: 'tanggal DESC',
    );

    return List.generate(maps.length, (i) {
      return Laporan.fromMap(maps[i]);
    });
  }
}
