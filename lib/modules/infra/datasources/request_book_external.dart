import '../model/book.dart';

abstract class RequestBookDatasource {
  Future<List<Book>> getBooks(String endPointBook);
}