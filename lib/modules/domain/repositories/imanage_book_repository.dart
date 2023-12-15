import 'package:dartz/dartz.dart';

import '../entity/book_entity.dart';
import '../errors/errors.dart';

abstract class IManageBookRepository {
  Future<Either<FailureDownloadBook, List<BookEntity>?>> getAllDownloaded();
  Future<Either<FailureDownloadBook, int>> downloadBook(
      BookEntity book, String path);
  Future<Either<FailureDownloadBook, int>> favoriteToggle(BookEntity book);
  Future<Either<FailureDownloadBook, List<BookEntity>?>> getAllBooksFavorite();
}
