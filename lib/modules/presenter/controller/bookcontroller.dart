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
    if (operation! >= 0) {
      if (book.favorite == 2) {
        this.book = Book.fromBookEntity(book).copyWith(favorite: 1);

        return;
      }

      this.book = Book.fromBookEntity(book).copyWith(favorite: 2);
    }
  }
}
