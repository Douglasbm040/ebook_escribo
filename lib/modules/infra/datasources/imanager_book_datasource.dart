import 'package:ebook_escribo/modules/domain/entity/book_entity.dart';

import '../model/book.dart';

abstract class IManagerBookDatasource {
  Future<int> downloadBook(Book book, String path);
  Future<List<BookEntity>?> getAllDownloaded();
  Future<int> favoriteToggle(Book book);
  Future<List<BookEntity>?> getAllBooksFavorite();
}
