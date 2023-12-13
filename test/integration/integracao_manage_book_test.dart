import 'package:ebook_escribo/modules/app_module.dart';
import 'package:ebook_escribo/modules/domain/entity/book_entity.dart';
import 'package:ebook_escribo/modules/domain/usecases/manager_books_usecase.dart';
import 'package:ebook_escribo/modules/external/database/database_sqlite_datasource.dart';
import 'package:ebook_escribo/modules/infra/datasources/imanager_book_datasource.dart';
import 'package:ebook_escribo/modules/infra/model/book.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() async {
  sqfliteFfiInit();
  late IManageBooksUseCase usecase;
  late Book paramm;
  databaseFactory = databaseFactoryFfi;
  /*Database database =
      await databaseFactoryFfi.openDatabase(inMemoryDatabasePath);
  database.execute(DatabaseSqliteDatasource.BIBLIOTECA);*/
  DatabaseSqliteDatasource database =
      await DatabaseSqliteDatasource.getInstance();
  setUp(() async {
    Modular.bindModule(AppModule((() => database)));
    usecase = Modular.get<IManageBooksUseCase>();

    paramm = Book(
        favorite: 1,
        id: 1,
        title: "test",
        author: "as",
        coverUrl: "qweqw",
        downloadUrl: "asdas");
  });

  test('Deve retornar uma lista de livros', () async {
    var teste = await usecase.getAllDownloaded();
    expect(teste.isRight(), true);
  });
  test('Deve inserir um livro', () async {
    var teste = await usecase.downloadBooks(paramm);
    expect(teste.isRight(), true);
  });
  test('Deve retornar uma lista de livros favoritos', () async {
    var teste = await usecase.getAllBooksFavorite();
    expect(teste.isRight(), true);
  });
  test('Deve inserir um livro', () async {
    var teste = await usecase.favoriteToggle(paramm);
    expect(teste.isRight(), true);
  });
}
