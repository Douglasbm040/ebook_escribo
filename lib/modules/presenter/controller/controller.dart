import 'package:ebook_escribo/modules/domain/usecases/request_book_usecase.dart';
import 'package:ebook_escribo/modules/infra/model/book.dart';
import 'package:ebook_escribo/modules/presenter/controller/bookcontroller.dart';
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
  ObservableList<BookEntity> booksRequested = ObservableList<BookEntity>();
  @observable
  ObservableList<BookEntity> booksDownloaded = ObservableList<BookEntity>();
  @observable
  ObservableList<BookEntity> booksFavorite = ObservableList<BookEntity>();

  List<ObservableList<BookEntity>> listObserver() =>
      [booksRequested, booksDownloaded, booksFavorite];

  List<ObservableList<BookController>> listfavoriteObserver() =>
      [favoriteRequested, favoriteDownloaded, favoriteBooks];

  @observable
  ObservableList<BookController> favoriteRequested =
      ObservableList<BookController>();
  @observable
  ObservableList<BookController> favoriteDownloaded =
      ObservableList<BookController>();
  @observable
  ObservableList<BookController> favoriteBooks =
      ObservableList<BookController>();

  @action
  Future<List<BookEntity>?> getAllDownloaded() async {
    favoriteDownloaded.clear();
    booksDownloaded.clear();
    List<BookEntity>? listBooks = [];
    final response = await usecaseMangeBook.getAllDownloaded();
    response.fold((l) => null, (r) => listBooks = r);
    listBooks?.forEach((e) {
      booksDownloaded.add(e);
      favoriteDownloaded.add(
          BookController(favorite: e.favorite == 1 ? true : false, id: e.id));
    });
  }

  @action
  Future<List<BookEntity>?> getAllFavorite() async {
    booksFavorite.clear();
    favoriteBooks.clear();
    List<BookEntity>? listBooks = [];
    final response = await usecaseMangeBook.getAllBooksFavorite();
    response.fold((l) => null, (r) => listBooks = r);
    listBooks?.forEach((e) {
      booksFavorite.add(e);
      favoriteBooks.add(
          BookController(favorite: e.favorite == 1 ? true : false, id: e.id));
    });
  }

  @action
  Future<List<BookEntity>?> getAllRequested() async {
    booksRequested.clear();
    favoriteRequested.clear();
    List<BookEntity>? _booksRequested = [];
    final response = await usecaseResquestBook.getBooks("/books.json");
    response.fold((l) => null, (r) => _booksRequested = r);
    _booksRequested?.forEach((e) {
      booksRequested.add(e);
      favoriteRequested.add(
          BookController(favorite: e.favorite == 1 ? true : false, id: e.id));
    });
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
      switch (transation) {
        case 1:
          initStateList();
          return "você já possue este livro";

        case 2:
          initStateList();

          return "O livro foi adicionado a sua lista de downloads";
        default:
          return "Erro ao baixar o livro,por favor verifique sua conexão";
      }
    }
    return "ops... ocorreu um erro ao baixar o livro, tente novamente mais tarde";
  }

  @action
  Future<void> initStateList() async {
    await getAllDownloaded();
    await getAllFavorite();
    await getAllRequested();
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

  @action
  Future<void> isToggleFavorite(
      BookEntity book, BookController controller) async {
    int insertfavorite = controller.favorite ? 2 : 1;
    print("qual valor esta entrando $insertfavorite");
    await usecaseMangeBook.favoriteToggle(Book(
        id: book.id,
        title: book.title,
        author: book.author,
        coverUrl: book.coverUrl,
        downloadUrl: book.downloadUrl,
        favorite: insertfavorite));
    controller.isToggleFavorite();
    await initStateList();

    print("qual ta saindo ${controller.favorite}");
  }
}
