import 'package:ebook_escribo/modules/domain/entity/book_entity.dart';
import 'package:ebook_escribo/modules/presenter/view/components/animation_book_loading.dart';
import 'package:ebook_escribo/modules/presenter/view/components/book_component.dart';
import 'package:flutter/material.dart';

class GridViewComponent extends StatefulWidget {
  const GridViewComponent({
    super.key,
    this.listBook, required this.pages,
  });
  final int pages;
  final List<BookEntity>? listBook;

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
        itemCount: widget.listBook?.length,
        itemBuilder: (BuildContext context, int index) {
          return widget.listBook?[index] == null
              ? const AnimationBookLoading()
              : BookComponent(book: widget.listBook![index],pages:widget.pages);
        },
      ),
    );
  }
}
