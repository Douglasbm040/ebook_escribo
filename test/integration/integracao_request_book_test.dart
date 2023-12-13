import 'package:ebook_escribo/modules/app_module.dart';
import 'package:ebook_escribo/modules/domain/usecases/request_book_usecase.dart';
import 'package:ebook_escribo/modules/external/database/database_sqlite_datasource.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() async {
  late IRequestBookUseCase usecase;

  setUp(() async {
    sqfliteFfiInit();
    Database database =
        await databaseFactoryFfi.openDatabase(inMemoryDatabasePath);
    database.execute(DatabaseSqliteDatasource.BIBLIOTECA);
    Modular.bindModule(AppModule(() => DatabaseSqliteDatasource(database)));
    usecase = Modular.get<IRequestBookUseCase>();
  });
  test('Deve executar todo o servico de buscar de livro', () async {
    var teste = await usecase("books.json");
    expect(teste.isRight(), true);
  });
}
