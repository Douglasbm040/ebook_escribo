// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$Controller on _ControllerBase, Store {
  late final _$selectedIndexAtom =
      Atom(name: '_ControllerBase.selectedIndex', context: context);

  @override
  int get selectedIndex {
    _$selectedIndexAtom.reportRead();
    return super.selectedIndex;
  }

  @override
  set selectedIndex(int value) {
    _$selectedIndexAtom.reportWrite(value, super.selectedIndex, () {
      super.selectedIndex = value;
    });
  }

  late final _$booksRequestedAtom =
      Atom(name: '_ControllerBase.booksRequested', context: context);

  @override
  ObservableList<BookEntity> get booksRequested {
    _$booksRequestedAtom.reportRead();
    return super.booksRequested;
  }

  @override
  set booksRequested(ObservableList<BookEntity> value) {
    _$booksRequestedAtom.reportWrite(value, super.booksRequested, () {
      super.booksRequested = value;
    });
  }

  late final _$booksDownloadedAtom =
      Atom(name: '_ControllerBase.booksDownloaded', context: context);

  @override
  ObservableList<BookEntity> get booksDownloaded {
    _$booksDownloadedAtom.reportRead();
    return super.booksDownloaded;
  }

  @override
  set booksDownloaded(ObservableList<BookEntity> value) {
    _$booksDownloadedAtom.reportWrite(value, super.booksDownloaded, () {
      super.booksDownloaded = value;
    });
  }

  late final _$booksFavoriteAtom =
      Atom(name: '_ControllerBase.booksFavorite', context: context);

  @override
  ObservableList<BookEntity> get booksFavorite {
    _$booksFavoriteAtom.reportRead();
    return super.booksFavorite;
  }

  @override
  set booksFavorite(ObservableList<BookEntity> value) {
    _$booksFavoriteAtom.reportWrite(value, super.booksFavorite, () {
      super.booksFavorite = value;
    });
  }

  late final _$favoriteRequestedAtom =
      Atom(name: '_ControllerBase.favoriteRequested', context: context);

  @override
  ObservableList<BookController> get favoriteRequested {
    _$favoriteRequestedAtom.reportRead();
    return super.favoriteRequested;
  }

  @override
  set favoriteRequested(ObservableList<BookController> value) {
    _$favoriteRequestedAtom.reportWrite(value, super.favoriteRequested, () {
      super.favoriteRequested = value;
    });
  }

  late final _$favoriteDownloadedAtom =
      Atom(name: '_ControllerBase.favoriteDownloaded', context: context);

  @override
  ObservableList<BookController> get favoriteDownloaded {
    _$favoriteDownloadedAtom.reportRead();
    return super.favoriteDownloaded;
  }

  @override
  set favoriteDownloaded(ObservableList<BookController> value) {
    _$favoriteDownloadedAtom.reportWrite(value, super.favoriteDownloaded, () {
      super.favoriteDownloaded = value;
    });
  }

  late final _$favoriteBooksAtom =
      Atom(name: '_ControllerBase.favoriteBooks', context: context);

  @override
  ObservableList<BookController> get favoriteBooks {
    _$favoriteBooksAtom.reportRead();
    return super.favoriteBooks;
  }

  @override
  set favoriteBooks(ObservableList<BookController> value) {
    _$favoriteBooksAtom.reportWrite(value, super.favoriteBooks, () {
      super.favoriteBooks = value;
    });
  }

  late final _$getAllDownloadedAsyncAction =
      AsyncAction('_ControllerBase.getAllDownloaded', context: context);

  @override
  Future<void> getAllDownloaded() {
    return _$getAllDownloadedAsyncAction.run(() => super.getAllDownloaded());
  }

  late final _$getAllFavoriteAsyncAction =
      AsyncAction('_ControllerBase.getAllFavorite', context: context);

  @override
  Future<void> getAllFavorite() {
    return _$getAllFavoriteAsyncAction.run(() => super.getAllFavorite());
  }

  late final _$getAllRequestedAsyncAction =
      AsyncAction('_ControllerBase.getAllRequested', context: context);

  @override
  Future<void> getAllRequested() {
    return _$getAllRequestedAsyncAction.run(() => super.getAllRequested());
  }

  late final _$downloadBookAsyncAction =
      AsyncAction('_ControllerBase.downloadBook', context: context);

  @override
  Future<String> downloadBook(BookEntity book) {
    return _$downloadBookAsyncAction.run(() => super.downloadBook(book));
  }

  late final _$initStateListAsyncAction =
      AsyncAction('_ControllerBase.initStateList', context: context);

  @override
  Future<void> initStateList() {
    return _$initStateListAsyncAction.run(() => super.initStateList());
  }

  late final _$onItemTappedAsyncAction =
      AsyncAction('_ControllerBase.onItemTapped', context: context);

  @override
  Future<void> onItemTapped(int index) {
    return _$onItemTappedAsyncAction.run(() => super.onItemTapped(index));
  }

  late final _$isToggleFavoriteAsyncAction =
      AsyncAction('_ControllerBase.isToggleFavorite', context: context);

  @override
  Future<void> isToggleFavorite(BookEntity book, BookController controller) {
    return _$isToggleFavoriteAsyncAction
        .run(() => super.isToggleFavorite(book, controller));
  }

  @override
  String toString() {
    return '''
selectedIndex: ${selectedIndex},
booksRequested: ${booksRequested},
booksDownloaded: ${booksDownloaded},
booksFavorite: ${booksFavorite},
favoriteRequested: ${favoriteRequested},
favoriteDownloaded: ${favoriteDownloaded},
favoriteBooks: ${favoriteBooks}
    ''';
  }
}
