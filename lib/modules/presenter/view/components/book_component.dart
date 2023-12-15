import 'package:cached_network_image/cached_network_image.dart';
import 'package:ebook_escribo/modules/domain/entity/book_entity.dart';
import 'package:ebook_escribo/modules/presenter/controller/bookcontroller.dart';
import 'package:ebook_escribo/modules/presenter/controller/controller.dart';
import 'package:ebook_escribo/modules/presenter/view/home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

class BookComponent extends StatelessWidget {
  const BookComponent({
    super.key,
    required this.itembook,
    required this.pages,
  });
  final BookController itembook;
  final int pages;
  @override
  Widget build(BuildContext context) {
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
                      if (pages == 0) {
                        var snackBar = SnackBar(
                          content: Text("Baixando ..."),
                          duration: Duration(seconds: 5), // Duração da exibição
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        String texto = await Modular.get<Controller>()
                            .downloadBook(itembook.book!);
                        snackBar = SnackBar(
                          content: Text(texto),
                          duration: Duration(seconds: 3), // Duração da exibição
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      } else {
                        Modular.to.pushNamed("/read", arguments: itembook.book);
                      }
                    },
                    child: Observer(builder: (context) {
                      return SizedBox(
                        width: 300,
                        height: 250,
                        child: Image(
                            fit: BoxFit.fill,
                            image: CachedNetworkImageProvider(
                              itembook.book!.coverUrl,
                            ),
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) {
                                return child;
                              }
                              return const CircularProgressIndicator();
                            }),
                      );
                    }),
                  ),
                ),
              ),
              Observer(builder: (context) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    itembook.book!.title,
                    style: const TextStyle(
                        fontFamily: "Afacad",
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.black),
                    overflow: TextOverflow.ellipsis,
                  ),
                );
              }),
              Observer(builder: (context) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    itembook.book!.author,
                    style: const TextStyle(
                      fontFamily: "Afacad",
                      fontSize: 14,
                      color: Colors.black45,
                    ),
                  ),
                );
              }),
            ],
          ),
        ),
        Observer(builder: (context) {
          return Positioned(
              right: -1,
              child: InkWell(
                onTap: () async {
                  await Modular.get<BookController>()
                      .isToggleFavorite(itembook.book!);
                  final snackBar = SnackBar(
                    content: Text(itembook.book!.favorite == 2
                        ? "Livro favoritado"
                        : "Livro desfavoritado"),
                    duration: const Duration(seconds: 3),
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
                        itembook.book!.favorite == 2
                            ? Icons.bookmark_outlined
                            : Icons.bookmark_rounded,
                        color: itembook.book!.favorite == 2
                            ? Colors.redAccent
                            : Colors.white,
                        size: 40,
                      )),
                ),
              ));
        })
      ],
    );
  }
}
