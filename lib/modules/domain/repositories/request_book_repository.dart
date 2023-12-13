// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';

import '../entity/book_entity.dart';
import '../errors/errors.dart';

abstract class IRequestBookRepository {
  Future<Either<FailureRequestBook, List<BookEntity>>> getBooks(
      String endPointBook);
  Future<Either<FailureRequestBook, String>> downloadBook(String linkBook);
}
