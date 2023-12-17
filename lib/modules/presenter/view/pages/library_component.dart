import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';

import 'package:ebook_escribo/modules/domain/entity/book_entity.dart';
import 'package:ebook_escribo/modules/presenter/view/components/animation_is_empty.dart';
import 'package:ebook_escribo/modules/presenter/view/components/animation_sub_title.dart';
import 'package:ebook_escribo/modules/presenter/view/components/grid_view_component.dart';
import 'package:ebook_escribo/modules/presenter/view/components/home_view.dart';

class LibraryComponent extends StatefulWidget {
  const LibraryComponent({
    super.key,
    required this.page,
    required this.controllerBook,
  });

  final ObservableList<BookEntity> controllerBook;
  final int page;

  @override
  State<LibraryComponent> createState() => _LibraryComponentState();
}

class _LibraryComponentState extends State<LibraryComponent> {
  bool isanimatedTitle = false;
  bool isfavorite = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Observer(builder: (context) {
        return widget.controllerBook.isEmpty
            ? Semantics(
                label:
                    "não encontrados livros para a aba ${widget.page == 0 ? "biblioteca" : widget.page == 1 ? "baixados" : "favoritos"}",
                child: const AnimationIsEmpty())
            : Semantics(
                label:
                    "Listagem de livros da aba ${widget.page == 0 ? "biblioteca" : widget.page == 1 ? "baixados" : "favoritos"}",
                child: Column(
                  children: [
                    Container(
                      color: Colors.white,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 30, vertical: 20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const AnimationTitle(),
                                AnimationSubTitle(
                                    isanimatedTitle: isanimatedTitle),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    GridViewComponent(
                        listEntity: widget.controllerBook, pages: widget.page),
                  ],
                ),
              );
      }),
    );
  }
}
