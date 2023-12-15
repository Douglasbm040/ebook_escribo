// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$Controller on _ControllerBase, Store {
  Computed<ObservableList<bool>>? _$favoritsComputed;

  @override
  ObservableList<bool> get favorits => (_$favoritsComputed ??=
          Computed<ObservableList<bool>>(() => super.favorits,
              name: '_ControllerBase.favorits'))
      .value;

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
  ObservableList<BookController> get booksRequested {
    _$booksRequestedAtom.reportRead();
    return super.booksRequested;
  }

  @override
  set booksRequested(ObservableList<BookController> value) {
    _$booksRequestedAtom.reportWrite(value, super.booksRequested, () {
      super.booksRequested = value;
    });
  }

  late final _$booksDownloadedAtom =
      Atom(name: '_ControllerBase.booksDownloaded', context: context);

  @override
  ObservableList<BookController> get booksDownloaded {
    _$booksDownloadedAtom.reportRead();
    return super.booksDownloaded;
  }

  @override
  set booksDownloaded(ObservableList<BookController> value) {
    _$booksDownloadedAtom.reportWrite(value, super.booksDownloaded, () {
      super.booksDownloaded = value;
    });
  }

  late final _$booksFavoriteAtom =
      Atom(name: '_ControllerBase.booksFavorite', context: context);

  @override
  ObservableList<BookController> get booksFavorite {
    _$booksFavoriteAtom.reportRead();
    return super.booksFavorite;
  }

  @override
  set booksFavorite(ObservableList<BookController> value) {
    _$booksFavoriteAtom.reportWrite(value, super.booksFavorite, () {
      super.booksFavorite = value;
    });
  }

  late final _$getAllDownloadedAsyncAction =
      AsyncAction('_ControllerBase.getAllDownloaded', context: context);

  @override
  Future<List<BookEntity>?> getAllDownloaded() {
    return _$getAllDownloadedAsyncAction.run(() => super.getAllDownloaded());
  }

  late final _$getAllFavoriteAsyncAction =
      AsyncAction('_ControllerBase.getAllFavorite', context: context);

  @override
  Future<List<BookEntity>?> getAllFavorite() {
    return _$getAllFavoriteAsyncAction.run(() => super.getAllFavorite());
  }

  late final _$getAllRequestedAsyncAction =
      AsyncAction('_ControllerBase.getAllRequested', context: context);

  @override
  Future<List<BookEntity>?> getAllRequested() {
    return _$getAllRequestedAsyncAction.run(() => super.getAllRequested());
  }

  late final _$downloadBookAsyncAction =
      AsyncAction('_ControllerBase.downloadBook', context: context);

  @override
  Future<String> downloadBook(BookEntity book) {
    return _$downloadBookAsyncAction.run(() => super.downloadBook(book));
  }

  late final _$onItemTappedAsyncAction =
      AsyncAction('_ControllerBase.onItemTapped', context: context);

  @override
  Future<void> onItemTapped(int index) {
    return _$onItemTappedAsyncAction.run(() => super.onItemTapped(index));
  }

  @override
  String toString() {
    return '''
selectedIndex: ${selectedIndex},
booksRequested: ${booksRequested},
booksDownloaded: ${booksDownloaded},
booksFavorite: ${booksFavorite},
favorits: ${favorits}
    ''';
  }
}
