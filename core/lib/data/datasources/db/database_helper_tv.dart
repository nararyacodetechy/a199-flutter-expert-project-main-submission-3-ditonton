import 'package:core/core.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelperTv {
  static DatabaseHelperTv? _databaseHelperTv;
  DatabaseHelperTv._instance() {
    _databaseHelperTv = this;
  }

  factory DatabaseHelperTv() =>
      _databaseHelperTv ?? DatabaseHelperTv._instance();

  static Database? _database;

  Future<Database?> get database async {
    _database ??= await _initDb();
    return _database;
  }

  static const String _tabelWatchlistTv = 'watchlist';

  Future<Database> _initDb() async {
    final path = await getDatabasesPath();
    final databasePath = '$path/ditonton-tv.db';

    var db = await openDatabase(databasePath, version: 1, onCreate: _onCreate);
    return db;
  }

  void _onCreate(Database db, int version) async {
    await db.execute('''
     CREATE TABLE $_tabelWatchlistTv (
        id INTEGER PRIMARY KEY,
        name TEXT,
        overview TEXT,
        posterPath TEXT);
    ''');
  }

  Future<int> insertWatchListTv(TVTable tv) async {
    final db = await database;
    return await db!.insert(_tabelWatchlistTv, tv.toJson());
  }

  Future<int> removeWatchlistTv(TVTable tv) async {
    final db = await database;
    return await db!.delete(
      _tabelWatchlistTv,
      where: 'id = ?',
      whereArgs: [tv.id],
    );
  }

  Future<Map<String, dynamic>?> getTvById(int id) async {
    final db = await database;
    final results = await db!.query(
      _tabelWatchlistTv,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (results.isNotEmpty) {
      return results.first;
    } else {
      return null;
    }
  }

  Future<List<Map<String, dynamic>>> getWatchlistTvs() async {
    final db = await database;
    final List<Map<String, dynamic>> results =
        await db!.query(_tabelWatchlistTv);

    return results;
  }
}
