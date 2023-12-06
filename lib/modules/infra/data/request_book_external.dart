import '../model/book.dart';

abstract class RequestBookExternal {
  Future<List<Book>> getBooks();
}