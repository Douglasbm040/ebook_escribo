import 'package:dartz/dartz.dart';
import 'package:ebook_escribo/modules/domain/entity/book_entity.dart';
import 'package:ebook_escribo/modules/domain/errors/errors.dart';
import 'package:ebook_escribo/modules/domain/repository/request_book_repository.dart';
import 'package:ebook_escribo/modules/domain/usecase/request_livros.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:mocktail/mocktail.dart';

class RequestBookMock extends Mock implements RequestBookRepository {}

void main() {
  late RequestBookMock request;
  late RequestBookimpl usecase;
  setUp(() {
    request = RequestBookMock();
    usecase = RequestBookimpl(requestBookRepository: request);
  });
  test('Deve retornar uma lista de livros', () async {
    // Configurar o comportamento esperado do mock
    when(() => request.getBooks("book")).thenAnswer(
        (_) async => const Right<FailureRequestBook, List<BookEntity>>(<BookEntity>[]));
    final result = await usecase("book");
    expect(result, isA<Right>());   
  });
    test('Deve retornar uma FailureRequestBook', () async {
    when(() => request.getBooks("book")).thenAnswer(
        (_) async => const Right<FailureRequestBook, List<BookEntity>>(<BookEntity>[]));
    final result = await usecase("");
    expect(result.isLeft(), true);   
  });
}
