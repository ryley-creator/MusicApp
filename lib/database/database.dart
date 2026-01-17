import '../imports/imports.dart';

class LocalDB {
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
      version: 2,
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
        await db.execute('''
         CREATE TABLE favorites(
          id TEXT PRIMARY KEY,
          title TEXT,
          artist TEXT,
          image TEXT
          )
          ''');
      },
    );
  }

  static Future<void> addFavorite(Track track) async {
    final db = await database;
    await db.insert(
      'favorites',
      track.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<List<Track>> getFavorites() async {
    final db = await database;
    final response = await db.query('favorites');
    return response.map(Track.fromMap).toList();
  }

  static Future<void> removeFromFavorites(String id) async {
    final db = await database;
    await db.delete('favorites', where: 'id = ?', whereArgs: [id]);
  }

  static Future<bool> isFavorite(String id) async {
    final db = await database;
    final res = await db.query('favorites', where: 'id = ?', whereArgs: [id]);
    return res.isNotEmpty;
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
