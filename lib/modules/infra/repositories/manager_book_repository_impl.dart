import 'package:dartz/dartz.dart';
import 'package:ebook_escribo/modules/domain/entity/book_entity.dart';
import 'package:ebook_escribo/modules/infra/model/book.dart';

import '../../domain/errors/errors.dart';
import '../../domain/repositories/imanage_book_repository.dart';
import '../datasources/imanager_book_datasource.dart';

class ManagerBookRepositoryImpl implements IManageBookRepository {
  IManagerBookDatasource managerBookDatasource;
  ManagerBookRepositoryImpl({required this.managerBookDatasource});
  @override
  Future<Either<FailureDownloadBook, int>> downloadBook(
      BookEntity book,String path) async {
    int resultOperation =
        await managerBookDatasource.downloadBook(Book.fromBookEntity(book), path); ;
    if (resultOperation >= 0) {
      return right(resultOperation);
    } else {
      return left(InsertErrorBook());
    }
  }

  @override
  Future<Either<FailureDownloadBook, List<BookEntity>?>>
      getAllDownloaded() async {
    try {
      final result = await managerBookDatasource.getAllDownloaded();
      return right(result);
    } catch (e) {
      return left(SelectErrorBook());
    }
  }

  @override
  Future<Either<FailureDownloadBook, int>> favoriteToggle(
      BookEntity book) async {
    try {
      int resultOperation =
          await managerBookDatasource.favoriteToggle(Book.fromBookEntity(book));
      if (resultOperation >= 0) {
        return right(resultOperation);
      }
      return left(UpdateErrorBook());
    } catch (e) {
      return left(UpdateErrorBook());
    }
  }

  @override
  Future<Either<FailureDownloadBook, List<BookEntity>?>>
      getAllBooksFavorite() async {
    try {
      final result = await managerBookDatasource.getAllBooksFavorite();
      return right(result);
    } catch (e) {
      return left(SelectErrorBook());
    }
  }
}
