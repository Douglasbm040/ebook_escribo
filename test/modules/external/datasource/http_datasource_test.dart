import 'package:ebook_escribo/modules/external/datasource/http_datasource.dart';
import 'package:ebook_escribo/modules/infra/errors/errors.dart';
import 'package:ebook_escribo/modules/infra/model/book.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';

import '../../utils/data_mocks.dart';

class HttpClientMock extends Mock implements http.Client {}

void main() {
  late http.Client httpClient;
  late HttpDatasource datasource;
  setUp(() {
    httpClient = HttpClientMock();
    datasource = HttpDatasource(client: httpClient);
  });

  test("Deve retornar uma lista de livros", () async {
    when(() => httpClient.get(Uri.parse("https://escribo.com/books.json")))
        .thenAnswer((_) async => http.Response(bookjson, 200));
    var teste = await datasource.getBooks("books.json");
    expect(teste, isA<List<Book>>());
  });

  test("Deve retornar erro caso de status code diferente de 200 ", () async {
    when(() => httpClient.get(Uri.parse("https://escribo.com/books.json")))
        .thenAnswer((_) async => http.Response("", 300));
    final future = datasource.getBooks("books.json");
    expect(future, throwsA(isA<DatasourceFailure>()));
  });
}
