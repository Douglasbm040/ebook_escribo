// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import 'package:ebook_escribo/modules/domain/entity/book_entity.dart';
import 'package:ebook_escribo/modules/domain/usecases/manager_books_usecase.dart';
import 'package:ebook_escribo/modules/infra/model/book.dart';

part 'bookcontroller.g.dart';

class BookController = _BookControllerBase with _$BookController;

abstract class _BookControllerBase with Store {
  IManageBooksUseCase usecaseMangeBook = Modular.get<IManageBooksUseCase>();

  @observable
  BookEntity? book;

  Future<List<BookEntity>?> Function()? onFavorite;

  _BookControllerBase({
    this.book,
    this.onFavorite,
  });

  @action
  Future<void> isToggleFavorite(BookEntity book) async {
    int? operation;
    final response = await usecaseMangeBook.favoriteToggle(book);
    response.fold((l) => null, (r) => operation = r);

    if (operation == 2) {
      this.book = BookEntity(
          favorite: 2,
          id: book.id,
          title: book.title,
          author: book.author,
          coverUrl: book.coverUrl,
          downloadUrl: book.downloadUrl);
      print("cima");
      print(this.book?.favorite.toString());
      return;
    }
  
    this.book = BookEntity(
        favorite: 1,
        id: book.id,
        title: book.title,
        author: book.author,
        coverUrl: book.coverUrl,
        downloadUrl: book.downloadUrl);
          print("abaixo");
    print(this.book?.favorite.toString());
  }
}
