import 'package:ebook_escribo/modules/domain/entity/book_entity.dart';
import 'package:ebook_escribo/modules/domain/usecases/manager_books_usecase.dart';
import 'package:ebook_escribo/modules/presenter/controller/bookcontroller.dart';
import 'package:ebook_escribo/modules/presenter/view/home_view.dart';
import 'package:ebook_escribo/modules/presenter/view/read_view.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'domain/repositories/imanage_book_repository.dart';
import 'domain/repositories/request_book_repository.dart';
import 'domain/usecases/request_book_usecase.dart';
import 'external/datasource/http_datasource.dart';
import 'infra/datasources/imanager_book_datasource.dart';
import 'infra/datasources/request_book_external.dart';
import 'package:http/http.dart' as http;

import 'infra/repositories/manager_book_repository_impl.dart';
import 'infra/repositories/resquest_book_repository_impl.dart';
import 'presenter/controller/controller.dart';

class AppModule extends Module {
  final IManagerBookDatasource Function() database;

  AppModule(this.database);
  @override
  void exportedBinds(Injector i) {
    i.add<IRequestBookUseCase>(RequestBookUseCase.new);
    i.add<IManageBooksUseCase>(ManageBooksUseCase.new);
    i.add<Controller>(Controller.new);
    i.add<BookController>(BookController.new);
     i.add<BookEntity>(BookEntity.new);
  }

  @override
  void binds(Injector i) async {
    //! request book - http
    i.add<http.Client>(http.Client.new);
    i.add<IRequestBookDatasource>(HttpDatasource.new);
    i.add<IRequestBookRepository>(RequestBookRepositoryImpl.new);
    i.add<IRequestBookUseCase>(RequestBookUseCase.new);
    //! manage book - sqlite
    i.add<IManagerBookDatasource>(database);
    i.add<IManageBookRepository>(ManagerBookRepositoryImpl.new);
    i.add<IManageBooksUseCase>(ManageBooksUseCase.new);

    //!controller
    i.add<Controller>(Controller.new);
    i.add<BookController>(BookController.new);

    //!entities
    i.add<BookEntity>(BookEntity.new);
  }

  @override
  void routes(r) {
    r.child('/', child: (context) => const HomeView(), children: []);
    r.child('/read', child: (context) => const ReadView());
  }
}
