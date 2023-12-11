// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ebook_escribo/modules/domain/entity/book_entity.dart';
import 'package:path/path.dart';
import 'package:ebook_escribo/modules/infra/model/book.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import '../../infra/datasources/imanager_book_datasource.dart';

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
        join(await getDatabasesPath(), 'dbebook.db'),
        onCreate: (db, version) async {
          await db.execute(ebook);
        },
        version: 1,
      );
      _instance = DatabaseSqliteDatasource._(database);
    }
    return _instance!;
  }

  static String get ebook => '''
      CREATE TABLE EBOOK (
        ID INTEGER PRIMARY KEY AUTOINCREMENT,
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
    final List<Map<String, dynamic>> maps = await db.query("EBOOK");
    final listbookAll =
        List.generate(maps.length, (index) => Book.fromJsonDAO(maps[index]));

    return listbookAll;
  }

  @override
  Future<int> downloadBooks(Book book) async {
    final db = _database;
    int resultTransition = await db.insert('EBOOK', book.toJsonDAO(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    return resultTransition;
  }
}
