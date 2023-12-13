import 'package:dartz/dartz.dart';

import '../entity/book_entity.dart';
import '../errors/errors.dart';
import '../repositories/imanage_book_repository.dart';

abstract class IManageBooksUseCase {
  Future<Either<FailureDownloadBook, List<BookEntity>?>> getAllDownloaded();
  Future<Either<FailureDownloadBook, int>> downloadBooks(BookEntity book);
  Future<Either<FailureDownloadBook, int>> favoriteToggle(BookEntity book);
  Future<Either<FailureDownloadBook, List<BookEntity>?>> getAllBooksFavorite();
}

class ManageBooksUseCase implements IManageBooksUseCase {
  IManageBookRepository manageBookRepository;
  ManageBooksUseCase({
    required this.manageBookRepository,
  });

  @override
  Future<Either<FailureDownloadBook, int>> downloadBooks(
      BookEntity book) async {
    return await manageBookRepository.downloadBooks(book);
  }

  @override
  Future<Either<FailureDownloadBook, List<BookEntity>?>>
      getAllDownloaded() async {
    return await manageBookRepository.getAllDownloaded();
  }

  @override
  Future<Either<FailureDownloadBook, int>> favoriteToggle(
      BookEntity book) async {
    return await manageBookRepository.favoriteToggle(book);
  }

  @override
  Future<Either<FailureDownloadBook, List<BookEntity>?>>
      getAllBooksFavorite() async {
    return await manageBookRepository.getAllBooksFavorite();
  }
}
