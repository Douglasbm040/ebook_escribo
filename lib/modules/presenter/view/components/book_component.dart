import 'package:cached_network_image/cached_network_image.dart';
import 'package:ebook_escribo/modules/domain/entity/book_entity.dart';
import 'package:ebook_escribo/modules/infra/model/book.dart';
import 'package:ebook_escribo/modules/presenter/controller/bookcontroller.dart';
import 'package:ebook_escribo/modules/presenter/controller/controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

class BookComponent extends StatefulWidget {
  const BookComponent({
    super.key,
    required this.itembook,
    required this.pages,
    required this.controller,
  });
  final BookEntity itembook;
  final int pages;
  final BookController controller;

  @override
  State<BookComponent> createState() => _BookComponentState();
}

class _BookComponentState extends State<BookComponent> {
  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      BookController bookcontroller = widget.controller;
      return Stack(
        children: [
          Card(
            shadowColor: Colors.white,
            color: Colors.white,
            elevation: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: InkWell(
                      onTap: () async {
                        if (widget.pages == 0) {
                          var snackBar = const SnackBar(
                            content: Text("Baixando ..."),
                            duration:
                                Duration(seconds: 5), // Duração da e;})xibição
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          String texto = await Modular.get<Controller>()
                              .downloadBook(widget.itembook);
                          snackBar = SnackBar(
                            content: Text(texto),
                            duration: const Duration(
                                seconds: 3), // Duração da exibição
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        } else {
                          if (widget.itembook.path != null) {
                            Modular.to
                                .pushNamed("/read", arguments: widget.itembook);
                          }
                          int x = 0;
                          while (widget.itembook.path != null || x == 4) {
                            String texto = await Modular.get<Controller>()
                                .downloadBook(widget.itembook);
                            x++;
                          }
                        }
                      },
                      child: SizedBox(
                        width: 300,
                        height: 250,
                        child:  Image(
                            fit: BoxFit.fill,
                            image: CachedNetworkImageProvider(
                              widget.itembook.coverUrl,
                            ),
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) {
                                return child;
                              }
                              return const CircularProgressIndicator();
                            }),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    widget.itembook.title,
                    style: const TextStyle(
                        fontFamily: "Afacad",
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.black),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    widget.itembook.author,
                    style: const TextStyle(
                      fontFamily: "Afacad",
                      fontSize: 14,
                      color: Colors.black45,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
              right: -1,
              child: InkWell(
                onTap: () async {
                  await Modular.get<Controller>()
                      .isToggleFavorite(widget.itembook, bookcontroller);
                  final snackBar = SnackBar(
                    content: Text(bookcontroller.favorite
                        ? "Livro favoritado"
                        : "Livro desfavoritado"),
                    duration: const Duration(seconds: 1),
                  );

                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                },
                child: CircleAvatar(
                  radius: 25,
                  backgroundColor: Colors.grey[200],
                  child: CircleAvatar(
                      radius: 22,
                      backgroundColor: Colors.amber,
                      child: Icon(
                        bookcontroller.favorite
                            ? Icons.bookmark_outlined
                            : Icons.bookmark_rounded,
                        color: bookcontroller.favorite
                            ? Colors.redAccent
                            : Colors.white,
                        size: 40,
                      )),
                ),
              ))
        ],
      );
    });
  }
}
