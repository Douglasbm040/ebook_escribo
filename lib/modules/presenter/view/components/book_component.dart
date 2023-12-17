import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'package:ebook_escribo/modules/domain/entity/book_entity.dart';
import 'package:ebook_escribo/modules/presenter/controller/bookcontroller.dart';
import 'package:ebook_escribo/modules/presenter/controller/controller.dart';

class BookComponent extends StatefulWidget {
  const BookComponent({
    super.key,
    required this.itembook,
    required this.pages,
  });
  final BookEntity itembook;
  final int pages;

  @override
  State<BookComponent> createState() => _BookComponentState();
}

class _BookComponentState extends State<BookComponent> {
  final Controller controller = Modular.get<Controller>();
  final BookController bookcontroller = Modular.get<BookController>();
  ScaffoldMessengerState? _scaffoldMessenger;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _scaffoldMessenger = ScaffoldMessenger.of(context);
  }

  @override
  void dispose() {
    _scaffoldMessenger?.hideCurrentSnackBar();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isfavorite = widget.itembook.favorite == 1 ? true : false;
    if (widget.pages == 0) {
      List<BookEntity> booksFavorite = [];
      Modular.get<Controller>().fazconsular().then((value) {
        booksFavorite = value ?? [];
        for (var element in booksFavorite) {
          if (element.id == widget.itembook.id) {
            isfavorite = true;
          }
          bookcontroller.iniState(isfavorite);
        }
      });
    }
    bookcontroller.iniState(isfavorite);
    return Observer(builder: (context) {
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
                Semantics(
                  label:
                      "Livro ${widget.itembook.title} do ${widget.itembook.author}  ${widget.itembook.favorite == 1 ? "marcado como favorito" : "não marcado como favorito"} clique para baixar para favoritar",
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: InkWell(
                        onTap: () async {
                          await onTapBook();
                        },
                        child: SizedBox(
                          width: 300,
                          height: 250,
                          child: Image(
                              fit: BoxFit.fill,
                              image: CachedNetworkImageProvider(
                                widget.itembook.coverUrl,
                              ),
                              loadingBuilder:
                                  (context, child, loadingProgress) {
                                if (loadingProgress == null) {
                                  return child;
                                }
                                return const CircularProgressIndicator();
                              }),
                        ),
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
                  await onFavoriteToglle();
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
              )),
        ],
      );
    });
  }

  Future<void> onFavoriteToglle() async {
    await Modular.get<Controller>()
        .isToggleFavorite(widget.itembook, bookcontroller);
                     var snackBar = SnackBar(
      content: Text(bookcontroller.favorite
          ? "Livro favoritado"
          : "Livro desfavoritado"),
      duration: const Duration(seconds: 1),
    );
      _scaffoldMessenger?.showSnackBar(snackBar);
  }

  Future<void> onTapBook() async {
               if (widget.pages == 0 || widget.pages == 2) {
      var snackBar = const SnackBar(
        content: Text("Baixando ..."),
        duration:
            Duration(seconds: 2), // Duração da exibição
      );
      Semantics(label: "baixando");
      _scaffoldMessenger?.showSnackBar(snackBar);
      String texto = await Modular.get<Controller>()
          .downloadBook(widget.itembook);
      snackBar = SnackBar(
        content: Text(texto),
        duration: const Duration(
            seconds: 3), // Duração da exibição
      );
      Semantics(label: texto);
      _scaffoldMessenger?.showSnackBar(snackBar);
    } else {
      if (widget.itembook.path != null) {
        Modular.to.pushNamed("/read",
            arguments: widget.itembook);
      }
    }
  }
}
