import 'package:ebook_escribo/modules/domain/entity/book_entity.dart';
import 'package:ebook_escribo/modules/presenter/controller/bookcontroller.dart';
import 'package:ebook_escribo/modules/presenter/view/components/animation_book_loading.dart';
import 'package:ebook_escribo/modules/presenter/view/components/book_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';

class GridViewComponent extends StatefulWidget {
  const GridViewComponent({
    super.key,
    required this.listBook,
    required this.pages,
    required this.listEntity,
  });
  final int pages;
  final ObservableList<BookController> listBook;
  final ObservableList<BookEntity> listEntity;

  @override
  State<GridViewComponent> createState() => _GridViewComponentState();
}

class _GridViewComponentState extends State<GridViewComponent> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 7,
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 5.0,
            mainAxisSpacing: 5.0,
            childAspectRatio: .6),
        itemCount: widget.listEntity.length,
        itemBuilder: (BuildContext context, int index) {
          return  BookComponent(
                  itembook: widget.listEntity[index],
                  pages: widget.pages,
                  controller: widget.listBook[index],
                );
        },
      ),
    );
  }
}
