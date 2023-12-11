import 'dart:convert' as convert;
import 'package:ebook_escribo/modules/infra/errors/errors.dart';
import 'package:http/http.dart' as http;
import 'package:ebook_escribo/modules/infra/model/book.dart';

import '../../infra/datasources/request_book_external.dart';

class HttpDatasource implements IRequestBookDatasource {
  final String url = "https://escribo.com/";
  final http.Client client;

  HttpDatasource({required this.client});

  @override
  Future<List<Book>> getBooks(String endPointBook) async {
    var response = await client.get(Uri.parse(url + endPointBook));
    if (response.statusCode == 200) {
      List<Map<String, dynamic>> responseJson =
          convert.jsonDecode(response.body).cast<Map<String, dynamic>>();
      List<Book> books =
          responseJson.map<Book>((json) => Book.fromJsonRequest(json)).toList();
      return books;
    } else {
      throw DatasourceFailure();
    }
  }
}
