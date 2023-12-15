import 'package:ebook_escribo/modules/domain/entity/book_entity.dart';
import 'package:ebook_escribo/modules/presenter/view/components/animation_is_empty.dart';
import 'package:ebook_escribo/modules/presenter/view/components/animation_sub_title.dart';
import 'package:ebook_escribo/modules/presenter/view/components/grid_view_component.dart';
import 'package:ebook_escribo/modules/presenter/view/components/home_view.dart';
import 'package:ebook_escribo/modules/presenter/view/home_view.dart';
import 'package:flutter/material.dart';

class libraryComponent extends StatefulWidget {
  const libraryComponent({
    super.key,
    required this.controller,
  });
  final Future<List<BookEntity>?> controller;

  @override
  State<libraryComponent> createState() => _libraryComponentState();
}

class _libraryComponentState extends State<libraryComponent> {
  bool isanimatedTitle = false;
  bool isfavorite = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: FutureBuilder<List<BookEntity>?>(
          future: widget.controller,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }
            return snapshot.data?.length == 0
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
                      GridViewComponent(listBook: snapshot.data),
                    ],
                  );
          }),
    );
  }
}
