import 'package:dartz/dartz.dart';
import 'package:ebook_escribo/modules/infra/datasources/request_book_external.dart';
import 'package:ebook_escribo/modules/infra/errors/errors.dart';
import 'package:ebook_escribo/modules/infra/model/book.dart';
import 'package:ebook_escribo/modules/infra/repositories/resquest_book_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:mocktail/mocktail.dart';

class RequestBookExternalMock extends Mock implements IRequestBookDatasource {}

void main() {
  late RequestBookRepositoryImpl datasourceRequest;
  late IRequestBookDatasource bookExternal;
  setUp(() {
    bookExternal = RequestBookExternalMock();
    datasourceRequest = RequestBookRepositoryImpl(bookExternal: bookExternal);
  });

  test('Deve retornar uma lista de livros', () async {
    when(() => bookExternal.getBooks("/books.json"))
        .thenAnswer((_) async => <Book>[]);
    final result = await datasourceRequest.getBooks("/books.json");
    expect(result, isA<Right>());
  });
  test('Deve retornar uma DatasourceFailure caso de retorno de erro', () async {
    when(() => bookExternal.getBooks("/books.json")).thenThrow(Exception());
    final result = await datasourceRequest.getBooks("/books.json");
    expect(result.fold(id, id), isA<DatasourceFailure>());
  });
  test('Deve retornar um livro baixado', () async {
    when(() => bookExternal.downloadBook("/books.json"))
        .thenAnswer((_) async => "bytes");
    final result = await datasourceRequest.downloadBook("/books.json");
    expect(result, isA<Right>());
  });
  test('Deve retornar uma DatasourceFailure caso de retorno de erro', () async {
    when(() => bookExternal.downloadBook("/books.json")).thenThrow(Exception());
    final result = await datasourceRequest.downloadBook("/books.json");
    expect(result.fold(id, id), isA<DatasourceFailure>());
  });
}
