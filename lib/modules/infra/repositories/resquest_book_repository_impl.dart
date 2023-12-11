import 'package:dartz/dartz.dart';

import 'package:ebook_escribo/modules/domain/entity/book_entity.dart';
import 'package:ebook_escribo/modules/domain/errors/errors.dart';

import '../../domain/repositories/request_book_repository.dart';
import '../datasources/request_book_external.dart';
import '../errors/errors.dart';

class RequestBookRepositoryImpl implements IRequestBookRepository {
  IRequestBookDatasource bookExternal;
  RequestBookRepositoryImpl({required this.bookExternal});

  @override
  Future<Either<FailureRequestBook, List<BookEntity>>> getBooks(
      String endPointBook) async {
    try {
      final response = await bookExternal.getBooks(endPointBook);

      return Right(response);
    } catch (e) {
      return left(DatasourceFailure());
    }
  }
}
