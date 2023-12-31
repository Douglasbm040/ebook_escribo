import 'package:ebook_escribo/modules/domain/usecases/request_book_usecase.dart';
import 'package:ebook_escribo/modules/infra/model/book.dart';
import 'package:ebook_escribo/modules/presenter/controller/bookcontroller.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../domain/entity/book_entity.dart';
import '../../domain/usecases/manager_books_usecase.dart';

import 'package:mobx/mobx.dart';
part 'controller.g.dart';

// ignore: library_private_types_in_public_api
class Controller = _ControllerBase with _$Controller;

abstract class _ControllerBase with Store {
  IManageBooksUseCase usecaseMangeBook = Modular.get<IManageBooksUseCase>();
  IRequestBookUseCase usecaseResquestBook = Modular.get<IRequestBookUseCase>();
  @observable
  int selectedIndex = 0;

  @observable
  ObservableList<BookEntity> booksRequested = ObservableList<BookEntity>();
  @observable
  ObservableList<BookEntity> booksDownloaded = ObservableList<BookEntity>();
  @observable
  ObservableList<BookEntity> booksFavorite = ObservableList<BookEntity>();

  List<ObservableList<BookEntity>> listObserver() =>
      [booksRequested, booksDownloaded, booksFavorite];

  @action
  Future<void> getAllDownloaded() async {
    List<BookEntity>? listBooks = [];
    final response = await usecaseMangeBook.getAllDownloaded();
    response.fold((l) => null, (r) => listBooks = r);
    for (int i = 0; i < listBooks!.length; i++) {
      if (i < booksDownloaded.length) {
        booksDownloaded.removeAt(i);
      }
      booksDownloaded.insert(i, listBooks![i]);
    }
  }

  @action
  Future<void> getAllFavorite() async {
    List<BookEntity>? listBooks = [];
    booksFavorite.clear();
    final response = await usecaseMangeBook.getAllBooksFavorite();
    response.fold((l) => null, (r) => listBooks = r);

    for (int i = 0; i < listBooks!.length; i++) {
      booksFavorite.add(listBooks![i]);
    }
  }

  @action
  Future<void> getAllRequested() async {
    List<BookEntity>? cachebooksRequested = [];
    final response = await usecaseResquestBook.getBooks("/books.json");
    response.fold((l) => null, (r) => cachebooksRequested = r);

    for (int i = 0; i < cachebooksRequested!.length; i++) {
      if (i < booksRequested.length) {
        booksRequested.removeAt(i);
      }
      booksRequested.insert(i, cachebooksRequested![i]);
    }
  }

  @action
  Future<String> downloadBook(BookEntity book) async {
    String? path;
    final response = await usecaseResquestBook.downloadBook(book.downloadUrl);
    response.fold((l) => null, (r) => path = r);
    if (path != null) {
      int? transation;
      final response = await usecaseMangeBook.downloadBook(book, path!);
      response.fold((l) => null, (r) => transation = r);
      switch (transation) {
        case 1:
          await initStateList();
          return "você já possue este livro";

        case 2:
          booksDownloaded.add(book);
          await getAllDownloaded();

          return "O livro foi adicionado a sua lista de downloads";
        default:
          return "Erro ao baixar o livro, por favor verifique sua conexão";
      }
    }
    return "ops... ocorreu um erro ao baixar o livro, tente novamente mais tarde";
  }

  @action
  Future initStateList() async {
    await Future.wait<void>(
        [getAllDownloaded(), getAllFavorite(), getAllRequested()]);
  }

  @action
  Future<void> onItemTapped(int index) async {
    selectedIndex = index;
    switch (index) {
      case 0:
        await getAllRequested();
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

  @action
  Future<void> isToggleFavorite(
      BookEntity book, BookController controller) async {
    int insertfavorite = controller.favorite ? 2 : 1;

    await usecaseMangeBook.favoriteToggle(Book(
        id: book.id,
        title: book.title,
        author: book.author,
        coverUrl: book.coverUrl,
        downloadUrl: book.downloadUrl,
        favorite: insertfavorite));
    controller.isToggleFavorite();
    await initStateList();
  }

  Future<List<BookEntity>?> fazconsular() async {
    final response = await usecaseMangeBook.getAllBooksFavorite();
    return response.fold((l) => null, (r) => r);
  }
}
