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
  late Book paramm;
  setUp(() {
    datasource = ManagerBookExternalMock();
    repository = ManagerBookRepositoryImpl(managerBookDatasource: datasource);
    paramm = Book.fromBookEntity(BookEntity(
        favorite: 1,
        id: 1,
        title: "test",
        author: "as",
        coverUrl: "qweqw",
        downloadUrl: "asdas"));
  });

  group("INFRA - Deve fazer o download de um livro para o banco ", () {
    
    test("Deve retornar um erro no download", () async {
      when(() => datasource.downloadBooks(paramm)).thenThrow(Exception());
      final result = await repository.downloadBooks(paramm);
      expect(result.fold(id, (r) => null), isA<InsertErrorBook>());
    });
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
}
