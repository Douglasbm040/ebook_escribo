import 'package:dartz/dartz.dart';
import 'package:ebook_escribo/modules/domain/entity/book_entity.dart';
import 'package:ebook_escribo/modules/domain/errors/errors.dart';
import 'package:ebook_escribo/modules/domain/repositories/imanage_book_repository.dart';
import 'package:ebook_escribo/modules/domain/usecases/manager_books_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class ManageBooksMock extends Mock implements IManageBookRepository {}

void main() {
  late ManageBooksMock mock;
  late ManageBooksUseCase usecase;

  setUp(() {
    mock = ManageBooksMock();
    usecase = ManageBooksUseCase(manageBookRepository: mock);
  });
  group("grupo de test para usecade de download", () {
    test("deve fazer o download de um livro para o banco", () async {
      final paramm = BookEntity(
          favorite: 1,
          id: 1,
          title: "test",
          author: "as",
          coverUrl: "qweqw",
          downloadUrl: "asdas");
      when(() => mock.downloadBooks(paramm))
          .thenAnswer((_) async => const Right<FailureDownloadBook, int>(1));
      final result = await usecase.downloadBooks(paramm);
      expect(result.isRight(), true);
    });
    test("deve retornar um erro no download", () async {
      final paramm = BookEntity(
          favorite: 1,
          id: 1,
          title: "test",
          author: "as",
          coverUrl: "qweqw",
          downloadUrl: "asdas");
      when(() => mock.downloadBooks(paramm)).thenAnswer(
          (_) async => Left<FailureDownloadBook, int>(InsertErrorBook()));
      final result = await usecase.downloadBooks(paramm);
      expect(result.isLeft(), true);
    });
  });

  group("grupo de test para usecade de getAllDownloaded", () {
    test("deve recuperar o livro do banco", () async {
      when(() => mock.getAllDownloaded()).thenAnswer((_) async =>
          const Right<FailureDownloadBook, List<BookEntity>>(<BookEntity>[]));
      final result = await usecase.getAllDownloaded();
      expect(result.isRight(), true);
    });
    test("deve retorna um erro ao recuperar o livro", () async {
      when(() => mock.getAllDownloaded()).thenAnswer((_) async =>
          Left<FailureDownloadBook, List<BookEntity>>(InsertErrorBook()));
      final result = await usecase.getAllDownloaded();
      expect(result.isLeft(), true);
    });
  });
}
