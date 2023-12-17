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
        join(await getDatabasesPath(), 'BIBLIOTECA_EPUB.db'),
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

      CREATE TABLE BIBLIOTECA (
        ID INTEGER,
        TITLE TEXT,
        AUTHOR TEXT,
        COVER_URL TEXT,
        DOWNLOAD_URL TEXT,
        PATH TEXT,
        FAVORITE INTEGER DEFAULT 2 
      )
    ''';

  @override
  Future<List<BookEntity>?> getAllDownloaded() async {
    final db = _database;
    final List<Map<String, dynamic>> maps = await db.query(
      "BIBLIOTECA",
      where: "PATH IS NOT NULL",
    );
    print(maps);
    final listbookAll =
        List.generate(maps.length, (index) => Book.fromJsonDAO(maps[index]));
    return listbookAll;
  }

  @override
  Future<int> downloadBook(Book book, String path) async {
    int resultOperation = -1;
    final db = _database;

    final listBookDownloaded = await getAllDownloaded();
    int? position =
        listBookDownloaded?.indexWhere((element) => element.id == book.id);
    if (position != null && position >= 0 && path.isNotEmpty) {
      await db.update(
        'BIBLIOTECA',
        {'PATH': path},
        where: 'ID = ?',
        whereArgs: [book.id],
      );
      resultOperation = 1;
      return resultOperation;
    }
    if (position! < 0) {
      await db.insert(
          'BIBLIOTECA',
          Book(
                  path: path,
                  id: book.id,
                  title: book.title,
                  author: book.author,
                  coverUrl: book.coverUrl,
                  downloadUrl: book.downloadUrl,
                  favorite: book.favorite)
              .toJsonDAO(),
          conflictAlgorithm: ConflictAlgorithm.replace);
      resultOperation = 2;
      return resultOperation;
    }
    return -1;
  }

  @override
  Future<int> favoriteToggle(Book book) async {
    int resultOperation = -1;
    final db = _database;
    final getALLBooks = await db.query('BIBLIOTECA');

    int position =
        getALLBooks.indexWhere((element) => element["ID"] == book.id);
    if (position != null && position >= 0) {
      await db.update(
        'BIBLIOTECA',
        {'FAVORITE': book.favorite},
        where: 'ID = ?',
        whereArgs: [book.id],
      );
      resultOperation = 1;
      return resultOperation;
    }
    if (position! < 0) {
      await db.insert(
          'BIBLIOTECA',
          Book(
                  id: book.id,
                  title: book.title,
                  author: book.author,
                  coverUrl: book.coverUrl,
                  downloadUrl: book.downloadUrl,
                  favorite: book.favorite)
              .toJsonDAO(),
          conflictAlgorithm: ConflictAlgorithm.replace);

      return resultOperation;
    }
    return -1;
  }

  @override
  Future<List<BookEntity>?> getAllBooksFavorite() async {
    final db = _database;
    final List<Map<String, dynamic>> maps = await db.query(
      "BIBLIOTECA",
      where: "FAVORITE = 1",
    );

    final listbookAll =
        List.generate(maps.length, (index) => Book.fromJsonDAO(maps[index]));
    return listbookAll;
  }
}
