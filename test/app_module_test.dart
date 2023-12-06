import 'package:ebook_escribo/modules/app_module.dart';
import 'package:ebook_escribo/modules/domain/usecase/request_livros.dart';
import 'package:ebook_escribo/modules/infra/repositories/resquest_book_repository_impl.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Modular.bindModule(AppModule());
   test('deve recuperar a instancia de RequestBookimpl sem erro ', () {
      final usecase = Modular.get<RequestBookRepositoryImpl>();
      expect(usecase, isA<RequestBookRepositoryImpl>());
   });
}