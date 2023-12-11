import 'package:ebook_escribo/modules/domain/entity/book_entity.dart';

import '../model/book.dart';

abstract class IManagerBookDatasource {
  Future<int> downloadBooks(Book book);
  Future<List<BookEntity>?> getAllDownloaded();
}