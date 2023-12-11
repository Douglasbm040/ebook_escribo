import 'package:dartz/dartz.dart';

import '../entity/book_entity.dart';
import '../errors/errors.dart';
import '../repositories/imanage_book_repository.dart';

abstract class IManageBooksUseCase {
  Future<Either<FailureDownloadBook, List<BookEntity>?>> getAllDownloaded();
  Future<Either<FailureDownloadBook, void>> downloadBooks(BookEntity book);
}

class ManageBooksUseCase implements IManageBooksUseCase {
  IManageBookRepository manageBookRepository;
  ManageBooksUseCase({
    required this.manageBookRepository,
  });

  @override
  Future<Either<FailureDownloadBook, void>> downloadBooks(BookEntity book) {
    return manageBookRepository.downloadBooks(book);
  }

  @override
  Future<Either<FailureDownloadBook, List<BookEntity>?>> getAllDownloaded() {
    return manageBookRepository.getAllDownloaded();
  }
}
