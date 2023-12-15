// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bookcontroller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$BookController on _BookControllerBase, Store {
  late final _$bookAtom =
      Atom(name: '_BookControllerBase.book', context: context);

  @override
  BookEntity? get book {
    _$bookAtom.reportRead();
    return super.book;
  }

  @override
  set book(BookEntity? value) {
    _$bookAtom.reportWrite(value, super.book, () {
      super.book = value;
    });
  }

  late final _$isToggleFavoriteAsyncAction =
      AsyncAction('_BookControllerBase.isToggleFavorite', context: context);

  @override
  Future<void> isToggleFavorite(BookEntity book) {
    return _$isToggleFavoriteAsyncAction
        .run(() => super.isToggleFavorite(book));
  }

  @override
  String toString() {
    return '''
book: ${book}
    ''';
  }
}
