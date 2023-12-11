import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../../infra/datasources/Iconnection.dart';

class DataBaseSQLiteConnection implements IConnection<Database> {
  static Database? _database;

  @override
  Future<Database> getConnetion() async {
    if (_database != null) {
      return _database!;
    }
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'dbebook.db');

    return await openDatabase(path, version: 1, onCreate: _createTable);
  }

  Future<void> _createTable(Database db, int version) async {
    await db.execute('''
      CREATE TABLE EBOOK (
        ID INTEGER PRIMARY KEY AUTOINCREMENT,
        TITLE TEXT,
        AUTHOR TEXT,
        COVER_URL TEXT,
        DOWNLOAD_URL TEXT,
        FAVORITE INTEGER DEFAULT 1
      )
    ''');
  }
}
