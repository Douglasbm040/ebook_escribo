import '../model/book.dart';

abstract class IRequestBookDatasource {
  Future<List<Book>> getBooks(String endPointBook);
  Future<String> downloadBook(String linkBook);
}
