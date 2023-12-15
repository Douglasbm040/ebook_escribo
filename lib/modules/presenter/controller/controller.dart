import 'package:ebook_escribo/modules/domain/usecases/request_book_usecase.dart';
import 'package:ebook_escribo/modules/presenter/controller/bookcontroller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../domain/entity/book_entity.dart';
import '../../domain/usecases/manager_books_usecase.dart';

import 'package:mobx/mobx.dart';
part 'controller.g.dart';

class Controller = _ControllerBase with _$Controller;

abstract class _ControllerBase with Store {
  IManageBooksUseCase usecaseMangeBook = Modular.get<IManageBooksUseCase>();
  IRequestBookUseCase usecaseResquestBook = Modular.get<IRequestBookUseCase>();
  @observable
  int selectedIndex = 0;

  @observable
  ObservableList<BookController> booksRequested =
      ObservableList<BookController>();
  @observable
  ObservableList<BookController> booksDownloaded =
      ObservableList<BookController>();
  @observable
  ObservableList<BookController> booksFavorite =
      ObservableList<BookController>();

  List<ObservableList<BookController>> listObserver() =>
      [booksRequested, booksDownloaded, booksFavorite];

  @action
  Future<List<BookEntity>?> getAllDownloaded() async {
    print("1802983");
    booksDownloaded = ObservableList<BookController>();
    List<BookEntity>? listBooks = [];
    final response = await usecaseMangeBook.getAllDownloaded();
    response.fold((l) => null, (r) => listBooks = r);
    listBooks?.forEach((e) => booksDownloaded
        .add(BookController(book: e, onFavorite: () => getAllFavorite())));
  }

  @action
  Future<List<BookEntity>?> getAllFavorite() async {
    print("576576");
    booksFavorite = ObservableList<BookController>();
    List<BookEntity>? listBooks = [];
    final response = await usecaseMangeBook.getAllBooksFavorite();
    response.fold((l) => null, (r) => listBooks = r);
    listBooks?.forEach((element) => booksFavorite.add(
        BookController(book: element, onFavorite: () => getAllFavorite())));
  }

  @action
  Future<List<BookEntity>?> getAllRequested() async {
    print("sjdkfjah");
    booksRequested = ObservableList<BookController>();
    List<BookEntity>? _booksRequested = [];
    final response = await usecaseResquestBook.getBooks("/books.json");
    response.fold((l) => null, (r) => _booksRequested = r);
    _booksRequested?.forEach((e) => booksRequested
        .add(BookController(book: e, onFavorite: () => getAllFavorite())));
  }

  @action
  Future<String> downloadBook(BookEntity book) async {
    String? path;
    final response = await usecaseResquestBook.downloadBook(book.downloadUrl);
    response.fold((l) => null, (r) => path = r);
    if (path != null || path!.isNotEmpty) {
      int? transation;
      final response = await usecaseMangeBook.downloadBook(book, path!);
      response.fold((l) => null, (r) => transation = r);
      if (transation! >= 0) {
        await getAllDownloaded();
        await getAllFavorite();
        return "O livro foi baixado com sucesso !";
      }
      return "Erro ao baixar o livro ! verifique sua conexão";
    } else {
      return "O livro já foi baixado !";
    }
  }

  Future<void> initStateList() async {
    getAllDownloaded();
    getAllFavorite();
    getAllRequested();
  }

  @action
  Future<void> onItemTapped(int index) async {
    selectedIndex = index;
    switch (index) {
      case 0:
        if (booksRequested.isEmpty) {
          await getAllRequested();
        }
        break;
      case 1:
        await getAllDownloaded();
        break;
      case 2:
        await getAllFavorite();
        break;
      default:
    }
  }
}
