// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import '../../domain/entity/book_entity.dart';
import '../../infra/datasources/imanager_book_datasource.dart';
import '../../infra/model/book.dart';

class DatabaseSqliteDatasource implements IManagerBookDatasource {
  late final Database _database;
  static DatabaseSqliteDatasource? _instance;

  DatabaseSqliteDatasource._(this._database);

  factory DatabaseSqliteDatasource(Database database) {
    _instance ??= DatabaseSqliteDatasource._(database);
    return _instance!;
  }

  static Future<DatabaseSqliteDatasource> getInstance() async {
    if (_instance == null) {
      sqfliteFfiInit();
      Database database = await openDatabase(
        join(await getDatabasesPath(), 'dbBIBLIOTECA.db'),
        onCreate: (db, version) async {
          await db.execute(BIBLIOTECA);
        },
        version: 1,
      );
      _instance = DatabaseSqliteDatasource._(database);
    }
    return _instance!;
  }

  static String get BIBLIOTECA => '''
      CREATE TABLE IF NOT EXISTS BIBLIOTECA (
        ID INTEGER,
        TITLE TEXT,
        AUTHOR TEXT,
        COVER_URL TEXT,
        DOWNLOAD_URL TEXT,
        FAVORITE INTEGER DEFAULT 1
      )
    ''';

  @override
  Future<List<BookEntity>?> getAllDownloaded() async {
    final db = _database;
    final List<Map<String, dynamic>> maps = await db.query("BIBLIOTECA");
    final listbookAll =
        List.generate(maps.length, (index) => Book.fromJsonDAO(maps[index]));

    return listbookAll;
  }

  @override
  Future<int> downloadBooks(Book book) async {
    final db = _database;
    int resultTransition = await db.insert('BIBLIOTECA', book.toJsonDAO(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    return resultTransition;
  }

  @override
  Future<int> favoriteToggle(Book book) async {
    final db = _database;
    int isfavorite = book.favorite == 1 ? 2 : 1;

    int resultTransition = await db.update(
      'BIBLIOTECA',
      {'FAVORITE': isfavorite},
      where: 'ID = ?',
      whereArgs: [book.id],
    );
    return resultTransition;
  }

  @override
  Future<List<BookEntity>?> getAllBooksFavorite() async {
    final db = _database;
    final List<Map<String, dynamic>> maps = await db.query(
      "BIBLIOTECA",
      where: "FAVORITE = ?",
      whereArgs: [1],
    );
    final listbookAll =
        List.generate(maps.length, (index) => Book.fromJsonDAO(maps[index]));
    return listbookAll;
  }
}
