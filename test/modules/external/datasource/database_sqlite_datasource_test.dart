import 'package:ebook_escribo/modules/domain/entity/book_entity.dart';
import 'package:ebook_escribo/modules/external/database/database_sqlite_datasource.dart';
import 'package:ebook_escribo/modules/infra/model/book.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  late Database database;
  late DatabaseSqliteDatasource datasource;

  setUpAll(() async {
    sqfliteFfiInit();
    database = await databaseFactoryFfi.openDatabase(inMemoryDatabasePath);
    database.execute(DatabaseSqliteDatasource.BIBLIOTECA);
    datasource = DatabaseSqliteDatasource(database);
  });
  test("Deve fazer a inserção de um livro", () async {
    await datasource.downloadBook(
        Book.fromBookEntity(BookEntity(
            favorite: 1,
            id: 1,
            title: "test",
            author: "as",
            coverUrl: "qweqw",
            downloadUrl: "asdas")),
        "C:\\Users\\Douglas\\Downloads");
    expect(await datasource.getAllDownloaded(), isA<List<BookEntity>>());
  });
  test("Deve recuperar o livro do banco", () async {
    expect(await datasource.getAllDownloaded(), isA<List<BookEntity>?>());
  });
  test("Deve fazer a moficação de um favorito de um livro", () async {
    await datasource.favoriteToggle(Book.fromBookEntity(BookEntity(
        favorite: 0,
        id: 1,
        title: "test",
        author: "as",
        coverUrl: "qweqw",
        downloadUrl: "asdas")));
    expect(await datasource.getAllBooksFavorite(), isA<List<BookEntity>>());
  });
  test("Deve recuperar os livros favoritos do banco", () async {
    expect(await datasource.getAllBooksFavorite(), isA<List<BookEntity>?>());
  });
}
