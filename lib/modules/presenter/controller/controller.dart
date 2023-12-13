import 'package:ebook_escribo/modules/domain/usecases/request_book_usecase.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../domain/entity/book_entity.dart';
import '../../domain/usecases/manager_books_usecase.dart';

class Controller {
  IManageBooksUseCase usecaseMangeBook = Modular.get<IManageBooksUseCase>();
  IRequestBookUseCase usecaseResquestBook = Modular.get<IRequestBookUseCase>();

  List<BookEntity>? _booksRequested = [];
  List<BookEntity>? _booksDownloaded = [];
  List<BookEntity>? _booksFavorite = [];

  Future<List<BookEntity>?> getAllDownloaded() async {
    final response = await usecaseMangeBook.getAllDownloaded();
    response.fold((l) => null, (r) => _booksDownloaded = r);
    return _booksDownloaded;
  }

  Future<List<BookEntity>?> getAllFavorite() async {
    final response = await usecaseMangeBook.getAllBooksFavorite();
    response.fold((l) => null, (r) => _booksFavorite = r);
    return _booksFavorite;
  }

  Future<List<BookEntity>?> getAllRequested() async {
    final response = await usecaseResquestBook.getBooks("/books.json");
    response.fold((l) => null, (r) => _booksRequested = r);
    return _booksRequested;
  }

  Future<int> downloadBooks(BookEntity book, String url) async {
    final responseURL = await usecaseResquestBook.getBooks(url);
    responseURL.fold((l) => null, (r) => _booksRequested = r);
    final  responseTransaction = await usecaseMangeBook.downloadBooks(book);
    return responseTransaction.fold((l) => 0, (r) => r);
  }



}