import 'package:ebook_escribo/modules/app_module.dart';
import 'package:ebook_escribo/modules/domain/entity/book_entity.dart';
import 'package:ebook_escribo/modules/domain/usecases/manager_books_usecase.dart';
import 'package:ebook_escribo/modules/external/database/database_sqlite_datasource.dart';
import 'package:ebook_escribo/modules/infra/model/book.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() async {
  late IManageBooksUseCase usecase;
  setUp(() async{
    sqfliteFfiInit();
    Database database =
      await databaseFactoryFfi.openDatabase(inMemoryDatabasePath);
  database.execute(DatabaseSqliteDatasource.ebook);
    Modular.bindModule(AppModule(() => DatabaseSqliteDatasource(database)));
    usecase = Modular.get<IManageBooksUseCase>();
  });
    

  test('Deve retornar um livro', () async {
    var teste = await usecase.getAllDownloaded();
    expect(teste.isRight(), true);
  });
}
