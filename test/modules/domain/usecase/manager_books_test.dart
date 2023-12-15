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

  setUpAll(() {
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
      when(() => mock.downloadBook(paramm, "C:\\Users\\Douglas\\Downloads"))
          .thenAnswer((_) async => const Right<FailureDownloadBook, int>(1));
      final result =
          await usecase.downloadBook(paramm, "C:\\Users\\Douglas\\Downloads");
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
      when(() => mock.downloadBook(paramm,"C:\\Users\\Douglas\\Downloads")).thenAnswer(
          (_) async => Left<FailureDownloadBook, int>(InsertErrorBook()));
      final result = await usecase.downloadBook(paramm,"C:\\Users\\Douglas\\Downloads");
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
  group("grupo de test para usecade favorite", () {
    test("deve recuperar os livros do favoritos no banco", () async {
      when(() => mock.getAllBooksFavorite()).thenAnswer((_) async =>
          const Right<FailureDownloadBook, List<BookEntity>>(<BookEntity>[]));
      final result = await usecase.getAllBooksFavorite();
      expect(result.isRight(), true);
    });
    test("deve retorna um erro ao recuperar o livro favorito", () async {
      when(() => mock.getAllBooksFavorite()).thenAnswer((_) async =>
          Left<FailureDownloadBook, List<BookEntity>?>(SelectErrorBook()));
      final result = await usecase.getAllBooksFavorite();
      expect(result.isLeft(), true);
    });
  });
  group("grupo de test para usecade fazer update favorite", () {
    final paramm = BookEntity(
        favorite: 1,
        id: 1,
        title: "test",
        author: "as",
        coverUrl: "qweqw",
        downloadUrl: "asdas");
    test("deve trocar o estado de favorite do livro", () async {
      when(() => mock.favoriteToggle(paramm))
          .thenAnswer((_) async => const Right<FailureDownloadBook, int>(1));
      final result = await usecase.favoriteToggle(paramm);
      expect(result.isRight(), true);
    });
    test("deve retorna um erro ao recuperar o livro favorito", () async {
      when(() => mock.favoriteToggle(paramm)).thenAnswer(
          (_) async => Left<FailureDownloadBook, int>(UpdateErrorBook()));
      final result = await usecase.favoriteToggle(paramm);
      expect(result.isLeft(), true);
    });
  });
}
