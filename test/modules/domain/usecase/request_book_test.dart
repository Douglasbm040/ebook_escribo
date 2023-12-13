import 'package:dartz/dartz.dart';
import 'package:ebook_escribo/modules/domain/entity/book_entity.dart';
import 'package:ebook_escribo/modules/domain/errors/errors.dart';
import 'package:ebook_escribo/modules/domain/repositories/request_book_repository.dart';
import 'package:ebook_escribo/modules/domain/usecases/request_book_usecase.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:mocktail/mocktail.dart';

class RequestBookMock extends Mock implements IRequestBookRepository {}

void main() {
  late RequestBookMock request;
  late RequestBookUseCase usecase;
  setUp(() {
    request = RequestBookMock();
    usecase = RequestBookUseCase(requestBookRepository: request);
  });
  test('Deve retornar uma lista de livros', () async {
    // Configurar o comportamento esperado do mock
    when(() => request.getBooks("book")).thenAnswer(
        (_) async => const Right<FailureRequestBook, List<BookEntity>>(<BookEntity>[]));
    final result = await usecase.getBooks("book");
    expect(result, isA<Right>());   
  });
    test('Deve retornar uma FailureRequestBook, para string empty no argumento', () async {
    when(() => request.getBooks("book")).thenAnswer(
        (_) async => const Right<FailureRequestBook, List<BookEntity>>(<BookEntity>[]));
    final result = await usecase.getBooks("");
    expect(result.isLeft(), true);   
  });
   test('Deve baixar o livro', () async {
    // Configurar o comportamento esperado do mock
    when(() => request.downloadBook("book")).thenAnswer(
        (_) async => const Right<FailureRequestBook, String>("bytes"));
    final result = await usecase.downloadBook("book");
    expect(result, isA<Right>());   
  });
    test('Deve retornar uma FailureRequestBook, para string empty no argumento', () async {
    when(() => request.downloadBook("book")).thenAnswer(
        (_) async => const Right<FailureRequestBook, String>("bytes"));
    final result = await usecase.downloadBook("");
    expect(result.isLeft(), true);   
  });
}
