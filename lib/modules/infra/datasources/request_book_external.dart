import '../model/book.dart';

abstract class IRequestBookDatasource {
  Future<List<Book>> getBooks(String endPointBook);
}