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
  Future<Either<FailureDownloadBook, int>> downloadBooks(
      BookEntity book) async {
    try {
      int resultOperation =
          await managerBookDatasource.downloadBooks(Book.fromBookEntity(book));
      if (resultOperation >= 1) {
        return right(resultOperation);
      }
      return left(InsertErrorBook());
    } catch (e) {
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
}
