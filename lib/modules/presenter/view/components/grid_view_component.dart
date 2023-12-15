import 'package:ebook_escribo/modules/domain/entity/book_entity.dart';
import 'package:ebook_escribo/modules/presenter/view/components/animation_book_loading.dart';
import 'package:ebook_escribo/modules/presenter/view/components/book_component.dart';
import 'package:flutter/material.dart';

class GridViewComponent extends StatelessWidget {
  const GridViewComponent({
    super.key,
    this.listBook,
  });

  final List<BookEntity>? listBook;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 6,
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 5.0,
            mainAxisSpacing: 5.0,
            childAspectRatio: .6),
        itemCount: listBook?.length,
        itemBuilder: (BuildContext context, int index) {
          return listBook?[index] == null
              ? const AnimationBookLoading()
              : BookComponent(book: listBook![index]);
        },
      ),
    );
  }
}
