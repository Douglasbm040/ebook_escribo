// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bookcontroller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$BookController on _BookControllerBase, Store {
  late final _$favoriteAtom =
      Atom(name: '_BookControllerBase.favorite', context: context);

  @override
  bool get favorite {
    _$favoriteAtom.reportRead();
    return super.favorite;
  }

  @override
  set favorite(bool value) {
    _$favoriteAtom.reportWrite(value, super.favorite, () {
      super.favorite = value;
    });
  }

  late final _$_BookControllerBaseActionController =
      ActionController(name: '_BookControllerBase', context: context);

  @override
  void iniState(bool favorite) {
    final _$actionInfo = _$_BookControllerBaseActionController.startAction(
        name: '_BookControllerBase.iniState');
    try {
      return super.iniState(favorite);
    } finally {
      _$_BookControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic isToggleFavorite() {
    final _$actionInfo = _$_BookControllerBaseActionController.startAction(
        name: '_BookControllerBase.isToggleFavorite');
    try {
      return super.isToggleFavorite();
    } finally {
      _$_BookControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
favorite: ${favorite}
    ''';
  }
}
