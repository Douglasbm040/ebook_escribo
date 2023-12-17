// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import 'package:ebook_escribo/modules/domain/entity/book_entity.dart';
import 'package:ebook_escribo/modules/domain/usecases/manager_books_usecase.dart';
import 'package:ebook_escribo/modules/infra/model/book.dart';
import 'package:ebook_escribo/modules/presenter/controller/controller.dart';

part 'bookcontroller.g.dart';

class BookController = _BookControllerBase with _$BookController;

abstract class _BookControllerBase with Store {
  IManageBooksUseCase usecaseMangeBook = Modular.get<IManageBooksUseCase>();
  Controller controller = Modular.get<Controller>();
  @observable
  bool favorite = false;

  @action
  void iniState(bool favorite) {
    this.favorite = favorite;
  }

  @action
  _BookControllerBase? atualizar(int favorite) {
    this.favorite = favorite == 2 ? false : true;
  }

 

  @action
  isToggleFavorite() {
    favorite = !favorite;
  }
}
