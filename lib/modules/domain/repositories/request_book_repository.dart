import 'package:dartz/dartz.dart';

import '../entity/book_entity.dart';
import '../errors/errors.dart';

abstract class RequestBookRepository {
  Future<Either<FailureRequestBook, List<BookEntity>>> getBooks(String endPointBook);
}