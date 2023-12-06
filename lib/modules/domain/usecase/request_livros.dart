import 'package:dartz/dartz.dart';
import 'package:ebook_escribo/modules/domain/repositories/request_book_repository.dart';

import '../entity/book_entity.dart';
import '../errors/errors.dart';

abstract class IRequestBookUseCase {
  Future<Either<FailureRequestBook, List<BookEntity>>> call(String endPointBook);
}

class RequestBookimpl implements IRequestBookUseCase {
  final RequestBookRepository requestBookRepository;

  RequestBookimpl({required this.requestBookRepository});

  @override
  Future<Either<FailureRequestBook, List<BookEntity>>> call(String endPointBook) async {
    if (endPointBook.isEmpty) {
      return Left(InvalidateEndPointBook()); 
    }
    return await requestBookRepository.getBooks(endPointBook);
  }
}
