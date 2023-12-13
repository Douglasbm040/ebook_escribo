import 'package:dartz/dartz.dart';
import 'package:ebook_escribo/modules/domain/repositories/request_book_repository.dart';

import '../entity/book_entity.dart';
import '../errors/errors.dart';

abstract class IRequestBookUseCase {
  Future<Either<FailureRequestBook, List<BookEntity>>> getBooks(
      String endPointBook);
  Future<Either<FailureRequestBook, String>> downloadBook(String linkBook);
}

class RequestBookUseCase implements IRequestBookUseCase {
  final IRequestBookRepository requestBookRepository;

  RequestBookUseCase({required this.requestBookRepository});

  @override
  Future<Either<FailureRequestBook, List<BookEntity>>> getBooks(
      String endPointBook) async {
    if (endPointBook.isEmpty) {
      return Left(InvalidateEndPointBook());
    }
    return await requestBookRepository.getBooks(endPointBook);
  }

  @override
  Future<Either<FailureRequestBook, String>> downloadBook(
      String linkBook) async {
    if (linkBook.isEmpty) {
      return Left(InvalidateLinkBook());
    }

    return await requestBookRepository.downloadBook(linkBook);
  }
}
