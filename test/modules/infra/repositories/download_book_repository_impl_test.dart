import 'package:dartz/dartz.dart';
import 'package:ebook_escribo/modules/domain/entity/book_entity.dart';
import 'package:ebook_escribo/modules/domain/errors/errors.dart';
import 'package:ebook_escribo/modules/infra/datasources/imanager_book_datasource.dart';
import 'package:ebook_escribo/modules/infra/model/book.dart';
import 'package:ebook_escribo/modules/infra/repositories/manager_book_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class ManagerBookExternalMock extends Mock implements IManagerBookDatasource {}

void main() {
  late IManagerBookDatasource datasource;
  late ManagerBookRepositoryImpl repository;


  setUpAll(() {
    datasource = ManagerBookExternalMock();
    repository = ManagerBookRepositoryImpl(managerBookDatasource: datasource);
 
  });



  group("INFRA - Deve fazer o obter todo os livro baixados", () {
    test("Deve retornar todos os Livros", () async {
      when(() => datasource.getAllDownloaded())
          .thenAnswer((_) async => <BookEntity>[]);
      final result = await repository.getAllDownloaded();
      expect(result.isRight(), true);
    });
    test("Deve retornar um erro no download", () async {
      when(() => datasource.getAllDownloaded()).thenThrow(Exception());
      final result = await repository.getAllDownloaded();
      expect(result.fold(id, id), isA<SelectErrorBook>());
    });
  });

  group("INFRA - Deve fazer o obter todo os livro favoritos", () {
    test("Deve retornar todos os Livros favoritos", () async {
      when(() => datasource.getAllBooksFavorite())
          .thenAnswer((_) async => <BookEntity>[]);
      final result = await repository.getAllBooksFavorite();
      expect(result.isRight(), true);
    });
    test("Deve retornar um erro no buscar os favoritos", () async {
      when(() => datasource.getAllBooksFavorite()).thenThrow(Exception());
      final result = await repository.getAllBooksFavorite();
      expect(result.fold(id, id), isA<SelectErrorBook>());
    });
  });
}
