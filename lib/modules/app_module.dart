import 'package:ebook_escribo/modules/domain/repositories/request_book_repository.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:http/http.dart' as http;

import 'domain/usecase/request_livros.dart';
import 'external/datasource/http_datasource.dart';
import 'infra/repositories/resquest_book_repository_impl.dart';

class AppModule extends Module {
  @override
  void binds(i) {
    i.add<RequestBookimpl>(RequestBookimpl.new);
    i.add<RequestBookRepositoryImpl>(RequestBookRepositoryImpl.new);
    i.add<HttpDatasource>(HttpDatasource.new);
    i.add<http.Client>(http.Client.new);
  }
}
