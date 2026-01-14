import '../imports/imports.dart';

class DownloadDb {
  static Database? db;

  static Future<Database> get database async {
    if (db != null) return db!;
    db = await initDb();
    return db!;
  }

  static Future<Database> initDb() async {
    final dir = await getApplicationDocumentsDirectory();
    final path = join(dir.path, 'downloads.db');

    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE downloads(
            id TEXT PRIMARY KEY,
            title TEXT,
            artist TEXT,
            filePath TEXT,
            artwork TEXT
          )
        ''');
      },
    );
  }

  static Future<void> insert(DownloadTrack track) async {
    final db = await database;
    await db.insert(
      'downloads',
      track.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<List<DownloadTrack>> getAll() async {
    final db = await database;
    final response = await db.query('downloads');
    return response.map(DownloadTrack.fromMap).toList();
  }

  static Future<void> delete(String id) async {
    final db = await database;
    await db.delete('downloads', where: 'id = ?', whereArgs: [id]);
  }
}
