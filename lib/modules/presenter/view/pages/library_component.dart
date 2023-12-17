import 'package:ebook_escribo/modules/domain/entity/book_entity.dart';
import 'package:ebook_escribo/modules/presenter/controller/bookcontroller.dart';
import 'package:ebook_escribo/modules/presenter/view/components/animation_is_empty.dart';
import 'package:ebook_escribo/modules/presenter/view/components/animation_sub_title.dart';
import 'package:ebook_escribo/modules/presenter/view/components/grid_view_component.dart';
import 'package:ebook_escribo/modules/presenter/view/components/home_view.dart';
import 'package:ebook_escribo/modules/presenter/view/home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';

class libraryComponent extends StatefulWidget {
  const libraryComponent({
    super.key,
    required this.page,
    required this.controllerBook,
  });

  final ObservableList<BookEntity> controllerBook;
  final int page;

  @override
  State<libraryComponent> createState() => _libraryComponentState();
}

class _libraryComponentState extends State<libraryComponent> {
  bool isanimatedTitle = false;
  bool isfavorite = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Observer(builder: (context) {
        return widget.controllerBook.isEmpty
            ? const AnimationIsEmpty()
            : Column(
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
                      listEntity: widget.controllerBook,
                    
                      pages: widget.page),
                ],
              );
      }),
    );
  }
}
