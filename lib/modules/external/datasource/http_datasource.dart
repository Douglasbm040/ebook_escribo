import 'dart:convert' as convert;
import 'dart:io';
import 'dart:math';
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

  @override
  Future<String> downloadBook(String linkBook) async {
    try {
      final response = await client.get(Uri.parse(linkBook));
      final String fileName = "${Random().nextInt(100) + 1}";

      if (response.statusCode == 200) {
        final Directory appDocDir = await Directory.systemTemp;
        final String downloadPath = '${appDocDir.path}/$fileName.epub';

        final File file = File(downloadPath);
        await file.writeAsBytes(response.bodyBytes);
        Future.delayed(const Duration(seconds: 1));

        return downloadPath;
      } else {
        throw DatasourceFailure();
      }
    } catch (e) {
      throw DatasourceFailure();
    }
  }
}
